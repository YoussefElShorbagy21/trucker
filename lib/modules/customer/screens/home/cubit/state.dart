import 'package:login/models/categeiromodel.dart';

abstract class HomeScreenState {}

class  HomeScreenInitialState extends HomeScreenState {}

class  LoadingHomeDataState extends HomeScreenState {}
class  SuccessHomeDataState extends HomeScreenState {
  GetEquipment getEquipment ;
  SuccessHomeDataState(this.getEquipment);
}
class  ErrorHomeDataState extends HomeScreenState {}

class ChangeClickOrderButton extends HomeScreenState {}

class ChangeClickOfferButton extends HomeScreenState {}

class RefreshIndicatorHome extends HomeScreenState {}