import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/models/signupmodel.dart';
import 'package:login/shared/components/constants.dart';

import '../../../../../shared/network/local/cache_helper.dart';
import '../../../../../shared/network/remote/dio_helper.dart';
import 'register_state.dart';

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
      if (kDebugMode) {
        print(error.toString());
      }
      emit(RegisterErrorState(error.toString()));
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
      print(onError.toString());
      emit(ErrorVerifyEmail());
    });
  }

  void sendOtpAgain(String  tokenVerify){
    emit(LoadingVerifyEmailAgain());
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
}