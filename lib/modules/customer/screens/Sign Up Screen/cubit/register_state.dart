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

class LoadingUpdatePassword extends RegisterState {}
class SuccessUpdatePassword extends RegisterState {}
class ErrorUpdatePassword extends RegisterState {}

class LoadingVerifyEmail extends RegisterState {}
class SuccessVerifyEmail extends RegisterState {}
class ErrorVerifyEmail extends RegisterState {}

class LoadingVerifyEmailAgain extends RegisterState {}
class SuccessVerifyEmailAgain extends RegisterState {}
class ErrorVerifyEmailAgain extends RegisterState {}

class PostImageOcrPickedSuccessState extends RegisterState {}
class PostImageOcrPickedErrorState extends RegisterState {}

class LoadingOCRPostState extends RegisterState {}
class SuccessOCRPostState extends RegisterState {}
class ErrorOCRPostState extends RegisterState {}

