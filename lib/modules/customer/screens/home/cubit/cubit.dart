
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/modules/customer/screens/home/cubit/state.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../models/UserData.dart';
import '../../../../../models/categeiromodel.dart';
import '../../../../../shared/network/remote/dio_helper.dart';
import 'package:image_cropper/image_cropper.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {

  HomeScreenCubit() : super(HomeScreenInitialState());


  GetEquipment homeModel = GetEquipment(equipment: []);
  static HomeScreenCubit get(context) => BlocProvider.of(context);

  Future<void> getHomeData() async{
    emit(LoadingHomeDataState());
    await DioHelper.getDate(
      url: 'truck',
    ).then((value)
    {
      homeModel =  GetEquipment.fromJson(value.data);
      emit(SuccessHomeDataState(homeModel));}
    ).catchError((error){
        print(error.toString());
      emit(ErrorHomeDataState());
    });
  }

  Future<void> onRefresh() async {
    await getHomeData();
    emit(RefreshIndicatorHome());
  }

  DetailsEquipment detailsEquipment = DetailsEquipment(
      images: [],
      ratingCount: 0, id: '0', name: 'name',
      description: 'description', locationFrom: 'locationFrom',
      locationTo: 'locationTo', price: 0, priceAfterDiscount: 0,
      brand: 'brand', subcategory: 'subcategory', category: 'category', createdAt: DateTime(DateTime.april),
      updatedAt: DateTime(DateTime.april), imageCover: 'imageCover', truckId: '0', reviews: [], userId: '');




  Future<void> getDetailsCategoryData(String id,String cid,String scid,String bid) async{
    emit(LoadingDetailsCategoryDataState());
    await DioHelper.getDate(
      url: 'truck/$id',
    ).then((value)
    {
      print(id);
      print(value.data);
      detailsEquipment = DetailsEquipment.fromJson(value.data);
      getCategory(cid);
      getSubCategory(scid);
      getBrand(bid);
      editTextController.text = detailsEquipment.name ;
      editDescriptionController.text = detailsEquipment.description ;
      editPriceController.text = detailsEquipment.price.toString() ;
      editLocationFromControllerT = detailsEquipment.locationFrom ;
      editLocationToControllerT = detailsEquipment.locationTo ;
      getUserDataForCategory(detailsEquipment.userId);
      emit(SuccessDetailsCategoryDataState());}
    ).catchError((error){

        print(error.toString());
      emit(ErrorDetailsCategoryDataState());
    });
  }

  Future<void> getCategoryData(String title) async{
    emit(LoadingCategoryDataState());
    await DioHelper.getDate(
      url: 'truck/?category=$title',
    ).then((value)
    {
      print(title);
      print(value.data);
      homeModel = GetEquipment.fromJson(value.data);
      emit(SuccessCategoryDataState());}
    ).catchError((error){
        print(error.toString());
      emit(ErrorCategoryDataState());
    });
  }


  var editTextController = TextEditingController();
  var editDescriptionController = TextEditingController();
  var editPriceController = TextEditingController();
  String editIdCategoryControllerT = '' ;
  String editIdSubCategoryControllerT = '' ;
  String editIdBrandControllerT = '' ;
  String editCategoryControllerT = 'Category';
  String editSubCategoryControllerT = 'subCategory';
  String editBrandControllerT = 'brand';
  String editLocationFromControllerT  = 'locationFrom';
  String editLocationToControllerT  = 'locationTo';
  void updateCategory(String selected) {
    editCategoryControllerT = selected ;
    switch(editCategoryControllerT) {
      case 'Truck': {
        editIdCategoryControllerT = "64498aa6db60baf726212fb9";
      }
      break;

      case 'pick up': {
        editIdCategoryControllerT = "64498ac2db60baf726212fbb";
      }
      break;
      case 'Heavy Equipment': {
        editIdCategoryControllerT = "64498b04db60baf726212fbd";
      }
      break;
      case 'Others': {
        editIdCategoryControllerT = "64498e8edb60baf726212fc0";
      }
      break;
      default: {
      }
      break;
    }
    emit(HomeUpdateCategory());
  }

  void updateSubCategory(String selected) {
    editSubCategoryControllerT = selected ;

    switch(editSubCategoryControllerT) {
      case 'truck1': {
        editIdSubCategoryControllerT = "6449906292768740d4790d12";
      }
      break;

      case 'truck2': {
        editIdSubCategoryControllerT = "6449907b92768740d4790d14";
      }
      break;
      case 'truck3': {
        editIdSubCategoryControllerT = "6449908092768740d4790d16";
      }
      break;
      case 'truck4': {
        editIdSubCategoryControllerT = "6449908592768740d4790d18";
      }
      break;

      case 'pick up1': {
        editIdSubCategoryControllerT = "644990f192768740d4790d1c";
      }
      break;
      default: {
      }
      break;
    }
    emit(HomeUpdateSubCategory());
  }

  void updateBrand(String selected) {
    editBrandControllerT = selected ;
    switch(editBrandControllerT) {
      case 'Scania': {
        editIdBrandControllerT = "6449dd29bbae94188f228f01";
      }
      break;

      case 'Iveco': {
        editIdBrandControllerT = "6449dd36bbae94188f228f03";
      }
      break;
      case 'Man': {
        editIdBrandControllerT = "6449dd44bbae94188f228f07";
      }
      break;
      case 'Volvo': {
        editIdBrandControllerT = "6449fba2c1ded773b2a7d1fa";
      }
      break;
      default: {
      }
      break;
    }
    emit(HomeUpdateBrand());
  }

  void updateLocationFrom(String selected) {
    editLocationFromControllerT = selected ;
    emit(HomeUpdateLocationFrom());
  }

  void updateLocationTo(String selected) {
    editLocationToControllerT = selected ;
    emit(HomeUpdateLocationTo());
  }

  void idCategory(String cid) {
    editIdCategoryControllerT = cid ;
    switch(editIdCategoryControllerT) {
      case '64498aa6db60baf726212fb9': {
        editCategoryControllerT = "Truck";
      }
      break;

      case '64498ac2db60baf726212fbb': {
        editCategoryControllerT = "pick up";
      }
      break;
      case '64498b04db60baf726212fbd': {
        editCategoryControllerT = "Heavy Equipment";
      }
      break;
      case '64498e8edb60baf726212fc0': {
        editCategoryControllerT = "Others";
      }
      break;
      default: {
      }
      break;
    }
    print(editIdCategoryControllerT);
    print(editCategoryControllerT);
    emit(HomeIdCategory());
  }

  void idSubCategory(String scid) {
    editIdSubCategoryControllerT = scid ;

    switch(editIdSubCategoryControllerT) {
      case '6449906292768740d4790d12': {
        editSubCategoryControllerT = "truck1";
      }
      break;

      case '6449907b92768740d4790d14': {
        editSubCategoryControllerT = "truck2";
      }
      break;
      case '6449908092768740d4790d16': {
        editSubCategoryControllerT = "truck3";
      }
      break;
      case '6449908592768740d4790d18': {
        editSubCategoryControllerT = "truck4";
      }
      break;

      case '644990f192768740d4790d1c': {
        editSubCategoryControllerT = "pick up1";
      }
      break;
      default: {
      }
      break;
    }
    emit(HomeIdSubCategory());
  }

  void idBrand(String bid) {
    editIdBrandControllerT = bid ;
    switch(editIdBrandControllerT) {
      case '6449dd29bbae94188f228f01': {
        editBrandControllerT = "Scania";
      }
      break;

      case '6449dd36bbae94188f228f03': {
        editBrandControllerT = "Iveco";
      }
      break;
      case '6449dd44bbae94188f228f07': {
        editBrandControllerT = "Man";
      }
      break;
      case '6449fba2c1ded773b2a7d1fa': {
        editBrandControllerT = "Volvo";
      }
      break;
      default: {
      }
      break;
    }
    emit(HomeIdBrand());
  }

  Future<void> updatePostData(
      {
        required String name ,
        required String description,
        required int price ,
        required int priceAfterDiscount ,
        required String category ,
        required String subcategory ,
        required String brand ,
        required String locationFrom ,
        required String locationTo ,
        required String? userId ,
        required String id ,
      })
  async {
    emit(LoadingUpdatePostState());
    DioHelper.putData(
      url: 'truck/$id',
      data: {
        'name' : name,
        'description' : description,
        'price' : price,
        'priceAfterDiscount' : priceAfterDiscount,
        'category' : category,
        'subcategory' : subcategory,
        'brand' : brand,
        'locationFrom' : locationFrom,
        'locationTo' : locationTo,
        'userId' : userId,
      },
    ).then((value)
    {
      print(value.data);
      emit(SuccessUpdatePostState());
    }).catchError((error){
      print(error.toString());
      emit(ErrorUpdatePostState());
    });
  }

  Future<void> updateImagePostData(
      {
         File? photo,
        required String id,
      })
  async {
    emit(LoadingUpdatePostState());
    FormData formData = FormData.fromMap({
      "imageCover" : await MultipartFile.fromFile(photo!.path),
    });
    DioHelper.putData(
      url: 'truck/$id',
      data: formData,
    ).then((value)
    {
      print(value.data);
      emit(SuccessUpdatePostState());
      newPostImage = null ;
    }).catchError((error){
      print(error.toString());
      emit(ErrorUpdatePostState());
    });
  }

  File? newPostImage ;
  var newPicker = ImagePicker();
  Future<void> getNewPostImage(ImageSource imageSource) async  {
    final pickedFile = await newPicker.pickImage(source: imageSource);
    if(pickedFile != null) {
      newPostImage = File(pickedFile.path) ;
      newPostImage = await croppedImage(file: newPostImage);
      print('New Post Image : ${newPostImage.toString()}');
      emit(NewPostImagePickedSuccessState());
    }
    else {
      print('No image selected');
      emit(NewPostImagePickedErrorState());
    }
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

  OneUserData oneUserData  = OneUserData(
      userData: UserData(name: 'name', email: 'email', phone: 'phone',
          verified: false, avatar: '', role: '', nationalId: null, drivingLicense: null, favoriteList: []));
  void getUserDataForCategory(String userId){
    emit(LoadingGetUserData());
    DioHelper.getDate(url:'users/$userId').then((value){
        print(userId);
        print(value.data);
        oneUserData = OneUserData.fromJson(value.data);
      emit(SuccessGetUserData());

    }).catchError((onError){
        print(onError.toString());
    }
    );}

  CategoryModel categoryModel = CategoryModel(id: 'id', name: 'name');
  SubCategory subCategory =SubCategory(id: 'id', name: 'name');
  Brand brand =Brand(id: 'id', name: 'name');

  Future<void> getCategory(String cid) async{
    emit(HomeLoadingGetCategory());
    await DioHelper.getDate(
      url: 'category/$cid',
    ).then((value)
    {
      categoryModel =  CategoryModel.fromJson(value.data);
      emit(HomeSuccessGetCategory());}
    ).catchError((error){
      print(error.toString());
      emit(HomeErrorGetCategory());
    });
  }

  Future<void> getSubCategory(String scid) async {
    emit(HomeLoadingGetSubCategory());
    await DioHelper.getDate(
      url: 'subcategory/$scid',
    ).then((value)
    {
      subCategory =  SubCategory.fromJson(value.data);
      emit(HomeSuccessGetSubCategory());}
    ).catchError((error){
      print(error.toString());
      emit(HomeErrorGetSubCategory());
    });
  }

  Future<void> getBrand(bid) async {
    emit(HomeLoadingGetBrand());
    await DioHelper.getDate(
      url: 'brand/$bid',
    ).then((value)
    {
      brand =  Brand.fromJson(value.data);
      emit(HomeSuccessGetBrand());}
    ).catchError((error){
      print(error.toString());
      emit(HomeErrorGetBrand());
    });
  }

  DetailsEquipment favEquipment = DetailsEquipment(
      images: [],
      ratingCount: 0, id: '0', name: 'name',
      description: 'description', locationFrom: 'locationFrom',
      locationTo: 'locationTo', price: 0, priceAfterDiscount: 0,
      brand: 'brand', subcategory: 'subcategory', category: 'category', createdAt: DateTime(DateTime.april),
      updatedAt: DateTime(DateTime.april), imageCover: 'imageCover', truckId: '0', reviews: [], userId: '');

  List<dynamic> favList = [] ;

  List<DetailsEquipment> favData = [];

  Future<void> getFavoriteList() async {
    emit(HomeLoadingGetFavorite());
    await DioHelper.getDate(
      url: 'favoriteList',
    ).then((value)
    {
      print(value.data);
      favList = value.data ;
      for(var i = 0 ; i <=  favList.length -1; i++)
        {
          getFavCategoryData(favList[i]);
        }
      emit(HomeSuccessGetFavorite());
      print(favData);
    }
    ).catchError((error){
      print(error.toString());
      emit(HomeErrorGetFavorite());
    });
  }

  Future<void> getFavCategoryData(String id) async{
    emit(LoadingFavCategoryDataState());
    await DioHelper.getDate(
      url: 'truck/$id',
    ).then((value)
    {
      favEquipment = DetailsEquipment.fromJson(value.data);
      favData.add(favEquipment);
      emit(SuccessFavCategoryDataState());
    }
    ).catchError((error){

      print(error.toString());
      emit(ErrorFavCategoryDataState());
    });
  }
}