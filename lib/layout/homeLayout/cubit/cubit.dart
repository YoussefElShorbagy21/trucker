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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../../models/reviewmodel.dart';
import '../../../modules/customer/screens/home/home.dart';
import '../../../modules/customer/screens/profile/profile_screen.dart';
import '../../../modules/customer/screens/profile/setting_widget/setting_page.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import 'state.dart';
import 'package:image_cropper/image_cropper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    const CategoryScreen(),
    const ProfileScreen(),
    const SettingsPage(),
  ];

  PostEquipment? postEquipment;

  Future<void> postNewEquipment({
    required String name,
    required String description,
    required File? imageCover,
    required String category,
    required String brand,
    required String currentLocation,
    required String? userId,
  }) async {
    emit(HomePostEquipmentLoadingState());
    FormData formData = FormData.fromMap({
      'name': name,
      'description': description,
      'imageCover': await MultipartFile.fromFile(imageCover!.path),
      'category': category,
      'brand': brand,
      'currentLocation': currentLocation,
      'userId': userId,
    });
    DioHelper.postData(
      url: 'truck',
      data: formData,
    ).then((value) {
      print("postData Equipments");
      postEquipment = PostEquipment.fromJson(value.data);
      emit(HomePostEquipmentSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        print(error.response);
        print(error.response!.data['message']);
        print(error.message);
        emit(HomePostEquipmentErrorState(error.response!.data['message']));
      }
    });
  }

  void changeBottomNavIndex(int index) {
    currentIndex = index;
    emit(HomeChangeBottomNav());
  }

  //Image
  File? postImage;

  var picker = ImagePicker();

  Future<void> getPostImage(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      postImage = await croppedImage(file: postImage);
      print(postImage.toString());
      emit(HomePostImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(HomePostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(HomeRemovePostImageState());
  }

  //Image

  Locale locale = const Locale('en');

  Future<String> getCachedSavedLanguage() async {
    final String? cachedLanguageCode = await CacheHelper.getData(key: 'LOCALE');
    if (cachedLanguageCode != null) {
      print('cachedLanguageCode');
      return cachedLanguageCode;
    } else {
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

  OneUserData oneUserData = OneUserData(
      userData: UserData(
          name: 'name',
          email: 'email',
          phone: 'phone',
          verified: false,
          avatar: '',
          role: '',
          nationalId: null,
          favoriteList: [],
          doneTransactions: [],
          currentTransactions: [],
          acceptedTransactions: [],
          id: '',
          reviews: []));

  Map<String, String> favorites = {};
  List<dynamic> reviews = [];

  double finalRatingAverage = 0;

  List<ReviewModel> reviewModel = [];
  dynamic totalRatingAverage = 0;

  Future<void> getUserData({String? userID}) async {
    emit(LoadingGetUserData());
    if (uid == null) {
      print('uid is null');
      await DioHelper.getDate(url: 'users/$userID').then((value) async {
        if (kDebugMode) {
          print('userID: $userID because uid null');
        }
        uid = userID;
        oneUserData = OneUserData.fromJson(value.data);
        print('start search in favoriteList');
        for (var element in oneUserData.userData.favoriteList) {
          favorites.addAll({element: 'find'});
        }
        print(favorites);
        reviews = oneUserData.userData.reviews;
        for (var d = 0; d <= (oneUserData.userData.reviews.length) - 1; d++) {
          await getReviewModel(reviews[d], d);
        }
        finalRatingAverage = totalRatingAverage / reviews.length;
        emit(SuccessGetUserData());
      }).catchError((onError) {
        if (kDebugMode) {
          print(onError.toString());
        }
      });
    } else {
      print('uid is not null');
      print('uid in function getUserData: $uid');
      await DioHelper.getDate(url: 'users/$uid').then((value) async {
        oneUserData = OneUserData.fromJson(value.data);
        print('start search in favoriteList');
        for (var element in oneUserData.userData.favoriteList) {
          favorites.addAll({element: 'find'});
        }
        print(favorites);
        reviews = oneUserData.userData.reviews;
        for (var d = 0; d <= (oneUserData.userData.reviews.length) - 1; d++) {
          await getReviewModel(reviews[d], d);
        }
        finalRatingAverage = totalRatingAverage / reviews.length;
        emit(SuccessGetUserData());
      }).catchError((onError) {
        if (onError is DioError) {
          print(onError.response!.data);
          print(onError.response!.data['message']);
        }
        if (kDebugMode) {
          print(onError.toString());
        }
      });
    }
  }

  Future<void> getReviewModel(String id, d) async {
    emit(HomeReviewLoadingState());
    await DioHelper.getDate(
      url: 'review/$id',
    ).then((value) async {
      reviewModel.add(ReviewModel.fromJson(value.data));
      totalRatingAverage = totalRatingAverage + reviewModel[d].ratingAverage;
      print(totalRatingAverage);
      emit(HomeReviewSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeReviewErrorState());
    });
  }

  AllUserData allUserData = AllUserData(allUser: []);

  void getAllUserData() {
    emit(LoadingGetAllUserData());
    DioHelper.getDate(url: 'users').then((value) {
      allUserData = AllUserData.fromJson(value.data);
      emit(SuccessGetAllUserData());
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
    });
  }

  //update Data User
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  File? profileImage;

  var profilePicker = ImagePicker();

  Future<void> getProfileImage(ImageSource imageSource) async {
    final pickedFile = await profilePicker.pickImage(source: imageSource);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      profileImage = await croppedImage(file: profileImage);
      print(profileImage.toString());
      emit(HomeProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(HomeProfileImagePickedErrorState());
    }
  }

  Future<void> updateUserData({
    required String name,
    required String email,
    required String phone,
    required File? avatar,
  }) async {
    emit(LoadingUpdateUSERState());
    FormData formData = FormData.fromMap({
      'avatar': await MultipartFile.fromFile(avatar!.path),
      'name': name,
      'email': email,
      'phone': phone,
    });
    DioHelper.putData(
      url: 'users/updateMe',
      data: formData,
    ).then((value) {
      oneUserData.userData.name = value.data['updatedUser']['name'];
      oneUserData.userData.avatar = value.data['updatedUser']['avatar'];
      oneUserData.userData.email = value.data['updatedUser']['email'];
      oneUserData.userData.phone = value.data['updatedUser']['phone'];
      oneUserData.userData.verified = value.data['updatedUser']['verified'];
      print(oneUserData.userData.avatar);
      Future.delayed(const Duration(seconds: 10), () {
        getUserData();
      });
      emit(SuccessUpdateUSERState());
    }).catchError((error) {
      if (error is DioError) {
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
  String idCategoryControllerT = '';

  String idSubCategoryControllerT = '';

  String idBrandControllerT = '';

  var categoryControllerT = TextEditingController(text: 'Category');
  var brandControllerT = TextEditingController(text: 'brand');
  var currentLocation = TextEditingController(text: 'currentLocation');

  void setCategory(String selected) {
    categoryControllerT.text = selected;
    switch (categoryControllerT.text) {
      case 'Truck':
        {
          idCategoryControllerT = "64498aa6db60baf726212fb9";
        }
        break;

      case 'pick up':
        {
          idCategoryControllerT = "64498ac2db60baf726212fbb";
        }
        break;
      case 'Heavy Equipment':
        {
          idCategoryControllerT = "64498b04db60baf726212fbd";
        }
        break;
      case 'Others':
        {
          idCategoryControllerT = "64498e8edb60baf726212fc0";
        }
        break;
      default:
        {}
        break;
    }
    print(idCategoryControllerT.toString());
    emit(HomeSetCategory());
  }

  void setBrand(String selected) {
    brandControllerT.text = selected;
    switch (brandControllerT.text) {
      case 'SCANIA':
        {
          idBrandControllerT = "64a5fc1c00bbc200323501b9";
        }
        break;

      case 'MAN':
        {
          idBrandControllerT = "64a5fd5900bbc200323501db";
        }
        break;
      case 'MERCEDES BENZ':
        {
          idBrandControllerT = "64a5fdb000bbc200323501de";
        }
        break;
      case 'VOLVO':
        {
          idBrandControllerT = "64a62efb3605a600324f5682";
        }
        break;
      case 'IVECO':
        {
          idBrandControllerT = "64a62f0b3605a600324f5685";
        }
        break;
      case 'DAF':
        {
          idBrandControllerT = "64a62f543605a600324f5689";
        }
        break;
      case 'OTHER':
        {
          idBrandControllerT = "64a62ffa3605a600324f568c";
        }
        break;
      default:
        {}
        break;
    }
    print(idBrandControllerT.toString());
    emit(HomeSetBrand());
  }

  void setcurrentLocation(String selected) {
    currentLocation.text = selected;
    emit(HomeSetLocationFrom());
  }

  void delayFunction(int time) {
    Future.delayed(Duration(seconds: time), () {
      print(time);
      textController.text = '';
      descriptionController.text = '';
      priceController.text = '';
      idCategoryControllerT = '';
      idSubCategoryControllerT = '';
      idBrandControllerT = '';
      categoryControllerT.text = 'Category';
      brandControllerT.text = 'brand';
      currentLocation.text = 'locationFrom';
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
    if (croppedFile == null) return null;
    return File(croppedFile.path);
  }

  List<CategoryModel> listCate = [];

  List<Brand> listBrand = [];

  Future<void> getCategory() async {
    emit(HomeLoadingGetCategory());
    await DioHelper.getDate(
      url: 'category',
    ).then((value) {
      var re = value.data;
      for (var data in re) {
        listCate.add(CategoryModel(id: data['_id'], name: data['name']));
      }
      emit(HomeSuccessGetCategory());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorGetCategory());
    });
  }

  Future<void> getBrand() async {
    emit(HomeLoadingGetBrand());
    await DioHelper.getDate(
      url: 'brand',
    ).then((value) {
      var re = value.data;
      for (var data in re) {
        listBrand.add(Brand(id: data['_id'], name: data['name']));
      }
      emit(HomeSuccessGetBrand());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorGetBrand());
    });
  }

  Future<void> addFavorite({
    required String truck,
  }) async {
    emit(LoadingAddFavorite());
    await DioHelper.putData(
      url: 'favoriteList',
      data: {"truck": truck},
    ).then((value) {
      print(value.data);
      emit(SuccessAddFavorite());
    }).catchError((error) {
      if (error is DioError) {
        print(error.response);
        print(error.response!.data['message']);
        print(error.message);
        emit(ErrorAddFavorite(error.response!.data['message']));
      }
    });
  }

  Future<void> deleteFavorite({
    required String truck,
  }) async {
    emit(LoadingDeleteFavorite());
    await DioHelper.deleteData(
      url: 'favoriteList',
      data: {"truck": truck},
    ).then((value) {
      print(value.data);
      emit(SuccessDeleteFavorite());
    }).catchError((error) {
      if (error is DioError) {
        print(error.response);
        print(error.response!.data['message']);
        print(error.message);
        emit(ErrorDeleteFavorite(error.response!.data['message']));
      }
    });
  }

  Future<void> delayTime(int time) async {
    print('Time $time');
    Future.delayed(Duration(seconds: time), () async {
      await HomeCubit().getUserData();
    });
    print('Time after delayed $time');
    emit(DelayedFunction());
  }

  String categoryControllerF = 'Category';
  String brandControllerF = 'brand';
  String idCategoryControllerF = '';

  String idBrandControllerF = '';

  void setCategoryF(String selected) {
    categoryControllerF = selected;
    switch (categoryControllerF) {
      case 'Truck':
        {
          idCategoryControllerF = "64498aa6db60baf726212fb9";
        }
        break;

      case 'pick up':
        {
          idCategoryControllerF = "64498ac2db60baf726212fbb";
        }
        break;
      case 'Heavy Equipment':
        {
          idCategoryControllerF = "64498b04db60baf726212fbd";
        }
        break;
      case 'Others':
        {
          idCategoryControllerF = "64498e8edb60baf726212fc0";
        }
        break;
      default:
        {}
        break;
    }
    print(idCategoryControllerF.toString());
    emit(HomeSetCategory());
  }

  void setBrandF(String selected) {
    brandControllerF = selected;
    switch (brandControllerF) {
      case 'SCANIA':
        {
          idBrandControllerF = "64a5fc1c00bbc200323501b9";
        }
        break;

      case 'MAN':
        {
          idBrandControllerF = "64a5fd5900bbc200323501db";
        }
        break;
      case 'MERCEDES BENZ':
        {
          idBrandControllerF = "64a5fdb000bbc200323501de";
        }
        break;
      case 'VOLVO':
        {
          idBrandControllerF = "64a62efb3605a600324f5682";
        }
        break;
      case 'IVECO':
        {
          idBrandControllerF = "64a62f0b3605a600324f5685";
        }
        break;
      case 'DAF':
        {
          idBrandControllerF = "64a62f543605a600324f5689";
        }
        break;
      case 'OTHER':
        {
          idBrandControllerF = "64a62ffa3605a600324f568c";
        }
        break;
      default:
        {}
        break;
    }
    print(idBrandControllerF.toString());
    emit(HomeSetBrand());
  }

  GetEquipment homeModelFilter = GetEquipment(equipment: []);

  Future<void> getFilterData(String category, String brand) async {
    emit(HomeLoadingGetFilterData());
    if (idCategoryControllerF.isNotEmpty && idBrandControllerF.isNotEmpty) {
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
        idBrandControllerF = '';
      }).catchError((error) {
        print(error.toString());
        emit(HomeErrorGetFilterData());
      });
    } else if (idCategoryControllerF.isNotEmpty && idBrandControllerF.isEmpty) {
      await DioHelper.getDate(
        url: 'truck/?category=$category',
      ).then((value) {
        print(value.realUri);
        print(value.data);
        homeModelFilter = GetEquipment.fromJson(value.data);
        emit(HomeSuccessGetFilterData());
        categoryControllerF = 'Category';
        idCategoryControllerF = '';
      }).catchError((error) {
        print(error.toString());
        emit(HomeErrorGetFilterData());
      });
    } else if (idCategoryControllerF.isNotEmpty &&
        idBrandControllerF.isNotEmpty) {
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
        idBrandControllerF = '';
      }).catchError((error) {
        print(error.toString());
        emit(HomeErrorGetFilterData());
      });
    } else if (idCategoryControllerF.isNotEmpty && idBrandControllerF.isEmpty) {
      await DioHelper.getDate(
        url: 'truck/?category=$category',
      ).then((value) {
        print(value.realUri);
        print(value.data);
        homeModelFilter = GetEquipment.fromJson(value.data);
        emit(HomeSuccessGetFilterData());
        categoryControllerF = 'Category';
        idCategoryControllerF = '';
      }).catchError((error) {
        print(error.toString());
        emit(HomeErrorGetFilterData());
      });
    } else if (idCategoryControllerF.isEmpty && idBrandControllerF.isEmpty) {
      await DioHelper.getDate(
        url: 'truck/?',
      ).then((value) {
        print(value.realUri);
        print(value.data);
        homeModelFilter = GetEquipment.fromJson(value.data);
        emit(HomeSuccessGetFilterData());
      }).catchError((error) {
        print(error.toString());
        emit(HomeErrorGetFilterData());
      });
    } else if (idCategoryControllerF.isEmpty && idBrandControllerF.isNotEmpty) {
      await DioHelper.getDate(
        url: 'truck/?brand=$brand',
      ).then((value) {
        print(value.realUri);
        print(value.data);
        homeModelFilter = GetEquipment.fromJson(value.data);
        emit(HomeSuccessGetFilterData());
        brandControllerF = 'brand';
        idBrandControllerF = '';
      }).catchError((error) {
        print(error.toString());
        emit(HomeErrorGetFilterData());
      });
    } else if (idCategoryControllerF.isEmpty && idBrandControllerF.isNotEmpty) {
      await DioHelper.getDate(
        url: 'truck/?brand=$brand',
      ).then((value) {
        print(value.realUri);
        print(value.data);
        homeModelFilter = GetEquipment.fromJson(value.data);
        emit(HomeSuccessGetFilterData());
        brandControllerF = 'brand';
        idBrandControllerF = '';
      }).catchError((error) {
        print(error.toString());
        emit(HomeErrorGetFilterData());
      });
    }
  }

  GetEquipment homeModel = GetEquipment(equipment: []);

  Future<void> getCategoryData(String title) async {
    emit(LoadingCategoryDataState());
    await DioHelper.getDate(
      url: 'truck/?category=$title',
    ).then((value) {
      print(value.realUri);
      print(title);
      print(value.data);
      homeModel = GetEquipment.fromJson(value.data);
      emit(SuccessCategoryDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorCategoryDataState());
    });
  }

  Future<void> getFilterDataCategory(String category, String brand) async {
    emit(HomeLoadingGetFilterDataCategory());
    if (idBrandControllerF.isEmpty) {
      await DioHelper.getDate(
        url: 'truck/?category=$category&subcategory',
      ).then((value) {
        print(value.realUri);
        print(value.data);
        homeModel = GetEquipment.fromJson(value.data);
        emit(HomeSuccessGetFilterDataCategory());
      }).catchError((error) {
        if (error is DioError) {
          print(error.response);
          print(error.response!.data['message']);
          print(error.message);
          emit(HomeErrorGetFilterDataCategory(error.response!.data['message']));
        }
      });
    } else if (idBrandControllerF.isNotEmpty) {
      await DioHelper.getDate(
        url: 'truck/?category=$category&brand=$brand',
      ).then((value) {
        print(value.realUri);
        print(value.data);
        homeModel = GetEquipment.fromJson(value.data);
        emit(HomeSuccessGetFilterData());
        brandControllerF = 'brand';
        idBrandControllerF = '';
      }).catchError((error) {
        print(error.toString());
        emit(HomeErrorGetFilterData());
      });
    } else if (idBrandControllerF.isNotEmpty) {
      await DioHelper.getDate(
        url: 'truck/?category=$category&brand=$brand',
      ).then((value) {
        print(value.realUri);
        print(value.data);
        homeModel = GetEquipment.fromJson(value.data);
        emit(HomeSuccessGetFilterData());
        brandControllerF = 'brand';
        idBrandControllerF = '';
      }).catchError((error) {
        print(error.toString());
        emit(HomeErrorGetFilterData());
      });
    }
  }

  sendMessage({
    required String text,
    required String name,
    required String image,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('chats')
        .doc('64a02c36a1c4301403be0429')
        .collection('message')
        .add({
      'text': text,
      'dateTime':
          "${DateFormat("MM/dd/yyyy").format(DateTime.now())} ${DateFormat("hh:mm:ss a").format(DateTime.now())}",
      'senderId': uid,
      'senderName': name,
      'senderImage': image,
    }).then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc('64a02c36a1c4301403be0429')
        .collection('chats')
        .doc(uid)
        .collection('message')
        .add({
      'text': text,
      'dateTime':
          "${DateFormat("MM/dd/yyyy").format(DateTime.now())} ${DateFormat("hh:mm:ss a").format(DateTime.now())}",
      'senderId': uid,
      'senderName': name,
      'senderImage': image,
    }).then((value) {
      print(
          "${DateFormat("MM/dd/yyyy").format(DateTime.now())} ${DateFormat("hh:mm:ss a").format(DateTime.now())}");
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<dynamic> messages = [];

  getMessage() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('chats')
        .doc('64a02c36a1c4301403be0429')
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(element.data());
      }
      print(messages);
      messages.sort((a, b) {
        final dateA = DateFormat("MM/dd/yyyy hh:mm:ss a").parse(a['dateTime']);
        final dateB = DateFormat("MM/dd/yyyy hh:mm:ss a").parse(b['dateTime']);
        return dateA.compareTo(dateB);
      });
      emit(SocialGetMessageSuccessState());
    });
  }

  List<String> nameBrand = [];

  Future<void> getAllBrand() async {
    emit(LoadingGetAllBrandState());
    await DioHelper.getDate(
      url: 'brand',
    ).then((value) {
      value.data.forEach((element) {
        nameBrand.add(element['name']);
      });
      print(nameBrand);
      emit(SuccessGetAllBrandSState());
    });
  }
}
