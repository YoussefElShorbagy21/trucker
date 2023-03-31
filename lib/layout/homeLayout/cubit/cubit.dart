import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/models/UserData.dart';
import 'package:login/models/categeiromodel.dart';
import 'package:login/shared/network/remote/dio_helper.dart';


import '../../../modules/customer/screens/chats_screen/chat_home.dart';
import '../../../modules/customer/screens/favorite/favorite.dart';
import '../../../modules/customer/screens/home/home.dart';
import '../../../modules/customer/screens/profile/profile_screen.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import 'state.dart';


class HomeCubit extends Cubit<HomeStates>{

  PostEquipment? postEquipment ;

  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0 ;
  List<Widget> screens =  [
    HomeScreen(),
    const FavoriteScreen(),
    const ChatHome(),
    const ProfileScreen(),
  ];


  Future<void> postNewEquipment({
    required String title ,
    required String description,
    required File? photo,
    required int price ,
    required String category ,
    required String government ,
    required String? userId ,
  }) async {

    emit(HomePostEquipmentLoadingState());
    FormData formData = FormData.fromMap({
      'title' : title,
      'description' : description,
      'photo': await MultipartFile.fromFile(photo!.path),
      'price' : price,
      'category' : category,
      'government' : government,
      'userId' : userId,
    });
    DioHelper.postData(
      url: '/Equipments',
      data: formData,
    ).then((value)
    {
      if (kDebugMode) {
        print("postData Equipments") ;
      }
      postEquipment = PostEquipment.fromJson(value.data) ;
      if (kDebugMode) {
        print(kDebugMode);
        print(postImage!.path);
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



  
  void changeBottomNavIndex(int index){
    currentIndex = index ;
    emit(HomeChangeBottomNav());
  }

  //Image
  File? postImage ;
  var picker = ImagePicker();
  Future<void> getPostImage() async  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null) {
      postImage = File(pickedFile.path) ;
      print(postImage.toString());
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
  //Image


  Locale  locale= const Locale('en');
 Future<String> getCachedSavedLanguage() async {
    final String? cachedLanguageCode = await CacheHelper.getData(key: 'LOCALE');
    if(cachedLanguageCode != null ){
      print('cachedLanguageCode');
      return cachedLanguageCode ;
    }
    else{
      print('cachedLanguageCodeEn');
      return 'en';
    }

 }

  Future<void> getSavedLanguage() async {
    final String cachedLanguageCode = await getCachedSavedLanguage();
    locale = Locale(cachedLanguageCode);
    emit(ChangeLocalState());
  }

  Future<void> cachedLanguageCode(String languageCode) async {
    CacheHelper.saveData(key: 'LOCALE', value: languageCode);
    locale = Locale(languageCode);
    emit(ChangeLocalState());
  }


  UserData userData  = UserData(name: 'newName', email: '',verified: false);

   void getUserData(){
    emit(LoadingGetUserData());
    DioHelper.getDate(url:'users/$uid').then((value){
      if (kDebugMode) {
        print(value.data);
      }
      if (kDebugMode) {
        print(uid);
      }
      userData = UserData.fromJson(value.data);
      emit(SuccessGetUserData());

    }).catchError((onError){
      if (kDebugMode) {
        print(onError.toString());
      }
    }
    );}

  void  verifyEmail(String otpCode ,String  tokenVerify){
    emit(LoadingVerifyEmail());
    DioHelper.postData(url: 'users/verfiy',
        tokenVerify: tokenVerify,
        data: {
      'otpCode':otpCode,
    }).then((value) => {
      print(value.data),
      print(token),
      emit(SuccessVerifyEmail())
    }).catchError((onError){
      print(onError.toString());
    });
   }
}