import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/modules/screens/home/cubit/state.dart';

import '../../../../models/categeiromodel.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {

  HomeScreenCubit() : super(HomeScreenInitialState());


  GetEquipment homeModel = GetEquipment(equipment: [], results: 0);
  static HomeScreenCubit get(context) => BlocProvider.of(context);

  Future<void> getHomeData() async{
    emit(LoadingHomeDataState());
    await DioHelper.getDate(
      url: '/Equipments',
    ).then((value)
    {
      homeModel =  GetEquipment.fromJson(value.data);
      emit(SuccessHomeDataState(homeModel));}
    ).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorHomeDataState());
    });
  }

  Future<void> onRefresh() async {
    await getHomeData();
    emit(RefreshIndicatorHome());
  }


  bool isClickedOrder = true ;
  bool isClickedOffer = false ;
  isClickOffer(){
    isClickedOffer = true ;
    isClickedOrder = false ;
    print('isClickedOffer : $isClickedOffer');
    print('isClickedOrder : $isClickedOrder');
    emit(ChangeClickOrderButton());
  }
  isClickOrder(){
    isClickedOffer = false ;
    isClickedOrder = true ;
    print('isClickedOffer : $isClickedOffer');
    print('isClickedOrder : $isClickedOrder');
    emit(ChangeClickOfferButton());
  }
}