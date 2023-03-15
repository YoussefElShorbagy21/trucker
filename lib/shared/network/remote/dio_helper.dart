import 'package:dio/dio.dart';

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
    String lang = 'en',
    String token = '' ,
  }) async
  {
    dio.options.headers =
    {
      'Content-Type':'application/json',
      'lang' : lang ,
      'Authorization':token,
    };
    return await dio.get(
      url ,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
     Map<String,dynamic>? query ,
    required dynamic data , //Map<String,dynamic>
    String lang = 'en',
    String token = '',
  }) async
  {
    dio.options.headers =
    {
        'lang' : lang ,
        'Authorization':token,
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
    String lang = 'en',
    String token = '',
  }) async
  {
    dio.options.headers =
    {
      'lang' : lang ,
      'Authorization':token,
    };
    return dio.put(
      url ,
      queryParameters: query,
      data: data,
    );
  }

}