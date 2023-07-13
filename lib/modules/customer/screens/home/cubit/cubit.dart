import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/modules/customer/screens/home/cubit/state.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../models/UserData.dart';
import '../../../../../models/categeiromodel.dart';
import '../../../../../models/reviewmodel.dart';
import '../../../../../shared/components/constants.dart';
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
    ).catchError((onError){

      if(onError is DioError) {
        print(onError.message);
        print(onError.response);
          print(onError.response!.data);
        emit(ErrorHomeDataState());
        }
      print(onError);
      emit(ErrorHomeDataState());
    });
  }

  Future<void> onRefresh() async {
    await getHomeData();
    emit(RefreshIndicatorHome());
  }

  DetailsEquipment detailsEquipment = DetailsEquipment(
      images: [],
      name: 'name',
      description: 'description',
      brand: 'brand', category: 'category', createdAt: DateTime(DateTime.april),
      updatedAt: DateTime(DateTime.april), imageCover: 'imageCover', truckId: '0', reviews: [], userId: '',
      currentLocation: '');


  Future<void> getDetailsCategoryData(String id,String cid,String bid) async{
    emit(LoadingDetailsCategoryDataState());
    await DioHelper.getDate(
      url: 'truck/$id',
    ).then((value)
    {
      print(id);
      print(value.data);
      detailsEquipment = DetailsEquipment.fromJson(value.data);
      print(detailsEquipment.userId);
      getCategory(cid);
      getBrand(bid);
      editTextController.text = detailsEquipment.name ;
      editDescriptionController.text = detailsEquipment.description ;
      print(detailsEquipment.userId);
      getUserDataForCategory(detailsEquipment.userId);
      emit(SuccessDetailsCategoryDataState());}
    ).catchError((error){

        print(error.toString());
      emit(ErrorDetailsCategoryDataState());
    });
  }

  var editTextController = TextEditingController();
  var editDescriptionController = TextEditingController();
  var editPriceController = TextEditingController();
  String editIdCategoryControllerT = '' ;
  String editIdBrandControllerT = '' ;
  String editCategoryControllerT = 'Category';
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



  void idBrand(String bid) {
    editIdBrandControllerT = bid ;
    switch(editIdBrandControllerT) {
      case '64a5fc1c00bbc200323501b9': {
        editIdBrandControllerT = "SCANIA";
      }
      break;

      case '64a5fd5900bbc200323501db': {
        editIdBrandControllerT = "MAN";
      }
      break;
      case '64a5fdb000bbc200323501de': {
        editIdBrandControllerT = "MERCEDES BENZ";
      }
      break;
      case '64a62efb3605a600324f5682': {
        editIdBrandControllerT = "VOLVO";
      }
      break;
      case '64a62f0b3605a600324f5685': {
        editIdBrandControllerT = "IVECO";
      }
      break;
      case '64a62f543605a600324f5689': {
        editIdBrandControllerT = "DAF";
      }
      break;
      case '64a62ffa3605a600324f568c': {
        editIdBrandControllerT = "OTHER";
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
      if(error is DioError)
      {
        print(error.response);
        print(error.response!.data['message']);
        print(error.message);
        emit(ErrorUpdatePostState(error.response!.data['message']));
      }
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
      if(error is DioError)
      {
        print(error.response);
        print(error.response!.data['message']);
        print(error.message);
        emit(ErrorUpdatePostState(error.response!.data['message']));
      }
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

  List<dynamic> reviews = [] ;
  double finalRatingAverage = 0 ;
  OneUserData oneUserDataForCategory = OneUserData(
      userData: UserData(name: 'name', email: 'email', phone: 'phone',
          verified: false, avatar: '', role: '',
          nationalId: null, favoriteList: [],
          doneTransactions: [], currentTransactions: [],
          acceptedTransactions: [], id: '', reviews: [])
  );
  void getUserDataForCategory(String userId){
    emit(LoadingGetUserData());
    DioHelper.getDate(url:'users/$userId').then((value) async {
        oneUserDataForCategory = OneUserData.fromJson(value.data);
        reviews = oneUserDataForCategory.userData.reviews ;
        for(var d = 0 ; d <=  (oneUserDataForCategory.userData.reviews.length)-1 ; d++)
        {
          await getReviewModel(reviews[d],d);
        }
        finalRatingAverage = totalRatingAverage / reviews.length ;
        print(reviews);
        print(finalRatingAverage);
      emit(SuccessGetUserData());
    }).catchError((onError){
        print(onError.toString());
    }
    );}

  List<ReviewModel> reviewModel = [];
  List<OneUserData> oneUsersDataForComments = [];
  dynamic totalRatingAverage = 0 ;
  Future<void> getReviewModel(String id,d) async{
    emit(GetReviewLoadingState());
    await DioHelper.getDate(
      url: 'review/$id',
    ).then((value)
    async {
      reviewModel.add(ReviewModel.fromJson(value.data));
      totalRatingAverage = totalRatingAverage + reviewModel[d].ratingAverage ;
      print(totalRatingAverage);
      getUsersDataForComment(reviewModel[d].customerId);
      emit(GetReviewSuccessState());
    }
    ).catchError((error){
      print(error.toString());
      emit(GetReviewErrorState(error.toString()));
    });
  }

  void getUsersDataForComment(String userId){
    emit(LoadingGetUsersDataForComment());
    DioHelper.getDate(url:'users/$userId').then((value) async {
      oneUsersDataForComments.add( OneUserData.fromJson(value.data));
      emit(SuccessGetUsersDataForComment());
    }).catchError((onError){
      print(onError.toString());
      emit(ErrorGetUsersDataForComment());
    }
    );}
  ////review
  CategoryModel categoryModel = CategoryModel(id: 'id', name: 'name');
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

  //favorite

  List<dynamic> favList = [] ;

  Future<void> getFavoriteList() async {
    emit(HomeLoadingGetFavorite());
    await DioHelper.getDate(
      url: 'favoriteList',
    ).then((value)
    async {
      favList = value.data ;
      print(favList);
      for(var i = 0 ; i <=  favList.length -1; i++)
        {
          await getFavCategoryData(favList[i]);
        }
      emit(HomeSuccessGetFavorite());
      print('favList: $favList');
      print('favData: $favData');
    }
    ).catchError((error){
      print(error.toString());
      emit(HomeErrorGetFavorite());
    });
  }

  List<DetailsEquipment> favData = [];
  Future<void> getFavCategoryData(String id) async{
    emit(LoadingFavCategoryDataState());
    await DioHelper.getDate(
      url: 'truck/$id',
    ).then((value)
    {
      favData.add( DetailsEquipment.fromJson(value.data));
      print('in function : getFavCategoryData : ${favData.length}');
      emit(SuccessFavCategoryDataState());
    }
    ).catchError((error){

      print(error.toString());
      emit(ErrorFavCategoryDataState());
    });
  }


  //for map
  Future<List> getParsedResponseForQuery(dynamic value) async {
    List parsedResponses = [];
    // Else search and then send response
    var response = await DioHelper().getSearchResultsFromQueryUsingMapbox(value);

    List features = response['features'];
    for (var feature in features) {
      Map response = {
        'name': feature['text'],
        'address': feature['place_name'].split('${feature['text']}, ')[0],
        'place': feature['place_name'],
        'location': LatLng(feature['center'][1], feature['center'][0])
      };
      parsedResponses.add(response);
    }
    print('==============================================');
    print(parsedResponses);
    print(parsedResponses[0]['location']);
    print('==============================================');
    latLng = parsedResponses[0]['location'];
    print(latLng);

    return parsedResponses;
  }
  List<double> startLocation = [] ;
  List<double> deliveryLocation = [] ;
  Future<dynamic> getAddressFromLatLng(double latitude, double longitude,int i) async {
    final url = 'lat=$latitude&lon=$longitude';
    try {
      final response = await DioHelper.getPlace(url: url,);
      if (response.statusCode == 200) {
        final name = response.data['display_name'];
        if(i == 0) {
          startLocationControllerMap.text =  name ;
          startLocation = [double.parse( response.data['lat']), double.parse( response.data['lon']),];
        }
        if(i == 1) {
          deliveryLocationControllerMap.text = name ;
          deliveryLocation = [double.parse( response.data['lat']), double.parse( response.data['lon']),];
        }
        return name;
      } else {
        throw Exception('Failed to get address from latitude and longitude');
      }
    } catch (error) {
      print(error);
      throw Exception('Geocoding failed: $error');
    }
  }

  var priceControllerMap = TextEditingController();
  var descriptionControllerMap = TextEditingController();
  var startLocationControllerMap = TextEditingController();
  var deliveryLocationControllerMap = TextEditingController();
  var paymentType = TextEditingController();


  Future<void> bookTruck({
    required String description,
    required String price ,
    required String? userId ,
    required String? truckId ,
    required List<double> startLocation,
    required List<double> deliveryLocation,
    required String paymentType ,
  }) async {

    emit(LoadingBookTruckState());
    DioHelper.postData(
      url: 'booking/book_truck?service_providerId=$userId&truckId=$truckId',
      data: {
        'description': description,
        'price': price,
        'startLocation': startLocation,
        'deliveryLocation': deliveryLocation,
        'paymentType':paymentType
      }
    ).then((value)
    {
      print("booking Equipments") ;
      print(value.data);
      print(value.data['ticket']['paymentType']);
      emit(SuccessBookTruckState(value.data));
    }).catchError((error)
    {
      if(error is DioError)
        {
          print(error.response);
          print(error.response!.data['message']);
          emit(ErrorBookTruckState(error.response!.data['message']));
        }
    });
  }

  Future<void> getPaymentType({
    required String ticket ,
  }) async {

    emit(LoadingGetPaymentTypeState());
    DioHelper.postData(
        url: 'booking/confirmPayment?ticket=$ticket',
      data: {}
    ).then((value)
    {
      print(value.data['url']);
      emit(SuccessGetPaymentTypeState(value.data['url']));
    }).catchError((error)
    {
      if(error is DioError)
      {
        print(error.response);
        print(error.response!.data['message']);
        emit(ErrorGetPaymentTypeState(error.response!.data['message']));
      }
    });
  }

  void setPayment(String selected) {
    paymentType.text = selected ;
    emit(PaymentTypeSelect());
  }
  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getDate(
      url: 'truck?keyword=$value',
    ).then((value) {
      print(value.data);
      search = value.data['trucks'] ;
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      if(error is DioError)
      {
        print(error.error);
        print(error.response!.data['message']);
        print(error.message);
        emit(NewsGetSearchErrorState(error.response!.data['message']));
      }
    });
  }
}