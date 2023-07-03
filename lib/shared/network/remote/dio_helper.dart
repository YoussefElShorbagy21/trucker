import 'package:dio/dio.dart';

import '../../components/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../local/cache_helper.dart';

class DioHelper
{
  static late Dio dio ;
  static late Dio dio1 ;
  static inti()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://truker.genius0x1.com/api/v1/',
        receiveDataWhenStatusError: true,
      ),
    );

    dio1 = Dio(
      BaseOptions(
        baseUrl: 'https://nominatim.openstreetmap.org/reverse?format=jsonv2&',
      ),
    );
  }



  static Future<Response> getDate({
  required String url,
   Map<String,dynamic>? query ,
    String tokenVerify = ''
  }) async
  {
    dio.options.headers = {
      'Authorization':'Bearer ${tokenVerify.isEmpty ? token : tokenVerify}',
    };
    return await dio.get(
      url ,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
     Map<String,dynamic>? query ,
    required dynamic data ,
    String tokenVerify = ''
  }) async
  {
    dio.options.headers = {
      'Authorization':'Bearer ${tokenVerify.isEmpty ? token : tokenVerify}',
    };
     return dio.post(
       url ,
       queryParameters: query,
       data: data,
     );
  }

  static Future<Response> putData({
    required String url,
    Map<String,dynamic>? query ,
    required dynamic data ,
  }) async
  {
    dio.options.headers = {
      'Authorization':'Bearer $token',
    };
    return dio.patch(
      url ,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> deleteData({
    required String url,
    dynamic data,
  }) async
  {
    dio.options.headers = {
      'Authorization':'Bearer $token',
    };
    return dio.delete(
      url ,
      data: data,
    );
  }



  static Future<Response> getPlace({
    required String url,
  }) async
  {
    return await dio1.get(
      url ,
    );
  }

  //for map

  String baseUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places';
  String accessToken = dotenv.env['MAPBOX_ACCESS_TOKEN']!;
  String searchResultsLimit = '10';
  String proximity =
      '${CacheHelper.getData(key: 'longitude')}%2C${CacheHelper.getData(key: 'latitude')}';
  String country = 'eg';

  Future getSearchResultsFromQueryUsingMapbox(String query) async {
    String url =
        '$baseUrl/$query.json?country=$country&language=ar%2Cen&limit=$searchResultsLimit&proximity=$proximity&autocomplete=true&access_token=$accessToken';
    url = Uri.parse(url).toString();
    print(url);
    dio.options.contentType = Headers.jsonContentType;
    final responseData = await dio.get(url);
    return responseData.data;
  }
}