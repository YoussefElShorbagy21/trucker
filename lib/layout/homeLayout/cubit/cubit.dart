import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/models/UserData.dart';
import 'package:login/models/categeiromodel.dart';
import 'package:login/modules/category/category_screen.dart';
import 'package:login/shared/network/remote/dio_helper.dart';


import '../../../modules/customer/screens/chats_screen/chat_home.dart';
import '../../../modules/customer/screens/home/home.dart';
import '../../../modules/customer/screens/profile/profile_screen.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import 'state.dart';
import 'package:image_cropper/image_cropper.dart';


class HomeCubit extends Cubit<HomeStates>{

  PostEquipment? postEquipment ;
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0 ;
  List<Widget> screens =  [
    HomeScreen(),
    const CategoryScreen(),
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
        print("postData Equipments") ;
      postEquipment = PostEquipment.fromJson(value.data) ;
      emit(HomePostEquipmentSuccessState());
    }).catchError((error)
    {
        print(error.toString());
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
  Future<void> getPostImage(ImageSource imageSource) async  {
    final pickedFile = await picker.pickImage(source: imageSource);
    if(pickedFile != null) {
      postImage = File(pickedFile.path) ;
      postImage = await croppedImage(file: postImage);
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


  OneUserData oneUserData  = OneUserData(
      userData: UserData(name: 'name', email: 'email', phone: 'phone',
          verified: false, avatar: '', role: ''));

   void getUserData(){
    emit(LoadingGetUserData());
    DioHelper.getDate(url:'users/$uid').then((value){
      if (kDebugMode) {
        print(value.data);
      }
      if (kDebugMode) {
        print(uid);
      }
      oneUserData = OneUserData.fromJson(value.data);
      emit(SuccessGetUserData());
    }).catchError((onError){
      if (kDebugMode) {
        print(onError.toString());
      }
    }
    );}

 AllUserData allUserData = AllUserData(allUser: []);
  void getAllUserData(){
    emit(LoadingGetAllUserData());
    DioHelper.getDate(url:'users').then((value){
      if (kDebugMode) {
        print(value.data);
      }
      allUserData = AllUserData.fromJson(value.data);
      emit(SuccessGetAllUserData());
    }).catchError((onError){
      if (kDebugMode) {
        print(onError.toString());
      }
    }
    );}

  //update Data User
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  File? profileImage ;
  var profilePicker = ImagePicker();
  Future<void> getProfileImage(ImageSource imageSource) async  {
    final pickedFile = await profilePicker.pickImage(source: imageSource);
    if(pickedFile != null) {
      profileImage = File(pickedFile.path) ;
      profileImage = await croppedImage(file: profileImage);
      print(profileImage.toString());
      emit(HomeProfileImagePickedSuccessState());
    }
    else {
      print('No image selected');
      emit(HomeProfileImagePickedErrorState());
    }
  }


  Future<void> updateUserData(
      {
        required String name ,
        required String email,
        required String phone ,
        required File? avatar,
      })
  async {
    emit(LoadingUpdateUSERState());
    FormData formData = FormData.fromMap({
      'avatar': await MultipartFile.fromFile(avatar!.path),
      'name' : name ,
      'email' :email,
      'phone' : phone ,
    });
    DioHelper.putData(
      url: 'users/updateMe',
      data: formData,
    ).then((value)
    {
      oneUserData.userData.name = value.data['updatedUser']['name'];
      oneUserData.userData.avatar = value.data['updatedUser']['avatar'];
      oneUserData.userData.email = value.data['updatedUser']['email'];
      oneUserData.userData.phone = value.data['updatedUser']['phone'];
      oneUserData.userData.verified = value.data['updatedUser']['verified'];
      print(oneUserData.userData.avatar);
      Future.delayed(const Duration(seconds: 10),(){
        getUserData();
      });
      emit(SuccessUpdateUSERState());
    }).catchError((error){
      print(error.toString());
      emit(ErrorUpdateUSERState());
    });
  }


  // post data
  var textController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();


  String categoryControllerT = 'Category';
  String governmentControllerT  = 'Government';
  void setCategory(String selected) {
    categoryControllerT = selected ;
    emit(HomeSetCategory());
  }

  void setGovernment(String selected) {
    governmentControllerT = selected ;
    emit(HomeSetGovernment());
  }

  void delayFunction(int time) {
    Future.delayed(Duration(seconds: time),(){
      print(time);
      textController.text = '';
      descriptionController.text = '';
      categoryControllerT = '';
      governmentControllerT = '';
      priceController.text = '';
      postImage = null;
    });
    emit(DelayFunctionState());
  }


  Future<File?> croppedImage({required File? file}) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if(croppedFile == null) return null ;
    return File(croppedFile.path);
  }

}