import '../../../../../models/signupmodel.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final SignupModel model;
  RegisterSuccessState(this.model);
}

class RegisterErrorState extends RegisterState {
  final String error ;
  RegisterErrorState(this.error) ;
}

class RegisterChangePasswordVisibilityState extends RegisterState {}