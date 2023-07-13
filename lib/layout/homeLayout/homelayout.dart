import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/shared/resources/app_localizations.dart';

import '../../modules/customer/screens/ordercustomer/order_customer.dart';
import '../../modules/customer/screens/profile/edit_profile/edit_profile.dart';
import '../../shared/resources/color_manager.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class _HomeLayoutState extends State<HomeLayout> {
  void checkConnectivity(context) async {
    var result = await Connectivity().checkConnectivity();
    print(result);
    if (result == ConnectivityResult.none) {
      print('snakbar');
      const snackBar = SnackBar(
        margin: EdgeInsets.all(50),
        duration: Duration(seconds: 5),
        shape: StadiumBorder(),
        elevation: 5,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        content: Text(
          'Check Your Connection',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    super.initState();
    checkConnectivity(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            if (snapshot.data == ConnectivityResult.none) {
              print(snapshot.data);
              dynamic snackBar = SnackBar(
                margin: const EdgeInsets.all(50),
                duration: const Duration(seconds: 5),
                shape: const StadiumBorder(),
                elevation: 5,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
                content: Text(
                  'Check Your Connection'.tr(context),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
              scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
            }
            return ScaffoldMessenger(
              key: scaffoldMessengerKey,
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: ColorManager.white,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const OrderCustomer(),
                          ));
                    },
                    icon: Icon(
                      Icons.local_shipping_outlined,
                      size: 30,
                      grade: 1.5,
                      color: ColorManager.gery,
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15, top: 5),
                      child: GestureDetector (
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => EditProfileScreen()),
                          );
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: HomeCubit.get(context)
                                  .oneUserData
                                  .userData
                                  .avatar
                                  .isNotEmpty
                              ? NetworkImage(
                                  HomeCubit.get(context)
                                      .oneUserData
                                      .userData
                                      .avatar,
                                )
                              : const NetworkImage(
                                  'https://t3.ftcdn.net/jpg/03/29/17/78/360_F_329177878_ij7ooGdwU9EKqBFtyJQvWsDmYSfI1evZ.jpg',
                                ),
                          child: HomeCubit.get(context)
                                  .oneUserData
                                  .userData
                                  .avatar
                                  .isNotEmpty
                              ? null
                              : Text(
                                  HomeCubit.get(context)
                                      .oneUserData
                                      .userData
                                      .name[0]
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: ColorManager.black,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
                body: cubit.screens[cubit.currentIndex],
                bottomNavigationBar: BottomBar(
                  curve: Curves.linear,
                  selectedIndex: cubit.currentIndex,
                  items: [
                    BottomBarItem(
                      icon: const Icon(Icons.home),
                      title: Text('home'.tr(context)),
                      activeColor: ColorManager.black,
                    ),
                    BottomBarItem(
                      icon: const Icon(
                        Icons.front_loader,
                        size: 30,
                      ),
                      title: Text('Category'.tr(context)),
                      activeColor: ColorManager.black,
                    ),
                    BottomBarItem(
                      icon: const Icon(Icons.person),
                      title: Text('Profile'.tr(context)),
                      activeColor: ColorManager.black,
                    ),
                    BottomBarItem(
                      icon: const Icon(Icons.settings),
                      title: Text('Settings'.tr(context)),
                      activeColor: ColorManager.black,
                    ),
                  ],
                  onTap: (int value) {
                    cubit.changeBottomNavIndex(value);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
