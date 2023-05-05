
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/layout/homeLayout/cubit/cubit.dart';
import 'package:login/modules/customer/screens/home/cubit/state.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../models/UserData.dart';
import '../../../../../models/categeiromodel.dart';
import '../../../../../shared/network/remote/dio_helper.dart';
import 'package:image_cropper/image_cropper.dart';

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
        print(error.toString());
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
      editTextController.text = getDetailsEquipment.equipment.title ;
      editDescriptionController.text = getDetailsEquipment.equipment.description ;
      editPriceController.text = getDetailsEquipment.equipment.price.toString() ;
      editCategoryController.text = getDetailsEquipment.equipment.category ;
      editGovernmentController.text = getDetailsEquipment.equipment.government ;
      getUserDataForCategory(getDetailsEquipment.equipment.userId);
      emit(SuccessDetailsCategoryDataState());}
    ).catchError((error){

        print(error.toString());
      emit(ErrorDetailsCategoryDataState());
    });
  }

  Future<void> getCategoryData(String title) async{
    emit(LoadingCategoryDataState());
    await DioHelper.getDate(
      url: 'Equipments/?category=$title',
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
  var editTextController = TextEditingController();
  var editDescriptionController = TextEditingController();
  var editPriceController = TextEditingController();
  var editCategoryController = TextEditingController();
  var editGovernmentController = TextEditingController();

  Future<void> updatePostData(
      {
        required String title ,
        required String description,
        required int price ,
        required String category ,
        required String government ,
        required String id,
      })
  async {
    emit(LoadingUpdatePostState());
    DioHelper.putData(
      url: 'Equipments/$id',
      data: {
        "title" : title,
        "description" : description,
        "price" : price,
        "category" : category,
        "government" : government,
      },
    ).then((value)
    {
      print('editTextController : ${editTextController.text}');
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
      "photo" : await MultipartFile.fromFile(photo!.path),
    });
    DioHelper.putData(
      url: 'Equipments/$id',
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

  UserData userData  = UserData(name: 'newName', email: '',verified: false, avatar: '', phone: '', role: '');
  void getUserDataForCategory(String userId){
    emit(LoadingGetUserData());
    DioHelper.getDate(url:'users/$userId').then((value){
        print(userId);
        print(value.data);
      userData = UserData.fromJson(value.data);
      emit(SuccessGetUserData());

    }).catchError((onError){
        print(onError.toString());
    }
    );}

}