import 'package:flutter/material.dart';

import '../../modules/customer/screens/Login Screen/loginScreen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void sinOut(context)
{
  CacheHelper.clearData(key: 'ID').then((value)
      {
        CacheHelper.clearData(key: 'TokenId');
      if(value == true) {
        navigatefisnh(context,LoginScreen() ) ;
      }
  });
  print('token : $token');
  print('uid: $uid');
}

void navigateFish(context , widget) =>  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (_) => widget,
    ),
        (route) => false
);

String? token = CacheHelper.getData(key: 'TokenId');
String? uid = CacheHelper.getData(key: 'ID');
bool? onBoarding = CacheHelper.getData(key: 'onBoarding') ;
bool? choseUser = CacheHelper.getData(key: 'ChoseUser');
bool? language = CacheHelper.getData(key: 'SettingsPage') ;
bool? verify = CacheHelper.getData(key: 'VerifyScreen') ;