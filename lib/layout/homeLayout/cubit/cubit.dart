import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/models/UserData.dart';
import 'package:login/models/categeiromodel.dart';
import 'package:login/modules/screens/favorite/favorite.dart';
import 'package:login/modules/screens/home/home.dart';
import 'package:login/shared/network/remote/dio_helper.dart';


import '../../../modules/screens/chats_screen/chat_home.dart';
import '../../../modules/screens/profile/profile_screen.dart';
import '../../../shared/network/local/cache_helper.dart';
import 'state.dart';



enum SingingCharacter { Offer, Order }
class HomeCubit extends Cubit<HomeStates>{


  PostEquipment? postEquipment ;

  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0 ;
  SingingCharacter characters = SingingCharacter.Order;
  List<Widget> screens =  [
    const HomeScreen(),
    const FavoriteScreen(),
    const ChatHome(),
    const ProfileScreen(),
  ];

  void postNewEquipment({
    required String title ,
    required String description,
    required String photo,
    required int price ,
    required int rating ,
    required String type ,
  }) {
    emit(HomePostEquipmentLoadingState());
    DioHelper.postData(
      url: '/Equipments',
      data:
      {
        'title' : title,
        'description' : description,
        'photo': photo,
        'price' : price,
        'rating' : rating,
        'type' : type,
      },
    ).then((value)
    {
      if (kDebugMode) {
        print("postData Equipments") ;
      }
      if (kDebugMode) {
        print(value.data);
      }
      postEquipment = PostEquipment.fromJson(value.data) ;
      if (kDebugMode) {
        print(postEquipment);
      }
      emit(HomePostEquipmentSuccessState());
    }).catchError((error)
    {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(HomePostEquipmentErrorState());
    });
  }


  UserData userData  = UserData(name: 'newName', email: '');
  String? uid = CacheHelper.getData(key: 'token') ;
  void getUserData(){
    emit(LoadingGetUserData());
    DioHelper.getDate(url: '/users/$uid').then((value){
      if (kDebugMode) {
        print('getUserData');
      }
      if (kDebugMode) {
        print(value.data);
      }
      if (kDebugMode) {
        print(uid);
      }
      userData = UserData.fromJson(value.data);
      if (kDebugMode) {
        print(userData);
      }
      CacheHelper.saveData(key: 'name', value: userData.name);
      CacheHelper.saveData(key: 'email', value: userData.email);
      emit(SuccessGetUserData(userData));
    }).catchError((onError){
      if (kDebugMode) {
        print(onError.toString());
      }
    }
    );}
  
  void changeBottomNavIndex(int index){
    currentIndex = index ;
    emit(HomeChangeBottomNav());
  }

  var picker = ImagePicker();
  File? postImage ;

  Future<void> getPostImage() async  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null) {
      postImage = File(pickedFile.path) ;
      emit(HomePostImagePickedSuccessState());
    }
    else {
      print('No image selected');
      emit(HomePostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null ;
    emit(HomeRemovePostImageState());
  }

  changeRadio(SingingCharacter value ) {
    characters = value  ;
    emit(HomeChangeRadio());
  }
}