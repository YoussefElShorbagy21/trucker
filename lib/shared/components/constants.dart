import 'package:flutter/material.dart';

import '../../modules/customer/screens/Login Screen/loginScreen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void sinOut(context)
{
  CacheHelper.clearData(key: 'TokenId');
  CacheHelper.clearData(key: 'token').then((value)
      {
      if(value == true) {
        navigatefisnh(context,LoginScreen() ) ;
      }
  });
}

void printFullText( String? text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text!).forEach((match) => print(match.group(0)));
}

void navigateTo(context , widget) =>  Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context)  => widget,
  ),
);

void navigateFish(context , widget) =>  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (route) => false
);

String? token = CacheHelper.getData(key: 'TokenId');
String? uid = CacheHelper.getData(key: 'ID');
bool? onBoarding = CacheHelper.getData(key: 'onBoarding') ;
bool? choseUser = CacheHelper.getData(key: 'ChoseUser');
bool? language = CacheHelper.getData(key: 'SettingsPage') ;