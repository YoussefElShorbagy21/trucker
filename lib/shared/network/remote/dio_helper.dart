import 'package:dio/dio.dart';

import '../../components/constants.dart';
import '../local/cache_helper.dart';

class DioHelper
{
  static late Dio dio ;
  static inti()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://cute-cyan-coyote-fez.cyclic.app/api/v1/',
        receiveDataWhenStatusError: true,
      ),
    );
  }


  static Future<Response> getDate({
  required String url,
   Map<String,dynamic>? query ,
  }) async
  {
    dio.options.headers = {
      'Authorization':'Bearer $token',
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
    String tokenVerify = '',//Map<String,dynamic>
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
    required Map<String,dynamic> data ,
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
    required String url, //Map<String,dynamic>
  }) async
  {
    dio.options.headers = {
      'Authorization':'Bearer $token',
    };
    return dio.delete(
      url ,
    );
  }
}