import '../../../models/UserData.dart';

abstract class HomeStates {}

class  HomeInitialState extends HomeStates {}


class HomeChangeBottomNav extends HomeStates {}
class HomeChangeRadio extends HomeStates {}

class HomePostImagePickedSuccessState extends HomeStates {}
class HomePostImagePickedErrorState extends HomeStates {}

class HomeRemovePostImageState extends HomeStates {}

class ChangeLocalState extends HomeStates{}

class LoadingGetUserData extends HomeStates {}
class SuccessGetUserData extends HomeStates {}


class HomePostEquipmentLoadingState extends HomeStates {}
class HomePostEquipmentSuccessState extends HomeStates {}
class HomePostEquipmentErrorState extends HomeStates {}

class LoadingVerifyEmail extends HomeStates {}
class SuccessVerifyEmail extends HomeStates {}

class LoadingUpdateUSERState extends HomeStates {}
class SuccessUpdateUSERState extends HomeStates {}
class ErrorUpdateUSERState extends HomeStates {}


class HomeSetCategory extends HomeStates {}
class HomeSetGovernment extends HomeStates {}

class DelayFunctionState extends HomeStates {}

class HomeProfileImagePickedSuccessState extends HomeStates {}
class HomeProfileImagePickedErrorState extends HomeStates {}


