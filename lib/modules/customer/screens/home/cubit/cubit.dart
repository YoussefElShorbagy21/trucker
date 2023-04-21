import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:login/modules/customer/screens/home/cubit/state.dart';

import '../../../../../models/categeiromodel.dart';
import '../../../../../shared/network/remote/dio_helper.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {

  HomeScreenCubit() : super(HomeScreenInitialState());


  GetEquipment homeModel = GetEquipment(equipment: [], results: 0);
  static HomeScreenCubit get(context) => BlocProvider.of(context);

  Future<void> getHomeData() async{
    emit(LoadingHomeDataState());
    await DioHelper.getDate(
      url: 'Equipments',
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

  GetDetailsEquipment getDetailsEquipment = GetDetailsEquipment(equipment: Equipment(id: '',
      description: '',
      photo: '',
      price: null,
      title: '',
      category: '',
      government: '',
      userId: ''
  )) ;

  Future<void> getDetailsCategoryData(String id) async{
    emit(LoadingDetailsCategoryDataState());
    await DioHelper.getDate(
      url: 'Equipments/$id',
    ).then((value)
    {
      print(id);
      print(value.data);
      getDetailsEquipment = GetDetailsEquipment.fromJson(value.data);
      emit(SuccessDetailsCategoryDataState());}
    ).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorDetailsCategoryDataState());
    });
  }

  GetEquipment homeModel1 = GetEquipment(equipment: [], results: 0);
  Future<void> getCategoryData(String title) async{
    emit(LoadingCategoryDataState());
    await DioHelper.getDate(
      url: 'Equipments/?category=$title',
    ).then((value)
    {
      print(title);
      print(value.data);
      homeModel1 = GetEquipment.fromJson(value.data);
      emit(SuccessCategoryDataState());}
    ).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorCategoryDataState());
    });
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

//still error
  Future<void> updatePostData(
      {
        required String title ,
        required String description,
        required File? photo,
        required int price ,
        required String category ,
        required String government ,
        required String id,
      })
  async {
    emit(LoadingUpdatePostState());
    FormData formData = FormData.fromMap({
      'title' : title,
      'description' : description,
      'photo': await MultipartFile.fromFile(photo!.path),
      'price' : price,
      'category' : category,
      'government' : government,
    });
    DioHelper.putData(
      url: 'Equipments/$id',
      data: formData,
    ).then((value)
    {
      emit(SuccessUpdatePostState());
    }).catchError((error){
      print(error.toString());
      emit(ErrorUpdatePostState());
    });
  }
}