import 'package:login/models/categeiromodel.dart';

abstract class HomeScreenState {}

class  HomeScreenInitialState extends HomeScreenState {}

class  LoadingHomeDataState extends HomeScreenState {}
class  SuccessHomeDataState extends HomeScreenState {
  GetEquipment getEquipment ;
  SuccessHomeDataState(this.getEquipment);
}
class  ErrorHomeDataState extends HomeScreenState {}


class  LoadingDetailsCategoryDataState extends HomeScreenState {}
class  SuccessDetailsCategoryDataState extends HomeScreenState {}
class  ErrorDetailsCategoryDataState extends HomeScreenState {}


class  LoadingCategoryDataState extends HomeScreenState {}
class  SuccessCategoryDataState extends HomeScreenState {}
class  ErrorCategoryDataState extends HomeScreenState {}

class ChangeClickOrderButton extends HomeScreenState {}

class ChangeClickOfferButton extends HomeScreenState {}

class RefreshIndicatorHome extends HomeScreenState {}

class LoadingUpdatePostState extends HomeScreenState {}
class SuccessUpdatePostState extends HomeScreenState {}
class ErrorUpdatePostState extends HomeScreenState {}

class NewPostImagePickedSuccessState extends HomeScreenState {}
class NewPostImagePickedErrorState extends HomeScreenState {}

class LoadingGetUserData extends HomeScreenState {}
class SuccessGetUserData extends HomeScreenState {}

