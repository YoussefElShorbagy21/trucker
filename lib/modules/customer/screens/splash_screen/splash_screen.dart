import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../../../shared/resources/color_manager.dart';


class SplashScreen extends StatefulWidget {
  final Widget widget  ;
  const SplashScreen({super.key, required this.widget});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeLocationAndSave();
  }
  Future initializeLocationAndSave() async {
    // Ensure all permissions are collected for Locations
    Location _location = Location();
    bool? _serviceEnabled;
    PermissionStatus? _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
    }

    // Get the current user location
    LocationData _locationData = await _location.getLocation();
    LatLng currentLocation = LatLng(_locationData.latitude!, _locationData.longitude!);
    // dynamic data =  await getParsedReverseGeocoding(currentLocation) ;
    // Get the current user address
    // String currentAddress = data['place'];
    // (await getParsedReverseGeocoding(currentLocation))['place'];
    // Store the user location in sharedPreferences
    CacheHelper.saveData(value: _locationData.latitude!, key: 'latitude');
    CacheHelper.saveData(value:_locationData.longitude!, key: 'longitude');
    // sharedPreferences.setString('current-address', currentAddress);
    //
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      curve: Curves.easeInOutSine,
      splashIconSize: 500,
      backgroundColor: ColorManager.white,
      splashTransition: SplashTransition.sizeTransition,
      duration: 3000,
      pageTransitionType: PageTransitionType.bottomToTop,
      splash:   Column(
        children: [
          Expanded(
            child: Image(
              image:  const AssetImage("assets/images/Logo.png"),
              color: ColorManager.kGold,

            ),
          ),
          const Image(
            image:  AssetImage("assets/images/splash_logo/trucker_logo.png"),

          ),
        ],
      ),
      nextScreen: widget.widget,
    );
  }
}
