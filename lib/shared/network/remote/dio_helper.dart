import 'package:dio/dio.dart';

import '../../components/constants.dart';
import '../local/cache_helper.dart';

class DioHelper
{
  static late Dio dio ;
  static late Dio dio2 ;
  static inti()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://truker.genius0x1.com/api/v1/',
        receiveDataWhenStatusError: true,
      ),
    );
    dio2 = Dio(
      BaseOptions(
        baseUrl: 'https://excited-bee-buckle.cyclic.app/',
        receiveDataWhenStatusError: true,
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


  static Future<Response> postOCR({
    required String url,
    required dynamic data ,
  }) async
  {
    return dio2.post(
      url ,
      data: data,
    );
  }
}