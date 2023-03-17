import 'package:flutter/material.dart';
import 'package:login/modules/customer/screens/Login%20Screen/loginScreen.dart';
import 'package:login/shared/resources/app_localizations.dart';

import '../../../../shared/network/local/cache_helper.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/font_manager.dart';



class ChoseApp extends StatelessWidget {
  const ChoseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Hello_app'.tr(context),
             textAlign: TextAlign.center,
             style: const TextStyle(
               fontWeight: FontWeight.bold,
               fontSize: 20,
             ),),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
            ),
            Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width/35,
          ),
          child: TextButton(
            onPressed:(){
              CacheHelper.saveData(key:'ChoseUser', value: true,).then((value) {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginScreen()));
              });

            } ,
            style: TextButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: ColorManager.black,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child:  Text("Customer".tr(context),
              style: TextStyle(
                color: ColorManager.white,
                fontFamily: FontConstants.fontFamily,
                fontSize: FontSize.s22,
                fontWeight: FontWeightManager.semiBold,
              ),
            ),
          ),
        ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width/35,
        ),
        child: TextButton(
          onPressed:(){
            CacheHelper.saveData(key:'ChoseUser', value: true,).then((value) {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginScreen()));
            });
          } ,
          style: TextButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: ColorManager.black,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child:  Text("service_provider".tr(context),
            style: TextStyle(
              color: ColorManager.white,
              fontFamily: FontConstants.fontFamily,
              fontSize: FontSize.s22,
              fontWeight: FontWeightManager.semiBold,
            ),
          ),
        ),
    ),
          ],
        ),
      ),
    );
  }
}
