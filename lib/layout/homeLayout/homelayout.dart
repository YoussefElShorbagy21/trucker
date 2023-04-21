import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/modules/customer/screens/home/cubit/cubit.dart';
import 'package:login/shared/resources/app_localizations.dart';

import '../../models/categeiromodel.dart';
import '../../modules/customer/screens/search/search_screen.dart';
import '../../shared/resources/color_manager.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';


class HomeLayout extends StatelessWidget {
  
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 30,
            toolbarHeight: MediaQuery.of(context).size.height / 10,
            elevation: 0,
            backgroundColor: ColorManager.white,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.local_shipping_outlined, size: 30,
                color: ColorManager.gery,),
            ),
            title: Row(
              children:  [
                const Icon(Icons.location_on_rounded, size: 25,),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 22,
                ),
                 const Text('California, Us',
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'
                  ),),
              ],
            ),

            actions:  [
               Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(HomeCubit.get(context).userData.avatar),
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
                icon: const Icon(Icons.category),
                title: Text('Category'.tr(context)),
                activeColor: ColorManager.black,
              ),
              BottomBarItem(
                icon: const Icon(Icons.network_check_outlined),
                title: Text('Communication'.tr(context)),
                activeColor: ColorManager.black,
              ),
              BottomBarItem(
                icon: const Icon(Icons.person),
                title: Text('Profile'.tr(context)),
                activeColor: ColorManager.black,
              ),
            ],
            onTap: (int value) {
              cubit.changeBottomNavIndex(value);
            },
          ),
        );
      },
    );
  }
}
