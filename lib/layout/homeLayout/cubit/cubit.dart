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


  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0 ;
  List<Widget> screens =  [
    HomeScreen(),
    const CategoryScreen(),
    const ChatHome(),
    const ProfileScreen(),
  ];

  PostEquipment? postEquipment ;
  Future<void> postNewEquipment({
    required String name ,
    required String description,
    required File? imageCover,
    required int price ,
    required String category ,
    required String subcategory ,
    required String brand ,
    required String currentLocation ,
    required String? userId ,
  }) async {

    emit(HomePostEquipmentLoadingState());
    FormData formData = FormData.fromMap({
      'name' : name,
      'description' : description,
      'imageCover': await MultipartFile.fromFile(imageCover!.path),
      'price' : price,
      'category' : category,
      'subcategory' : subcategory,
      'brand' : brand,
      'currentLocation' : currentLocation,
      'userId' : userId,
    });
    DioHelper.postData(
      url: 'truck',
      data: formData,
    ).then((value)
    {
      print("postData Equipments") ;
      postEquipment = PostEquipment.fromJson(value.data) ;
      emit(HomePostEquipmentSuccessState());
    }).catchError((error)
    {
      if(error is DioError)
      {
        print(error.response);
        print(error.response!.data['message']);
        print(error.message);
        emit(HomePostEquipmentErrorState(error.response!.data['message']));
      }
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
          verified: false, avatar: '', role: '', nationalId: null,
          favoriteList: [], doneTransactions: [],
          currentTransactions: [], acceptedTransactions: []));

 Map<String , String > favorites = {};
  Future<void> getUserData({String? userID}) async {
    emit(LoadingGetUserData());
    if (uid == null) {
      print('uid is null');
     await DioHelper.getDate(url: 'users/$userID').then((value) {
        if (kDebugMode) {
          print('userID: $userID because uid null');
        }
        uid = userID ;
        oneUserData = OneUserData.fromJson(value.data);
        print('start search in favoriteList');
        for (var element in oneUserData.userData.favoriteList) {
           favorites.addAll({element: 'find'});
        }
        print(favorites);
        emit(SuccessGetUserData());
      }).catchError((onError) {
        if (kDebugMode) {
          print(onError.toString());
        }
      });
    }else{
      print('uid is not null');
      print('uid in function getUserData: $uid');
     await DioHelper.getDate(url: 'users/$uid').then((value) {
        oneUserData = OneUserData.fromJson(value.data);
        print('start search in favoriteList');
        for (var element in oneUserData.userData.favoriteList) {
          favorites.addAll({element: 'find'});
        }
        print(favorites);
        emit(SuccessGetUserData());
      }).catchError((onError) {
        if (kDebugMode) {
          print(onError.toString());
        }
      });
    }
  }

 AllUserData allUserData = AllUserData(allUser: []);
  void getAllUserData(){
    emit(LoadingGetAllUserData());
    DioHelper.getDate(url:'users').then((value){
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
      if(error is DioError)
      {
        print(error.response);
        print(error.response!.data['message']);
        print(error.message);
        emit(ErrorUpdateUSERState(error.response!.data['message']));
      }
    });
  }


  // post data
  var textController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  String idCategoryControllerT = '' ;
  String idSubCategoryControllerT = '' ;
  String idBrandControllerT = '' ;
  var categoryControllerT = TextEditingController(text: 'Category');
  var subCategoryControllerT = TextEditingController(text: 'subCategory');
  var brandControllerT = TextEditingController(text: 'brand');
  var currentLocation  =TextEditingController(text: 'currentLocation');

  void setCategory(String selected) {
    categoryControllerT.text = selected ;
    switch(categoryControllerT.text) {
      case 'Truck': {
        idCategoryControllerT = "64498aa6db60baf726212fb9";
      }
      break;

      case 'pick up': {
        idCategoryControllerT = "64498ac2db60baf726212fbb";
      }
      break;
      case 'Heavy Equipment': {
        idCategoryControllerT = "64498b04db60baf726212fbd";
      }
      break;
      case 'Others': {
        idCategoryControllerT = "64498e8edb60baf726212fc0";
      }
      break;
      default: {
      }
      break;
    }
    print(idCategoryControllerT.toString());
    emit(HomeSetCategory());
  }

  void setSubCategory(String selected) {
    subCategoryControllerT.text = selected ;

    switch(subCategoryControllerT.text) {
      case 'truck1': {
        idSubCategoryControllerT = "6449906292768740d4790d12";
      }
      break;

      case 'truck2': {
        idSubCategoryControllerT = "6449907b92768740d4790d14";
      }
      break;
      case 'truck3': {
        idSubCategoryControllerT = "6449908092768740d4790d16";
      }
      break;
      case 'truck4': {
        idSubCategoryControllerT = "6449908592768740d4790d18";
      }
      break;

      case 'pick up1': {
    idSubCategoryControllerT = "644990f192768740d4790d1c";
    }
    break;
      default: {
      }
      break;
    }
    print(idSubCategoryControllerT.toString());
    emit(HomeSetSubCategory());
  }

  void setBrand(String selected) {
    brandControllerT.text = selected ;
    switch(brandControllerT.text) {
      case 'Scania': {
        idBrandControllerT = "6449dd29bbae94188f228f01";
      }
      break;

      case 'Iveco': {
        idBrandControllerT = "6449dd36bbae94188f228f03";
      }
      break;
      case 'Man': {
        idBrandControllerT = "6449dd44bbae94188f228f07";
      }
      break;
      case 'Volvo': {
        idBrandControllerT = "6449fba2c1ded773b2a7d1fa";
      }
      break;
      default: {
      }
      break;
    }
    print(idBrandControllerT.toString());
    emit(HomeSetBrand());
  }

  void setcurrentLocation(String selected) {
    currentLocation.text = selected ;
    emit(HomeSetLocationFrom());
  }


  void delayFunction(int time) {
    Future.delayed(Duration(seconds: time),(){
      print(time);
      textController.text = '';
      descriptionController.text = '';
      priceController.text = '';
       idCategoryControllerT = '' ;
       idSubCategoryControllerT = '' ;
       idBrandControllerT = '' ;
        categoryControllerT.text = 'Category';
       subCategoryControllerT.text = 'subCategory';
       brandControllerT.text = 'brand';
      currentLocation.text  = 'locationFrom';
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

  List<CategoryModel> listCate = [] ;
  List<SubCategory> listSubCategory = [] ;
  List<Brand> listBrand = [] ;

  Future<void> getCategory() async{
    emit(HomeLoadingGetCategory());
    await DioHelper.getDate(
      url: 'category',
    ).then((value)
    {
      var re = value.data;
      for(var data in re)
        {
          listCate.add(CategoryModel(id: data['_id'], name: data['name']));
        }
      emit(HomeSuccessGetCategory());}
    ).catchError((error){
      print(error.toString());
      emit(HomeErrorGetCategory());
    });
  }

  Future<void> getSubCategory() async {
    emit(HomeLoadingGetSubCategory());
    await DioHelper.getDate(
      url: 'subcategory',
    ).then((value)
    {
      var re = value.data;
      for(var data in re)
      {
        listSubCategory.add(SubCategory(id: data['_id'], name: data['name']));
      }
      emit(HomeSuccessGetSubCategory());}
    ).catchError((error){
      print(error.toString());
      emit(HomeErrorGetSubCategory());
    });
  }

  Future<void> getBrand() async {
    emit(HomeLoadingGetBrand());
    await DioHelper.getDate(
      url: 'brand',
    ).then((value)
    {
      var re = value.data;
      for(var data in re)
      {
        listBrand.add(Brand(id: data['_id'], name: data['name']));
      }
      emit(HomeSuccessGetBrand());}
    ).catchError((error){
      print(error.toString());
      emit(HomeErrorGetBrand());
    });
  }


  Future<void> addFavorite({
    required String truck ,
  }) async {
    emit(LoadingAddFavorite());
    await DioHelper.putData(
      url: 'favoriteList',
      data: {
        "truck" : truck
      },
    ).then((value)
    {
      print(value.data);
      emit(SuccessAddFavorite());}
    ).catchError((error){
      if(error is DioError)
      {
        print(error.response);
        print(error.response!.data['message']);
        print(error.message);
        emit(ErrorAddFavorite(error.response!.data['message']));
      }
    });
  }

  Future<void> deleteFavorite({
    required String truck ,
  }) async {
    emit(LoadingDeleteFavorite());
    await DioHelper.deleteData(
      url: 'favoriteList',
      data: {
        "truck" : truck
      },
    ).then((value)
    {
      print(value.data);
      emit(SuccessDeleteFavorite());
    }
    ).catchError((error){
      if(error is DioError)
      {
        print(error.response);
        print(error.response!.data['message']);
        print(error.message);
        emit(ErrorDeleteFavorite(error.response!.data['message']));
      }
    });
  }

  Future<void> delayTime(int time) async {
    print('Time $time');
    Future.delayed( Duration(seconds: time) , () async {
      await HomeCubit().getUserData();
    });
    print('Time after delayed $time');
    emit(DelayedFunction());
  }


  String categoryControllerF = 'Category';
  String subCategoryControllerF = 'subCategory';
  String brandControllerF = 'brand';
  String idCategoryControllerF = '' ;
  String idSubCategoryControllerF = '' ;
  String idBrandControllerF = '' ;
  void setCategoryF(String selected) {
    categoryControllerF = selected ;
    switch(categoryControllerF) {
      case 'Truck': {
        idCategoryControllerF = "64498aa6db60baf726212fb9";
      }
      break;

      case 'pick up': {
        idCategoryControllerF = "64498ac2db60baf726212fbb";
      }
      break;
      case 'Heavy Equipment': {
        idCategoryControllerF = "64498b04db60baf726212fbd";
      }
      break;
      case 'Others': {
        idCategoryControllerF = "64498e8edb60baf726212fc0";
      }
      break;
      default: {
      }
      break;
    }
    print(idCategoryControllerF.toString());
    emit(HomeSetCategory());
  }

  void setSubCategoryF(String selected) {
    subCategoryControllerF = selected ;

    switch(subCategoryControllerF) {
      case 'truck1': {
        idSubCategoryControllerF = "6449906292768740d4790d12";
      }
      break;

      case 'truck2': {
        idSubCategoryControllerF = "6449907b92768740d4790d14";
      }
      break;
      case 'truck3': {
        idSubCategoryControllerF = "6449908092768740d4790d16";
      }
      break;
      case 'truck4': {
        idSubCategoryControllerF = "6449908592768740d4790d18";
      }
      break;

      case 'pick up1': {
        idSubCategoryControllerF = "644990f192768740d4790d1c";
      }
      break;
      default: {
      }
      break;
    }
    print(idSubCategoryControllerF.toString());
    emit(HomeSetSubCategory());
  }

  void setBrandF(String selected) {
    brandControllerF = selected ;
    switch(brandControllerF) {
      case 'Scania': {
        idBrandControllerF = "6449dd29bbae94188f228f01";
      }
      break;

      case 'Iveco': {
        idBrandControllerF = "6449dd36bbae94188f228f03";
      }
      break;
      case 'Man': {
        idBrandControllerF = "6449dd44bbae94188f228f07";
      }
      break;
      case 'Volvo': {
        idBrandControllerF = "6449fba2c1ded773b2a7d1fa";
      }
      break;
      default: {
      }
      break;
    }
    print(idBrandControllerF.toString());
    emit(HomeSetBrand());
  }

  GetEquipment homeModelFilter = GetEquipment(equipment: []);
  Future<void> getFilterData(String category,String subcategory,String brand) async{
    emit(HomeLoadingGetFilterData());
    if(idCategoryControllerF.isNotEmpty && idSubCategoryControllerF.isNotEmpty && idBrandControllerF.isNotEmpty) {
      await DioHelper.getDate(
      url: 'truck/?category=$category&subcategory=$subcategory&brand=$brand',
    ).then((value) {
      print(value.realUri);
      print(value.data);
      homeModelFilter = GetEquipment.fromJson(value.data);
      emit(HomeSuccessGetFilterData());
       categoryControllerF = 'Category';
       subCategoryControllerF = 'subCategory';
       brandControllerF = 'brand';
      idCategoryControllerF = '';
      idSubCategoryControllerF = '';
      idBrandControllerF = '';
    }).catchError((error){
      print(error.toString());
      emit(HomeErrorGetFilterData());
    });
    }
    else if(idCategoryControllerF.isNotEmpty && idSubCategoryControllerF.isNotEmpty && idBrandControllerF.isEmpty) {
        await DioHelper.getDate(
          url: 'truck/?category=$category&subcategory=$subcategory',
        ).then((value) {
          print(value.realUri);
          print(value.data);
          homeModelFilter = GetEquipment.fromJson(value.data);
          emit(HomeSuccessGetFilterData());
           categoryControllerF = 'Category';
           subCategoryControllerF = 'subCategory';
          idCategoryControllerF = '';
          idSubCategoryControllerF = '';
        }).catchError((error){
          print(error.toString());
          emit(HomeErrorGetFilterData());
        });
      }
    else if(idCategoryControllerF.isNotEmpty && idSubCategoryControllerF.isEmpty && idBrandControllerF.isNotEmpty) {
      await DioHelper.getDate(
        url: 'truck/?category=$category&brand=$brand',
      ).then((value) {
        print(value.realUri);
        print(value.data);
        homeModelFilter = GetEquipment.fromJson(value.data);
        emit(HomeSuccessGetFilterData());
        categoryControllerF = 'Category';
        brandControllerF = 'brand';
        idCategoryControllerF = '';
        idBrandControllerF = '' ;
      }).catchError((error){
        print(error.toString());
        emit(HomeErrorGetFilterData());
      });
    }
    else if(idCategoryControllerF.isNotEmpty && idSubCategoryControllerF.isEmpty && idBrandControllerF.isEmpty) {
      await DioHelper.getDate(
        url: 'truck/?category=$category',
      ).then((value) {
        print(value.realUri);
        print(value.data);
        homeModelFilter = GetEquipment.fromJson(value.data);
        emit(HomeSuccessGetFilterData());
        categoryControllerF = 'Category';
        idCategoryControllerF = '';
      }).catchError((error){
        print(error.toString());
        emit(HomeErrorGetFilterData());
      });
    }
    else if(idCategoryControllerF.isEmpty && idSubCategoryControllerF.isNotEmpty && idBrandControllerF.isEmpty) {
      await DioHelper.getDate(
        url: 'truck/?subcategory=$subcategory',
      ).then((value) {
        print(value.realUri);
        print(value.data);
        homeModelFilter = GetEquipment.fromJson(value.data);
        emit(HomeSuccessGetFilterData());
        subCategoryControllerF = 'subCategory';
        idSubCategoryControllerF = '';
      }).catchError((error){
        print(error.toString());
        emit(HomeErrorGetFilterData());
      });
    }
    else if(idCategoryControllerF.isEmpty && idSubCategoryControllerF.isEmpty && idBrandControllerF.isNotEmpty) {
      await DioHelper.getDate(
        url: 'truck/?brand=$brand',
      ).then((value) {
        print(value.realUri);
        print(value.data);
        homeModelFilter = GetEquipment.fromJson(value.data);
        emit(HomeSuccessGetFilterData());
        brandControllerF = 'brand';
        idBrandControllerF = '';
      }).catchError((error){
        print(error.toString());
        emit(HomeErrorGetFilterData());
      });
    }
    else if(idCategoryControllerF.isEmpty && idSubCategoryControllerF.isNotEmpty && idBrandControllerF.isNotEmpty) {
      await DioHelper.getDate(
        url: 'truck/?subcategory=$subcategory&brand=$brand',
      ).then((value) {
        print(value.realUri);
        print(value.data);
        homeModelFilter = GetEquipment.fromJson(value.data);
        emit(HomeSuccessGetFilterData());
         subCategoryControllerF = 'subCategory';
         brandControllerF = 'brand';
         idSubCategoryControllerF = '' ;
         idBrandControllerF = '' ;
      }).catchError((error){
        print(error.toString());
        emit(HomeErrorGetFilterData());
      });
    }
  }

  GetEquipment homeModel = GetEquipment(equipment: []);
  Future<void> getCategoryData(String title) async{
    emit(LoadingCategoryDataState());
    await DioHelper.getDate(
      url: 'truck/?category=$title',
    ).then((value)
    {
      print(value.realUri);
      print(title);
      print(value.data);
      homeModel = GetEquipment.fromJson(value.data);
      emit(SuccessCategoryDataState());}
    ).catchError((error){
      print(error.toString());
      emit(ErrorCategoryDataState());
    });
  }

  Future<void> getFilterDataCategory(String category,String subcategory,String brand) async{
    emit(HomeLoadingGetFilterDataCategory());
    if(idSubCategoryControllerF.isNotEmpty && idBrandControllerF.isEmpty) {
      await DioHelper.getDate(
        url: 'truck/?category=$category&subcategory=$subcategory',
      ).then((value) {
        print(value.realUri);
        print(value.data);
        homeModel = GetEquipment.fromJson(value.data);
        emit(HomeSuccessGetFilterDataCategory());
        subCategoryControllerF = 'Category';
        idSubCategoryControllerF = '';
      }).catchError((error){
        if(error is DioError)
        {
          print(error.response);
          print(error.response!.data['message']);
          print(error.message);
          emit(HomeErrorGetFilterDataCategory(error.response!.data['message']));
        }
      });
    }
    else if(idSubCategoryControllerF.isEmpty && idBrandControllerF.isNotEmpty) {
      await DioHelper.getDate(
        url: 'truck/?category=$category&brand=$brand',
      ).then((value) {
        print(value.realUri);
        print(value.data);
        homeModel = GetEquipment.fromJson(value.data);
        emit(HomeSuccessGetFilterData());
        brandControllerF = 'brand';
        idBrandControllerF = '' ;
      }).catchError((error){
        print(error.toString());
        emit(HomeErrorGetFilterData());
      });
    }
    else if(idSubCategoryControllerF.isNotEmpty && idBrandControllerF.isNotEmpty) {
      await DioHelper.getDate(
        url: 'truck/?category=$category&subcategory=$subcategory&brand=$brand',
      ).then((value) {
        print(value.realUri);
        print(value.data);
        homeModel = GetEquipment.fromJson(value.data);
        emit(HomeSuccessGetFilterData());
        subCategoryControllerF = 'subCategory';
        brandControllerF = 'brand';
        idSubCategoryControllerF = '';
        idBrandControllerF = '';
      }).catchError((error){
        print(error.toString());
        emit(HomeErrorGetFilterData());
      });
    }

  }



}