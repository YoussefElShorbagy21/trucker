import 'package:flutter/material.dart';
import 'package:login/layout/homeLayout/cubit/cubit.dart';
import 'package:login/layout/homeLayout/cubit/state.dart';
import 'package:login/shared/resources/app_localizations.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../layout/homeLayout/homelayout.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/font_manager.dart';



class VerifyScreen extends StatelessWidget {
   VerifyScreen({Key? key}) : super(key: key);

  String verify = ' ' ;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => HomeCubit(),
  child: BlocConsumer<HomeCubit, HomeStates>(
  listener: (context, state) {
    if(state is SuccessVerifyEmail)
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeLayout()));
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
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width/35,
                ),
                child: TextButton(
                  onPressed:(){
                    print(verify);
                    HomeCubit.get(context).verifyEmail(verify);
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
