import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:truck_app/modules/onboarding_screen/onboarding_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:truck_app/shared/style/color_manager.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 200,
      backgroundColor: ColorManager.black,
      splashTransition: SplashTransition.sizeTransition,
      pageTransitionType: PageTransitionType.bottomToTop,
      splash: const CircleAvatar(
        radius: 90,
        backgroundImage: AssetImage("assets/images/splash_logo/trucker_logo.png"),
      ),


      nextScreen: const OnBoardingPage(),
    );
  }
}
