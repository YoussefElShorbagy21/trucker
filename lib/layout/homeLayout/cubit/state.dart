
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
class HomePostEquipmentErrorState extends HomeStates {}


class LoadingUpdateUSERState extends HomeStates {}
class SuccessUpdateUSERState extends HomeStates {}
class ErrorUpdateUSERState extends HomeStates {}


class HomeSetCategory extends HomeStates {}
class HomeSetSubCategory extends HomeStates {}
class HomeSetBrand extends HomeStates {}
class HomeSetLocationFrom extends HomeStates {}
class HomeSetLocationTo extends HomeStates {}

class DelayFunctionState extends HomeStates {}

class HomeProfileImagePickedSuccessState extends HomeStates {}
class HomeProfileImagePickedErrorState extends HomeStates {}

class HomeLoadingGetCategory extends HomeStates {}
class HomeSuccessGetCategory extends HomeStates {}
class HomeErrorGetCategory extends HomeStates {}

class HomeLoadingGetSubCategory extends HomeStates {}
class HomeSuccessGetSubCategory extends HomeStates {}
class HomeErrorGetSubCategory extends HomeStates {}


class HomeLoadingGetBrand extends HomeStates {}
class HomeSuccessGetBrand extends HomeStates {}
class HomeErrorGetBrand extends HomeStates {}

class LoadingAddFavorite extends HomeStates {}
class SuccessAddFavorite extends HomeStates {}
class ErrorAddFavorite extends HomeStates {}

class LoadingDeleteFavorite extends HomeStates {}
class SuccessDeleteFavorite extends HomeStates {}
class ErrorDeleteFavorite extends HomeStates {}

class DelayedFunction extends HomeStates {}

class HomeLoadingGetFilterData extends HomeStates {}
class HomeSuccessGetFilterData extends HomeStates {}
class HomeErrorGetFilterData extends HomeStates {}

class  LoadingCategoryDataState extends HomeStates {}
class  SuccessCategoryDataState extends HomeStates {}
class  ErrorCategoryDataState extends HomeStates {}

class HomeLoadingGetFilterDataCategory extends HomeStates {}
class HomeSuccessGetFilterDataCategory extends HomeStates {}
class HomeErrorGetFilterDataCategory extends HomeStates {}
