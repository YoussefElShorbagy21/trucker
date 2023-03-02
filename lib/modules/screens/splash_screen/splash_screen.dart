import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../shared/resources/color_manager.dart';
import '../onboarding_screen/onboarding_page.dart';

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
