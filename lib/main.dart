import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login/layout/homeLayout/cubit/cubit.dart';
import 'package:login/layout/homeLayout/cubit/state.dart';
import 'package:login/layout/homeLayout/homelayout.dart';
import 'package:login/modules/screens/home/cubit/cubit.dart';
import 'package:login/shared/network/local/cache_helper.dart';
import 'package:login/shared/network/remote/dio_helper.dart';
import 'package:login/shared/resources/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/screens/Login Screen/loginScreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.inti();
  await CacheHelper.init();
  Widget widget;
  String? uid = CacheHelper.getData(key: 'token');
  if (kDebugMode) {
    print(uid);
  }

  if (uid != null) {
    widget = const HomeLayout();
  }
  else {
    widget = LoginScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp(this.startWidget, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()..getUserData()),
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: ColorManager.white,
            ),
            title: 'Login screen',
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
