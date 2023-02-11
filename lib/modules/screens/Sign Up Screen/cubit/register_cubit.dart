import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/models/signupmodel.dart';

import '../../../../shared/network/remote/dio_helper.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState>
{
  RegisterCubit() : super(RegisterInitialState()) ;

  SignupModel? model ;

  static RegisterCubit get(context) => BlocProvider.of(context) ;

  void userSignup({
    required String name ,
    required String email,
    required String password,
    required String confirmPassword ,
  })
  {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: '/users/signup',
      data:
      {
        'name' : name,
        'email' : email,
        'password': password,
        'passwordConfirm' : confirmPassword,
      },
    ).then((value)
    {
      if (kDebugMode) {
        print(value.data);
      }
      if (kDebugMode) {
        print(value.data);
      }
      model = SignupModel.fromJson(value.data) ;
      if (kDebugMode) {
        print(model);
      }
      emit(RegisterSuccessState(model!));
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
}