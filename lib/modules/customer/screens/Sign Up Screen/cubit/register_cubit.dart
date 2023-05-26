import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/models/signupmodel.dart';
import 'package:login/shared/components/constants.dart';

import '../../../../../shared/network/local/cache_helper.dart';
import '../../../../../shared/network/remote/dio_helper.dart';
import 'register_state.dart';
import 'package:image_picker/image_picker.dart';
class RegisterCubit extends Cubit<RegisterState>
{
  RegisterCubit() : super(RegisterInitialState()) ;

  SignupModel model = SignupModel(status: '', token: '', userSignupModel: UserSignupModel(id: ''));

  static RegisterCubit get(context) => BlocProvider.of(context) ;

  void userSignup({
    required String name ,
    required String email,
    required String password,
    required String confirmPassword ,
    required String phone ,
    required String role,
  })
  {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: 'users/signup',
      data:
      {
        'name' : name,
        'email' : email,
        'password': password,
        'passwordConfirm' : confirmPassword,
        'phone' : phone,
        'role' : role,
      },
    ).then((value)
    {
      if (kDebugMode) {
        print(value.data);
      }
      model = SignupModel.fromJson(value.data) ;
      CacheHelper.saveData(key: 'TokenId', value: model.token);
      emit(RegisterSuccessState(model));
      print('userSignup inside Cubit $token');
      print('RegisterSuccessState inside Cubit ${model.token}');
    }).catchError((error)
    {
      if(error is DioError)
      {
        print(error.response);
        print(error.response!.data['message']);
        print(error.message);
        emit(RegisterErrorState(error.response!.data['message']));
      }
    });
  }

  IconData suffix = Icons.visibility_outlined ;
  bool isPasswordShown = true ;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown ;
    suffix =   isPasswordShown ?  Icons.visibility_outlined  : Icons.visibility_off_outlined ;

    emit(RegisterChangePasswordVisibilityState());
  }

  void updatePassword(
      {
        required String oldPassword ,
        required String newPassword ,
        required String newPasswordConfirm ,
        required BuildContext context ,
      })
  {
    emit(LoadingUpdatePassword());
    DioHelper.putData(
      url: 'users/updatePassword',
      data: {
        'oldPassword' : oldPassword ,
        'newPassword' : newPassword ,
        'newPasswordConfirm' : newPasswordConfirm ,
      },
    ).then((value)
    {
      emit(SuccessUpdatePassword());
      sinOut(context);
    }).catchError((error){
      print(error.toString());
      emit(ErrorUpdatePassword());
    });
  }
 bool clearText = false ;
  void  verifyEmail(String otpCode,String  tokenVerify){
    emit(LoadingVerifyEmail());
    DioHelper.postData(url: 'users/verfiy',
        tokenVerify: tokenVerify,
        data: {
          'otpCode':otpCode,
        }).then((value) => {
      print(value.data),
      print(token),
      print(tokenVerify),
      clearText = true ,
      emit(SuccessVerifyEmail())
    }).catchError((onError){
      print(onError.toString());
      clearText = true ;
      emit(ErrorVerifyEmail());
    });
  }

  void sendOtpAgain(String  tokenVerify){
    emit(LoadingVerifyEmailAgain());
    clearText = false ;
    DioHelper.postData(url: 'users/sendOtpAgain',
        tokenVerify: tokenVerify,
        data: {}).then((value) => {
      print(value.data),
      print(token),
      print(tokenVerify),
      emit(SuccessVerifyEmailAgain())
    }).catchError((onError){
      print(onError.toString());
      emit(ErrorVerifyEmailAgain());
    });
  }

  var nationalIdController = TextEditingController();
  var drivingLicenseController = TextEditingController();

  void imageOCR({
    required File photo,
  }) async{
      emit(LoadingOCRPostState());
      FormData formData = FormData.fromMap({
        "image" : await MultipartFile.fromFile(photo.path),
      });
      DioHelper.postOCR(
        url: 'ocr',
        data: formData,
      ).then((value)
      {
        var indexData = value.data['ocrResult'].toString().split("\n") ;
        print(indexData.length);
        print(indexData);
        for(var index = 0; index < indexData.length; index++)
          {
            if (indexData[index].length == 14 && indexData[index].contains(RegExp(r'[0-9]'))){
              nationalIdController.text = indexData[index] ;
            }
          }
        print(nationalIdController.text);
        drivingLicenseController.text = indexData[10] ;
        emit(SuccessOCRPostState());
        postImageOCR = null ;
      }).catchError((error){
        print(error.toString());
        emit(ErrorOCRPostState());
      });
  }

  File? postImageOCR ;
  var newPicker = ImagePicker();
  Future<void> getPostImageOcr(ImageSource imageSource) async  {
    final pickedFile = await newPicker.pickImage(source: imageSource);
    if(pickedFile != null) {
      postImageOCR = File(pickedFile.path) ;
      postImageOCR = await croppedImage(file: postImageOCR);
      print('New Post Image : ${postImageOCR.toString()}');
      imageOCR(photo: postImageOCR!);
      emit(PostImageOcrPickedSuccessState());
    }
    else {
      print('No image selected');
      emit(PostImageOcrPickedErrorState());
    }
  }

  Future<File?> croppedImage({required File? file}) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if(croppedFile == null) return null ;
    return File(croppedFile.path);
  }
}