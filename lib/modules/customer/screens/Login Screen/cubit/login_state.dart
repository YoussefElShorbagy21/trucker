import '../../../../../models/loginmodel.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState{}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginModel model;
  LoginSuccessState(this.model);
}

class LoginErrorState extends LoginState {
  final String? errorModel ;
  LoginErrorState(this.errorModel) ;
}

class ChangePasswordVisibilityState extends LoginState {}
