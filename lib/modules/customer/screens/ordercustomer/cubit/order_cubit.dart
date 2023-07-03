import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/models/bookingmodel.dart';
import 'package:login/modules/customer/screens/ordercustomer/cubit/order_state.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../../../models/UserData.dart';
import '../../../../../models/categeiromodel.dart';
import '../../../../../shared/components/constants.dart';
import '../../../../../shared/network/remote/dio_helper.dart';

class OrderCubit extends Cubit<OrderStates> {
  OrderCubit() : super(OrderInitialState());
  static OrderCubit get(context) => BlocProvider.of(context);

  //currentTransactions
  List<dynamic> currentTransactions = [] ;

  OneUserData oneUserDataCurrentTransactions  = OneUserData(
      userData: UserData(name: 'name', email: 'email', phone: 'phone',
          verified: false, avatar: '', role: '', nationalId: null,
          favoriteList: [], doneTransactions: [],
          currentTransactions: [], acceptedTransactions: [], id: '', reviews: []));
  Future<void> getUserDataCurrentTransactions({String? userID}) async {
    emit(LoadingGetUserDataCurrentTransactions());
    if (uid == null) {
     await DioHelper.getDate(url: 'users/$userID').then((value) async {
       oneUserDataCurrentTransactions = OneUserData.fromJson(value.data);
        currentTransactions = oneUserDataCurrentTransactions.userData.currentTransactions ;
        for(var d = 0 ; d <=  (currentTransactions.length)-1 ; d++)
        {
          await getTransactionsDataCurrentTransactions(currentTransactions[d], d);
        }
        emit(SuccessGetUserDataCurrentTransactions());
      }).catchError((onError) {
          print(onError.toString());
      });
    }else {
     await DioHelper.getDate(url: 'users/$uid').then((value) async {
       oneUserDataCurrentTransactions = OneUserData.fromJson(value.data);
        currentTransactions = oneUserDataCurrentTransactions.userData.currentTransactions ;
        for(var d = 0 ; d <=  (currentTransactions.length)-1 ; d++)
        {
          await getTransactionsDataCurrentTransactions(currentTransactions[d], d);
        }
        emit(SuccessGetUserDataCurrentTransactions());
      }).catchError((onError) {
          print(onError.toString());
      });
    }

  }

  List<Booking> bookingCurrentTransactions = [];
  String startLocationCurrent = '' ;
  String deliveryLocationCurrent = '' ;
  Future<void> getTransactionsDataCurrentTransactions(String id , int i) async{
    emit(LoadingGetCurrentTransactionsData());
    await DioHelper.getDate(
      url: 'booking/$id',
    ).then((value)
    async {
      bookingCurrentTransactions.add(Booking.fromJson(value.data['ticket']));
        await getCompanyDataCurrentTransactions(bookingCurrentTransactions[i].companyId);
        await getDetailsCategoryDataCurrentTransactions(bookingCurrentTransactions[i].truckId);
      startLocationCurrent  = await getAddressFromLatLngTransactions(bookingCurrentTransactions[i].startLocationLa, bookingCurrentTransactions[i].startLocationLo);
      deliveryLocationCurrent  = await getAddressFromLatLngTransactions(bookingCurrentTransactions[i].deliveryLocationLa, bookingCurrentTransactions[i].deliveryLocationLo);
      emit(SuccessGetCurrentTransactionsData());
    }
    ).catchError((error){
      print(error.toString());
      emit(ErrorGetCurrentTransactionsData());
    });
  }

  List<OneUserData> companyCurrentTransactions  = [];
  Future<void> getCompanyDataCurrentTransactions(String companyId) async{
    emit(LoadingGetUserCompanyIdCurrentTransactions());
     await DioHelper.getDate(url: 'users/$companyId').then((value) {
       companyCurrentTransactions.add(OneUserData.fromJson(value.data));
        emit(SuccessGetUserCompanyIdCurrentTransactions());
      }).catchError((onError) {
        print(onError.toString());
      });
    }

  DetailsEquipment detailsEquipmentCurrentTransactions = DetailsEquipment(
      images: [],
      name: 'name',
      description: 'description',
      brand: 'brand', subcategory: 'subcategory', category: 'category', createdAt: DateTime(DateTime.april),
      updatedAt: DateTime(DateTime.april), imageCover: 'imageCover', truckId: '0', reviews: [], userId: '',
      currentLocation: '');

  Future<void> getDetailsCategoryDataCurrentTransactions(String id) async{
    emit(LoadingCurrentTransactionsDetailsCategoryDataOrderState());
    await DioHelper.getDate(
      url: 'truck/$id',
    ).then((value)
    {
      detailsEquipmentCurrentTransactions = DetailsEquipment.fromJson(value.data);
      emit(SuccessCurrentTransactionsDetailsCategoryDataOrderState());}
    ).catchError((error){

      print(error.toString());
      emit(ErrorCurrentTransactionsDetailsCategoryDataOrderState());
    });
  }

  Future<void> confirmTicket(String ticket , bool confirm) async {
    emit(LoadingConfirmTicketOrderState());
    await DioHelper.postData(
        url: 'booking/confirm?ticket=$ticket',
        data: {
          "booked": confirm
        }).
    then((value) async {
      emit(SuccessConfirmTicketOrderState());
    }).catchError((onError) {
      if(onError is DioError)
      {
        print(onError.response!.data['message']);
        print(onError.message);
        emit(ErrorConfirmTicketOrderState(onError.response!.data['message']));
      }
    });

  }
  //currentTransactions


  //acceptedTransactions
  List<dynamic> acceptedTransactions = [] ;
  OneUserData oneUserDataAcceptedTransactions  = OneUserData(
      userData: UserData(name: 'name', email: 'email', phone: 'phone',
          verified: false, avatar: '', role: '', nationalId: null,
          favoriteList: [], doneTransactions: [],
          currentTransactions: [], acceptedTransactions: [], id: '', reviews: []));
  Future<void> getUserDataAcceptedTransactions({String? userID}) async {
    emit(LoadingGetUserDataAcceptedTransactions());
    if (uid == null) {
      await DioHelper.getDate(url: 'users/$userID').then((value) async {
        oneUserDataAcceptedTransactions = OneUserData.fromJson(value.data);
        acceptedTransactions = oneUserDataAcceptedTransactions.userData.currentTransactions ;
        for(var d = 0 ; d <=  (acceptedTransactions.length)-1 ; d++)
        {
          await getTransactionsDataAcceptedTransactions(acceptedTransactions[d], d);
        }
        emit(SuccessGetUserDataAcceptedTransactions());
      }).catchError((onError) {
        print(onError.toString());
      });
    }else {
      await DioHelper.getDate(url: 'users/$uid').then((value) async {
        oneUserDataAcceptedTransactions = OneUserData.fromJson(value.data);
        acceptedTransactions = oneUserDataAcceptedTransactions.userData.acceptedTransactions ;
        for(var d = 0 ; d <=  (acceptedTransactions.length)-1 ; d++)
        {
          await getTransactionsDataAcceptedTransactions(acceptedTransactions[d], d);
        }
        emit(SuccessGetUserDataAcceptedTransactions());
      }).catchError((onError) {
        print(onError.toString());
      });
    }

  }

  List<Booking> bookingAcceptedTransactions = [];
  String startLocationAccepted = '' ;
  String deliveryLocationAccepted = '' ;
  Future<void> getTransactionsDataAcceptedTransactions(String id , int i) async{
    emit(LoadingGetAcceptedTransactionsData());
    await DioHelper.getDate(
      url: 'booking/$id',
    ).then((value)
    async {
      bookingAcceptedTransactions.add(Booking.fromJson(value.data['ticket']));
      await getCompanyDataAcceptedTransactions(bookingAcceptedTransactions[i].companyId);
      await getDetailsCategoryDataAcceptedTransactions(bookingAcceptedTransactions[i].truckId);
      startLocationAccepted  = await getAddressFromLatLngTransactions(bookingAcceptedTransactions[i].startLocationLa, bookingAcceptedTransactions[i].startLocationLo);
      deliveryLocationAccepted  = await getAddressFromLatLngTransactions(bookingAcceptedTransactions[i].deliveryLocationLa, bookingAcceptedTransactions[i].deliveryLocationLo);
      await getDirectionsAPIResponse(
        bookingAcceptedTransactions[i].startLocationLo,
        bookingAcceptedTransactions[i].startLocationLa,
        bookingAcceptedTransactions[i].deliveryLocationLo,
        bookingAcceptedTransactions[i].deliveryLocationLa,
      );
      emit(SuccessGetAcceptedTransactionsData());
    }
    ).catchError((error){
      print(error.toString());
      emit(ErrorGetAcceptedTransactionsData());
    });
  }

  List<OneUserData> companyAcceptedTransactions  = [];
  Future<void> getCompanyDataAcceptedTransactions(String companyId) async{
    emit(LoadingGetUserCompanyIdAcceptedTransactions());
    await DioHelper.getDate(url: 'users/$companyId').then((value) {
      companyAcceptedTransactions.add(OneUserData.fromJson(value.data));
      emit(SuccessGetUserCompanyIdAcceptedTransactions());
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  DetailsEquipment detailsEquipmentAcceptedTransactions = DetailsEquipment(
      images: [],
      name: 'name',
      description: 'description',
      brand: 'brand', subcategory: 'subcategory', category: 'category', createdAt: DateTime(DateTime.april),
      updatedAt: DateTime(DateTime.april), imageCover: 'imageCover', truckId: '0', reviews: [], userId: '',
      currentLocation: '');

  Future<void> getDetailsCategoryDataAcceptedTransactions(String id) async{
    emit(LoadingAcceptedTransactionsDetailsCategoryDataOrderState());
    await DioHelper.getDate(
      url: 'truck/$id',
    ).then((value)
    {
      detailsEquipmentAcceptedTransactions = DetailsEquipment.fromJson(value.data);
      emit(SuccessAcceptedTransactionsDetailsCategoryDataOrderState());}
    ).catchError((error){

      print(error.toString());
      emit(ErrorAcceptedTransactionsDetailsCategoryDataOrderState());
    });
  }

  //acceptedTransactions

  //DoneTransactions
  List<dynamic> doneTransactions = [] ;
  OneUserData oneUserDataDoneTransactions  = OneUserData(
      userData: UserData(name: 'name', email: 'email', phone: 'phone',
          verified: false, avatar: '', role: '', nationalId: null,
          favoriteList: [], doneTransactions: [],
          currentTransactions: [], acceptedTransactions: [], id: '', reviews: []));
  Future<void> getUserDataDoneTransactions({String? userID}) async {
    emit(LoadingGetUserDataDoneTransactions());
    if (uid == null) {
      await DioHelper.getDate(url: 'users/$userID').then((value) async {
        oneUserDataDoneTransactions = OneUserData.fromJson(value.data);
        doneTransactions = oneUserDataDoneTransactions.userData.doneTransactions ;
        print(doneTransactions.length);
        for(var d = 0 ; d <=  (doneTransactions.length)-1 ; d++)
        {
          await getTransactionsDataDoneTransactions(doneTransactions[d], d);
        }
        emit(SuccessGetUserDataDoneTransactions());
      }).catchError((onError) {
        print(onError.toString());
      });
    }else {
      await DioHelper.getDate(url: 'users/$uid').then((value) async {
        oneUserDataDoneTransactions = OneUserData.fromJson(value.data);
        doneTransactions = oneUserDataDoneTransactions.userData.doneTransactions ;
        print(doneTransactions.length);
        for(var d = 0 ; d <=  (doneTransactions.length)-1 ; d++)
        {
          await getTransactionsDataDoneTransactions(doneTransactions[d], d);
        }
        emit(SuccessGetUserDataDoneTransactions());
      }).catchError((onError) {
        print(onError.toString());
      });
    }

  }

  List<Booking> bookingDoneTransactions = [];
  String startLocationDone = '' ;
  String deliveryLocationDone = '' ;
  Future<void> getTransactionsDataDoneTransactions(String id , int i) async{
    emit(LoadingGetDoneTransactionsData());
    await DioHelper.getDate(
      url: 'booking/$id',
    ).then((value)
    async {
      print(Booking.fromJson(value.data['ticket']));
      bookingDoneTransactions.add(Booking.fromJson(value.data['ticket']));
      await getCompanyDataDoneTransactions(bookingDoneTransactions[i].companyId);
      await getDetailsCategoryDataDoneTransactions(bookingDoneTransactions[i].truckId);
      startLocationDone  = await getAddressFromLatLngTransactions(bookingDoneTransactions[i].startLocationLa, bookingDoneTransactions[i].startLocationLo);
      deliveryLocationDone  = await getAddressFromLatLngTransactions(bookingDoneTransactions[i].deliveryLocationLa, bookingDoneTransactions[i].deliveryLocationLo);

      print(bookingDoneTransactions[i].companyId);
      emit(SuccessGetDoneTransactionsData());
    }
    ).catchError((error){
      print(error.toString());
      emit(ErrorGetDoneTransactionsData());
    });
  }

  List<OneUserData> companyDoneTransactions  = [];
  Future<void> getCompanyDataDoneTransactions(String companyId) async{
    emit(LoadingGetUserCompanyIdDoneTransactions());
    await DioHelper.getDate(url: 'users/$companyId').then((value) {
      companyDoneTransactions.add(OneUserData.fromJson(value.data));
      emit(SuccessGetUserCompanyIdDoneTransactions());
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  DetailsEquipment detailsEquipmentDoneTransactions = DetailsEquipment(
      images: [],
      name: 'name',
      description: 'description',
      brand: 'brand', subcategory: 'subcategory', category: 'category', createdAt: DateTime(DateTime.april),
      updatedAt: DateTime(DateTime.april), imageCover: 'imageCover', truckId: '0', reviews: [], userId: '',
      currentLocation: '');

  Future<void> getDetailsCategoryDataDoneTransactions(String id) async{
    emit(LoadingDoneTransactionsDetailsCategoryDataOrderState());
    await DioHelper.getDate(
      url: 'truck/$id',
    ).then((value)
    {
      detailsEquipmentDoneTransactions = DetailsEquipment.fromJson(value.data);
      print(detailsEquipmentDoneTransactions.name);
      emit(SuccessDoneTransactionsDetailsCategoryDataOrderState());}
    ).catchError((error){

      print(error.toString());
      emit(ErrorDoneTransactionsDetailsCategoryDataOrderState());
    });
  }
  //DoneTransactions

  Future<dynamic> getAddressFromLatLngTransactions(double latitude, double longitude) async {
    final url = 'lat=$latitude&lon=$longitude';
    try {
      final response = await DioHelper.getPlace(url: url,);
      if (response.statusCode == 200) {
        print(response.realUri);
        final name = response.data['display_name'];
        return name;
      } else {
        throw Exception('Failed to get address from latitude and longitude');
      }
    } catch (error) {
      print(error);
      throw Exception('Geocoding failed: $error');
    }
  }



  //polyline
  String baseUrl = 'https://api.mapbox.com/directions/v5/mapbox';
  String accessToken = dotenv.env['MAPBOX_ACCESS_TOKEN']!;
  String navType = 'driving';

  final Dio _dio = Dio();
  Map modifiedResponse = {} ;
  Future getCyclingRouteUsingMapbox(
      double sourceLatLo,
      double sourceLatLa,
      double destinationLo,
      double destinationLa,
      ) async {
    String url =
        '$baseUrl/$navType/$sourceLatLo,$sourceLatLa;$destinationLo,'
        '$destinationLa?alternatives=true&continue_straight=true&geometries=geojson&language=en&overview=full&steps=true&access_token=$accessToken';
    url = Uri.parse(url).toString();
    print(url);

      _dio.options.contentType = Headers.jsonContentType;
      final responseData = await _dio.get(url);
      return responseData.data;
  }

  Future<Map> getDirectionsAPIResponse(
      double sourceLatLo,
      double sourceLatLa,
      double destinationLo,
      double destinationLa,
      ) async {
    final response = await getCyclingRouteUsingMapbox(
      sourceLatLo,
      sourceLatLa,
      destinationLo,
      destinationLa,
    );
    Map geometry = response['routes'][0]['geometry'];


    modifiedResponse = {"geometry": geometry} ;
    return modifiedResponse;
  }

  LatLng getCenterCoordinatesForPolyline(Map geometry) {
    List coordinates = geometry['coordinates'];
    int pos = (coordinates.length / 2).round();
    // print(coordinates[pos][1]);
    // print(coordinates[pos][0]);
    return LatLng(coordinates[pos][1], coordinates[pos][0]);
  }

  LatLng getTripLatLngFromSharedPrefs(String type,
      double sourceLatLo,
      double sourceLatLa,
      double destinationLo,
      double destinationLa,) {
    LatLng source = LatLng(sourceLatLa, sourceLatLo);
    LatLng destination = LatLng(destinationLa, destinationLo);
    if (type == 'source') {
      return source;
    } else {
      return destination;
    }
  }


  bool clearText = false ;
  void  confirmProcess(String code,String  ticket){
    emit(LoadingConfirmProcess());
    DioHelper.postData(url: 'booking/confirmProccess?ticket=$ticket',
        data: {
          'code':code,
        }).then((value) => {
      clearText = true ,
      emit(SuccessConfirmProcess())
    }).catchError((onError){
      if(onError is DioError)
      {
        print(onError.response!.data['message']);
        print(onError.message);
        emit(ErrorConfirmProcess(onError.response!.data['message']));
      }
      clearText = true ;
    });
  }



  //Review
  void  createReview({
    required String service_providerId,
    required String truck,
    required String title,
    required double ratingAverage,
  }){
    emit(LoadingCreateReview());
    DioHelper.postData(url: 'review?service_providerId=$service_providerId',
        data: {
          "title":title,
          "truck":truck,
          "ratingAverage":ratingAverage
        }).then((value) => {
          print(value.data),
      emit(SuccessCreateReview())
    }).catchError((onError){
      if(onError is DioError)
      {
        print(onError.response!.data['message']);
        print(onError.message);
        emit(ErrorCreateReview(onError.response!.data['message']));
      }
    });
  }

}