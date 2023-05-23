import 'package:flutter/material.dart';
import 'package:login/shared/components/constants.dart';
import 'package:login/shared/resources/app_localizations.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../layout/homeLayout/homelayout.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/font_manager.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

import 'cubit/register_cubit.dart';
import 'cubit/register_state.dart';



class VerifyScreen extends StatelessWidget {
  String verify = ' ' ;
  String tokenVerify ='';
  VerifyScreen(this.tokenVerify,{super.key});
  @override
  Widget build(BuildContext context) {
    print('in verify $token');
    return BlocProvider(
  create: (context) => RegisterCubit(),
  child: BlocConsumer<RegisterCubit, RegisterState>(
  listener: (context, state) {
    if(state is SuccessVerifyEmail)
      {
        CacheHelper.saveData(key:'VerifyScreen', value: true,).then((value) {
          HomeCubit.get(context).changeBottomNavIndex(0);
          return Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeLayout()));
        }
        );
      }
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Verify_title'.tr(context),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  letterSpacing: 2,
                  fontSize: 25,
                ),),
              Text('Verify_suptitle'.tr(context),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),),
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
              ),
              OtpTextField(
                numberOfFields: 6,
                borderColor: ColorManager.white,
                focusedBorderColor: ColorManager.black,
                showFieldAsBox: true,
                keyboardType: TextInputType.text,
                clearText: false,
                onSubmit: (String verificationCode){
                  print(verificationCode);
                  verify = verificationCode ;
                }
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Text('Verify_help'.tr(context),
                textAlign: TextAlign.center,
                style:  TextStyle(
                  color: ColorManager.gery,
                  fontSize: 17,
                ),),
              SizedBox(
                height: MediaQuery.of(context).size.height / 7,
              ),
              Conditional.single(
                  context: context ,
                  conditionBuilder: (BuildContext  context) => state is! LoadingVerifyEmail,
                  widgetBuilder: (context){
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width/35,
                      ),
                      child: TextButton(
                        onPressed:(){
                          print(verify);
                          print(token);
                          RegisterCubit.get(context).verifyEmail(verify,tokenVerify);
                        } ,
                        style: TextButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: ColorManager.black,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child:  Text("Verify_button".tr(context),
                          style: TextStyle(
                            color: ColorManager.white,
                            fontFamily: FontConstants.fontFamily,
                            fontSize: FontSize.s22,
                            fontWeight: FontWeightManager.semiBold,
                          ),
                        ),
                      ),
                    );
                  },
                  fallbackBuilder: (context) {
                    return const Center(child: CircularProgressIndicator()) ;
                  }
              ),
              Center(
                child: TextButton(onPressed: () {
                  RegisterCubit.get(context).sendOtpAgain(tokenVerify);
                },
                  child:  Text('sendOtpAgain',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: ColorManager.black,
                  ),),),
              ),
            ],
          ),
        ),
      ),
    );
  },
),
);
  }
}
