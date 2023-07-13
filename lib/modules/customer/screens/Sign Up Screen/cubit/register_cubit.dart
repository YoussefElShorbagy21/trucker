import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/models/signupmodel.dart';
import 'package:login/shared/components/constants.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/network/local/cache_helper.dart';
import '../../../../../shared/network/remote/dio_helper.dart';
import 'register_state.dart';
import 'package:image_picker/image_picker.dart';
class RegisterCubit extends Cubit<RegisterState> {
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
      if(error is DioError)
      {
        print(error.response);
        print(error.response!.data['message']);
        print(error.message);
        emit(ErrorUpdatePassword(error.response!.data['message']));
      }
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
      emit(SuccessVerifyEmail())
    }).catchError((onError){
      if(onError is DioError)
      {
        print(onError.response);
        print(onError.response!.data['message']);
        print(onError.message);
        clearText = true ;
        emit(ErrorVerifyEmail(onError.response!.data['message']));
      }
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
      if(onError is DioError)
      {
        print(onError.response);
        print(onError.response!.data['message']);
        print(onError.message);
        emit(ErrorVerifyEmailAgain(onError.response!.data['message']));
      }
    });
  }

  var nationalIdController = TextEditingController();
  var drivingLicenseController = TextEditingController();
  DateTime date = DateTime.now();

  void imageOCR({required File photo,}) async{
      emit(LoadingOCRPostState());
      FormData formData = FormData.fromMap({
        "image" : await MultipartFile.fromFile(photo.path),
      });
      DioHelper.postData(
        data: formData,
        url: 'users/ocr',
      ).then((value)
      {
        var data = value.data['ocrResult'].toString().split("\n") ;
        print(data);
        List<String> natid = ['', ''];
        for (var index = 0; index < data.length; index++) {
          if (data[index].length == 14 && int.tryParse(data[index]) != null) {
            natid[0] = data[index];
            print(natid);
            nationalIdController.text = natid[0];
          }
        }
        print(nationalIdController.text);
        print('go inside driver license');
        ////////////////////////////////////////////////////
        for (var index = 0; index < data.length; index++) {
          if (data[index].contains('نهاية الترخيص') || data[index].contains('الترخيص')) {
            if (data[index].length > 22 && data[index].contains('/') && data[index].contains(':')) {
              print('go inside if 1 driver license');
              print(data[index].substring(15));
              final datas = data[index].substring(15).split('/');
              print('object2');
              for (var index = 0; index < datas.length; index++) {
                print('inside for');
                datas[index] = conv2EnNum(datas[index]).toString();
                print(conv2EnNum(datas[index]).toString());
                print(datas);
              }

              final finalDate = '${datas[0]}/${datas[1]}/${datas[2]}';
              final givenDate = DateFormat('yyyy/MM/dd').parse(finalDate);
              if (date.year < givenDate.year) {
                print('finalDate: $finalDate');
                natid[1] = finalDate;
              }
            }
            else if (data[index].length > 20 && data[index].contains('-') && data[index].contains(':')) {
              print('go inside if 2 driver license');
              print(data[index].substring(16));
              final datas = data[index].substring(16).split('-');
              for (var index = 0; index < datas.length; index++) {
                datas[index] = conv2EnNum(datas[index]).toString();
              }

              final finalDate = '${datas[2]}/${datas[1]}/${datas[0]}';
              final givenDate = DateFormat('yyyy/MM/dd').parse(finalDate);
              if (date.year < givenDate.year) {
                print('finalDate:$finalDate');
                natid[1] = finalDate;
              }
            }
            else if (data[index].length > 22 && data[index].contains('/') && !data[index].contains(':')) {
              print('go inside if 3 driver license');
              print(data[index].substring(14));
              final datas = data[index].substring(14).split('/');
              for (var index = 0; index < datas.length; index++) {
                datas[index] = conv2EnNum(datas[index]).toString();
              }

              final finalDate = '${datas[0]}/${datas[1]}/${datas[2]}';
              final givenDate = DateFormat('yyyy/MM/dd').parse(finalDate);
              if (date.year < givenDate.year) {
                print('finalDate:$finalDate');
                natid[1] = finalDate;
              }
            }
            else if (data[index].length > 20 && data[index].contains('-') && !data[index].contains(':')) {
              final datas = data[index].substring(14).split('-');
              print(datas);
              for (var index = 0; index < datas.length; index++) {
                datas[index] = conv2EnNum(datas[index]).toString();
                print(datas[index]);
              }
              final finalDate = '${datas[2]}/${datas[1]}/${datas[0]}';
              final givenDate = DateFormat('yyyy/MM/dd').parse(finalDate);
              print('finalDate:$finalDate');
              print('givenDate:$givenDate');
              print(date.year);
              print(givenDate.year);
              if (date.year < givenDate.year) {
                print('finalDate:$finalDate');
                natid[1] = finalDate;
              }
            }
          }
        }
        print('go inside outside driver license');
        final givenDate = DateFormat('yyyy/MM/dd').parse(natid[1]);
        print(givenDate);
        if (givenDate.year > date.year && int.tryParse(natid[0]) != null) {
          print('NaTid');
          nationalIdController.text = natid[0];
          drivingLicenseController.text = natid[1];
        } else {
          print('error');
        }
        emit(SuccessOCRPostState());
        postImageOCR = null ;
      }).catchError((error){
        if(error is DioError){
          print(error.response!.data);
          emit(ErrorOCRPostState(error.response!.data['message']));
        }
      });

  }

  int conv2EnNum(String str) {
    // Convert Arabic numerals
    String arabicRegex = RegExp(r'[٠١٢٣٤٥٦٧٨٩]').pattern;
    String arabicStr = str.replaceAllMapped(RegExp(arabicRegex), (match) {
      return String.fromCharCode(match.group(0)!.codeUnitAt(0) - 1632 + 48);
    });

    // Convert Persian numerals
    String persianRegex = RegExp(r'[۰۱۲۳۴۵۶۷۸۹]').pattern;
    String englishStr = arabicStr.replaceAllMapped(RegExp(persianRegex), (match) {
      return String.fromCharCode(match.group(0)!.codeUnitAt(0) - 1776 + 48);
    });

    // Convert the resulting string to a double
    return int.tryParse(englishStr) ?? 0;
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