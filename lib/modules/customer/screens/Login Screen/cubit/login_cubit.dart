import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/shared/network/remote/dio_helper.dart';
import '../../../../../models/loginmodel.dart';
import 'login_state.dart';
import 'package:dio/dio.dart';


class LoginCubit extends Cubit<LoginState>
{
  late LoginModel model ;

  LoginCubit() : super(LoginInitialState()) ;
  static LoginCubit get(context) => BlocProvider.of(context) ;

  void userLogin({
    required String email,
    required String password,
  })

  {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: 'users/login',
      data:
      {
        'email':email,
        'password':password,
      },
    ).then((value)
    {
      if (kDebugMode) {
        print("postData");
      }
      if (kDebugMode) {
        print(value.data);
      }
      model = LoginModel.fromJson(value.data) ;
      emit(LoginSuccessState(model));
    }).catchError((onError){
      if(onError is DioError)
        {
          print(onError.response!.data['message']);
          print(onError.message);
          emit(LoginErrorState(onError.response!.data['message']));
        }
    });
  }

  IconData suffix = Icons.visibility_outlined ;
  bool isPasswordShown = true ;


  void changePasswordVisibility() {
    if (kDebugMode) {
      print('changePasswordVisibility');
    }
    isPasswordShown = !isPasswordShown ;
    suffix =   isPasswordShown ?  Icons.visibility_outlined  : Icons.visibility_off_outlined ;
    emit(ChangePasswordVisibilityState());

  }

  void forgotPassword({
    required String email
  })
  {
    emit(ForgotPasswordLoadingState());
    DioHelper.postData(
      url: 'users/forgotPassword',
      data:
      {
        'email':email,
      },
    ).then((value)
    {
      if (kDebugMode) {
        print("postData");
      }
      if (kDebugMode) {
        print(value.data);
      }
      model = LoginModel.fromJson(value.data) ;
      emit(ForgotPasswordSuccessState());
    }).catchError((onError){
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(ForgotPasswordErrorState());
    });
  }
}