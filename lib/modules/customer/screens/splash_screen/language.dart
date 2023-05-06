import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/layout/homeLayout/cubit/cubit.dart';
import 'package:login/layout/homeLayout/cubit/state.dart';
import 'package:login/shared/resources/app_localizations.dart';

import '../../../../shared/network/local/cache_helper.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/font_manager.dart';
import '../onboarding_screen/onboarding_page.dart';



class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool checkBoxValueA = false;
  bool checkBoxValueE = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocConsumer<HomeCubit, HomeStates>(
              listener: (context, state) {
              },
              builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/Logo.png',
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 8,
                        ),
                        Text('Lang'.tr(context),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: ColorManager.gery,

                        ),),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 30,
                        ),
                        Container(
                          width: double.infinity,
                          height: 80,
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width/35,
                          ),
                          child: TextButton(
                            onPressed:(){
                              setState(() {
                                if(checkBoxValueA == true) {
                                  checkBoxValueA = false;
                                  checkBoxValueE = true ;
                                }
                                else {
                                  checkBoxValueA = true;
                                  checkBoxValueE = false ;
                                }

                                if(checkBoxValueA == true)   {
                                  context.read<HomeCubit>().cachedLanguageCode('ar');
                                }
                              });
                            } ,
                            style: TextButton.styleFrom(
                              shape: const StadiumBorder(
                                side: BorderSide(
                                    color: Colors.grey,
                                    width: 1
                                ),
                              ),
                              backgroundColor: ColorManager.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: checkBoxValueA,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      checkBoxValueA = newValue! ;
                                    });
                                  },
                                  activeColor: const Color(0xFFffbb02),
                                  shape: const CircleBorder(),
                                ),
                                Image.asset('assets/images/1200px-Flag_of_Egypt_(variant).png',
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text("العربية",
                                  style: TextStyle(
                                    color: ColorManager.black,
                                    fontFamily: FontConstants.fontFamily,
                                    fontSize: FontSize.s22,
                                    fontWeight: FontWeightManager.semiBold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 80,
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width/35,
                          ),
                          child: TextButton(
                            onPressed:(){
                              setState(() {
                                if(checkBoxValueE == true) {
                                  checkBoxValueE = false;
                                  checkBoxValueA = true;
                                }
                                else {
                                  checkBoxValueE = true;
                                  checkBoxValueA = false;
                                }

                                if(checkBoxValueE == true)   {
                                  context.read<HomeCubit>().cachedLanguageCode('en');
                                }
                              });
                            } ,
                            style: TextButton.styleFrom(
                              shape: const StadiumBorder(
                                side: BorderSide(
                                    color: Colors.grey,
                                    width: 1
                                ),
                              ),
                              backgroundColor: ColorManager.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: checkBoxValueE,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      checkBoxValueE = newValue! ;
                                    });
                                  },
                                  activeColor: const Color(0xFFffbb02),
                                  shape: const CircleBorder(),
                                ),
                                Image.asset('assets/images/Flag_of_the_United_Kingdom.png',
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text('English',
                                  style: TextStyle(
                                    color: ColorManager.black,
                                    fontFamily: FontConstants.fontFamily,
                                    fontSize: FontSize.s22,
                                    fontWeight: FontWeightManager.semiBold,
                                  ),
                                ),
                              ],
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
                              CacheHelper.saveData(key:'SettingsPage', value: true,).then((value){
                                if(value == true)
                                {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const OnBoardingPage()));
                                }
                              });
                            } ,
                            style: TextButton.styleFrom(
                              shape: const StadiumBorder(),
                              backgroundColor: const Color.fromRGBO(255, 188, 0,1),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child:  Text("confirm".tr(context),
                              style: TextStyle(
                                color: ColorManager.white,
                                fontFamily: FontConstants.fontFamily,
                                fontSize: FontSize.s22,
                                fontWeight: FontWeightManager.semiBold,
                              ),
                            ),
                          ),
                        ),
                        /*DropdownButton<String>(
                          value: HomeCubit.get(context).locale.languageCode,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: ['ar', 'en'].map((String items) {
                            return DropdownMenuItem<String>(
                              value: items,
                              child: items == 'ar'?  const Text('العربية') : const Text('English'),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              context.read<HomeCubit>().cachedLanguageCode(newValue);
                            }
                          },
                        ),*/
                      ],
                    );
              },
            )),
      ),
    );
  }
}