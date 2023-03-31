import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/layout/homeLayout/cubit/cubit.dart';
import 'package:login/layout/homeLayout/cubit/state.dart';
import 'package:login/shared/resources/app_localizations.dart';

import '../../../../shared/network/local/cache_helper.dart';
import '../onboarding_screen/onboarding_page.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("settings".tr(context)),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocConsumer<HomeCubit, HomeStates>(
              listener: (context, state) {
                CacheHelper.saveData(key:'SettingsPage', value: true,).then((value){
                  if(value == true)
                  {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const OnBoardingPage()));
                  }
                });
              },
              builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Lang'.tr(context),
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),),
                        DropdownButton<String>(
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
                        ),
                      ],
                    );
              },
            )),
      ),
    );
  }
}