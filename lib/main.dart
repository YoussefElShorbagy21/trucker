import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:login/layout/homeLayout/cubit/cubit.dart';
import 'package:login/layout/homeLayout/cubit/state.dart';
import 'package:login/layout/homeLayout/homelayout.dart';
import 'package:login/modules/customer/screens/Login%20Screen/cubit/login_cubit.dart';
import 'package:login/modules/customer/screens/Login%20Screen/loginScreen.dart';
import 'package:login/shared/bloc_observer.dart';
import 'package:login/shared/components/constants.dart';
import 'package:login/shared/network/local/cache_helper.dart';
import 'package:login/shared/network/remote/dio_helper.dart';
import 'package:login/shared/resources/app_localizations.dart';
import 'package:login/shared/resources/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/customer/screens/chose_app/chose_app.dart';
import 'modules/customer/screens/onboarding_screen/onboarding_page.dart';
import 'modules/customer/screens/splash_screen/language.dart';
import 'modules/customer/screens/splash_screen/splash_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.inti();
  await CacheHelper.init();
  Widget widget;

  print(token);
  print(uid);
  print(choseUser);
  print(onBoarding);
  print(language);

  if(language != null)
    {
      if(onBoarding != null)
      {
        if(choseUser != null)
          {
            if (uid != null) {
              widget = const HomeLayout();
            }
            else {
              widget =  LoginScreen();
            }
          }
        else {
          widget = const ChoseApp();
        }
      }
      else{
        widget = const OnBoardingPage();
      }
    }
  else
    {
      widget = const SettingsPage();
    }

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp(this.startWidget, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
            BlocProvider<HomeCubit>(create: (context) => HomeCubit()..getUserData()..getSavedLanguage()),
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
            return MaterialApp(
              locale: HomeCubit.get(context).locale,
              theme: ThemeData(
                useMaterial3: true,
                colorSchemeSeed: ColorManager.white,
              ),
              supportedLocales: const [
                Locale('ar'),
                Locale('en'),
              ],
              localizationsDelegates:  const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (deviceLocal,supportedLocales){
                for(var locale in supportedLocales)
                {
                  if(deviceLocal != null && deviceLocal.languageCode == locale.languageCode)
                  {
                    return deviceLocal;
                  }
                }
                return supportedLocales.first;

              },
              debugShowCheckedModeBanner: false,
              home: SplashScreen(widget: startWidget),
            );
        },
      ),
    );
  }
}
