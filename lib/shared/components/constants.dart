import 'package:flutter/material.dart';

import '../../modules/customer/screens/Login Screen/loginScreen.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../network/local/cache_helper.dart';
import 'components.dart';

void sinOut(context) {
  CacheHelper.clearData(key: 'ID').then((value) {
    CacheHelper.clearData(key: 'TokenId');
    if (value == true) {
      navigatefisnh(context, LoginScreen());
      print("token inside clear data : $token uid : $uid");
    }
  });

  if (token != null || uid != null) {
    token = null;
    uid = null;
    print("token in side if condition: $token uid : $uid");
  }
  print('token : $token');
  print('uid: $uid');
}

void navigateFish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (_) => widget,
    ),
    (route) => false);

String? token = CacheHelper.getData(key: 'TokenId');
String? uid = CacheHelper.getData(key: 'ID');
bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

bool? language = CacheHelper.getData(key: 'SettingsPage');

LatLng latLng = const LatLng(0, 0);
