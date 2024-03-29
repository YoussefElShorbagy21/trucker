import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:login/layout/homeLayout/cubit/cubit.dart';
import 'package:login/layout/homeLayout/cubit/state.dart';
import 'package:login/layout/homeLayout/homelayout.dart';
import 'package:login/modules/customer/screens/Login%20Screen/loginScreen.dart';
import 'package:login/modules/customer/screens/Sign%20Up%20Screen/cubit/register_cubit.dart';
import 'package:login/modules/customer/screens/ordercustomer/cubit/order_cubit.dart';
import 'package:login/shared/bloc_observer.dart';
import 'package:login/shared/components/constants.dart';
import 'package:login/shared/network/local/cache_helper.dart';
import 'package:login/shared/network/remote/dio_helper.dart';
import 'package:login/shared/resources/app_localizations.dart';
import 'package:login/shared/resources/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/customer/screens/home/cubit/cubit.dart';
import 'modules/customer/screens/onboarding_screen/onboarding_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'modules/customer/screens/splash_screen/language.dart';
import 'modules/customer/screens/splash_screen/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  DioHelper.inti();
  await dotenv.load(fileName: "assets/config/.env");
  await CacheHelper.init();
  Widget widget;

  print('token : $token');
  print('uid: $uid');
  print("onBoarding: $onBoarding");
  print("language: $language");

  if (language != null) {
    if (onBoarding != null) {
      if (uid != null) {
        widget = const HomeLayout(); //HomeLayout
      } else {
        widget = LoginScreen();
      }
    } else {
      widget = const OnBoardingPage();
    }
  } else {
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
        BlocProvider<HomeCubit>(
            create: (context) => HomeCubit()
              ..getUserData()
              ..getSavedLanguage()
              ..getAllUserData()
              ..getCategory()
              ..getBrand()
              ..getAllBrand()),
        BlocProvider<HomeScreenCubit>(
            create: (context) => HomeScreenCubit()..getHomeData()..getFavoriteList()),
        BlocProvider<RegisterCubit>(create: (context) => RegisterCubit()),
        BlocProvider<OrderCubit>(
            create: (context) => OrderCubit()
              ..getUserDataCurrentTransactions()
              ..getUserDataAcceptedTransactions()
              ..getUserDataDoneTransactions()),
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            locale: HomeCubit.get(context).locale,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme:
                  ColorScheme.fromSeed(seedColor: ColorManager.accentColor),
            ),
            supportedLocales: const [
              Locale('ar'),
              Locale('en'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (deviceLocal, supportedLocales) {
              for (var locale in supportedLocales) {
                if (deviceLocal != null &&
                    deviceLocal.languageCode == locale.languageCode) {
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
