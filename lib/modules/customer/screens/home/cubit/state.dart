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

class RefreshIndicatorHome extends HomeScreenState {}

class LoadingUpdatePostState extends HomeScreenState {}
class SuccessUpdatePostState extends HomeScreenState {}
class ErrorUpdatePostState extends HomeScreenState {
  final String error ;
  ErrorUpdatePostState(this.error) ;
}

class NewPostImagePickedSuccessState extends HomeScreenState {}
class NewPostImagePickedErrorState extends HomeScreenState {}

class LoadingGetUserData extends HomeScreenState {}
class SuccessGetUserData extends HomeScreenState {}

class HomeLoadingGetCategory extends HomeScreenState {}
class HomeSuccessGetCategory extends HomeScreenState {}
class HomeErrorGetCategory extends HomeScreenState {}

class HomeLoadingGetSubCategory extends HomeScreenState {}
class HomeSuccessGetSubCategory extends HomeScreenState {}
class HomeErrorGetSubCategory extends HomeScreenState {}


class HomeLoadingGetBrand extends HomeScreenState {}
class HomeSuccessGetBrand extends HomeScreenState {}
class HomeErrorGetBrand extends HomeScreenState {}


class HomeIdCategory extends HomeScreenState {}
class HomeIdSubCategory extends HomeScreenState {}
class HomeIdBrand extends HomeScreenState {}

class HomeUpdateCategory extends HomeScreenState {}
class HomeUpdateSubCategory extends HomeScreenState {}
class HomeUpdateBrand extends HomeScreenState {}
class HomeUpdateLocationFrom extends HomeScreenState {}
class HomeUpdateLocationTo extends HomeScreenState {}

class HomeLoadingGetFavorite extends HomeScreenState {}
class HomeSuccessGetFavorite extends HomeScreenState {}
class HomeErrorGetFavorite extends HomeScreenState {}

class  LoadingFavCategoryDataState extends HomeScreenState {}
class  SuccessFavCategoryDataState extends HomeScreenState {}
class  ErrorFavCategoryDataState extends HomeScreenState {}

class  LoadingBookTruckState extends HomeScreenState {}
class  SuccessBookTruckState extends HomeScreenState {}
class  ErrorBookTruckState extends HomeScreenState {
  final String error ;
  ErrorBookTruckState(this.error) ;
}

class NewsGetSearchLoadingState extends HomeScreenState {}

class NewsGetSearchSuccessState extends HomeScreenState {}

class NewsGetSearchErrorState extends HomeScreenState  {
  final String error ;
  NewsGetSearchErrorState(this.error);
}

class GetReviewLoadingState extends HomeScreenState {}

class GetReviewSuccessState extends HomeScreenState {}

class GetReviewErrorState extends HomeScreenState  {
  final String error ;
  GetReviewErrorState(this.error);
}

class LoadingGetUsersDataForComment extends HomeScreenState {}
class SuccessGetUsersDataForComment extends HomeScreenState {}
class ErrorGetUsersDataForComment extends HomeScreenState {}


