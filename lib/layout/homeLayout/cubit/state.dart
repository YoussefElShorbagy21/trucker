
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

class LoadingGetAllUserData extends HomeStates {}
class SuccessGetAllUserData extends HomeStates {}


class HomePostEquipmentLoadingState extends HomeStates {}
class HomePostEquipmentSuccessState extends HomeStates {}
class HomePostEquipmentErrorState extends HomeStates {
  final String error ;
  HomePostEquipmentErrorState(this.error) ;
}


class LoadingUpdateUSERState extends HomeStates {}
class SuccessUpdateUSERState extends HomeStates {}
class ErrorUpdateUSERState extends HomeStates {
  final String error ;
  ErrorUpdateUSERState(this.error) ;
}


class HomeSetCategory extends HomeStates {}

class HomeSetBrand extends HomeStates {}
class HomeSetLocationFrom extends HomeStates {}
class HomeSetLocationTo extends HomeStates {}

class DelayFunctionState extends HomeStates {}

class HomeProfileImagePickedSuccessState extends HomeStates {}
class HomeProfileImagePickedErrorState extends HomeStates {}

class HomeLoadingGetCategory extends HomeStates {}
class HomeSuccessGetCategory extends HomeStates {}
class HomeErrorGetCategory extends HomeStates {}



class HomeLoadingGetBrand extends HomeStates {}
class HomeSuccessGetBrand extends HomeStates {}
class HomeErrorGetBrand extends HomeStates {}

class LoadingAddFavorite extends HomeStates {}
class SuccessAddFavorite extends HomeStates {}
class ErrorAddFavorite extends HomeStates {
  final String error ;
  ErrorAddFavorite(this.error) ;
}

class LoadingDeleteFavorite extends HomeStates {}
class SuccessDeleteFavorite extends HomeStates {}
class ErrorDeleteFavorite extends HomeStates {
  final String error ;
  ErrorDeleteFavorite(this.error) ;
}

class DelayedFunction extends HomeStates {}

class HomeLoadingGetFilterData extends HomeStates {}
class HomeSuccessGetFilterData extends HomeStates {}
class HomeErrorGetFilterData extends HomeStates {}

class  LoadingCategoryDataState extends HomeStates {}
class  SuccessCategoryDataState extends HomeStates {}
class  ErrorCategoryDataState extends HomeStates {}

class HomeLoadingGetFilterDataCategory extends HomeStates {}
class HomeSuccessGetFilterDataCategory extends HomeStates {}
class HomeErrorGetFilterDataCategory extends HomeStates {
  final String error ;
  HomeErrorGetFilterDataCategory(this.error) ;
}


class HomeReviewLoadingState extends HomeStates {}
class HomeReviewSuccessState extends HomeStates {}
class HomeReviewErrorState extends HomeStates {}


class SocialSendMessageSuccessState extends HomeStates {}
class SocialSendMessageErrorState extends HomeStates {}
class SocialGetMessageSuccessState extends HomeStates {}

class  LoadingGetAllBrandState extends HomeStates {}
class  SuccessGetAllBrandSState extends HomeStates {}
