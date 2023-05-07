import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/shared/resources/app_localizations.dart';

import '../../shared/resources/color_manager.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


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
                 const Text('Cairo, EG',
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
                  backgroundImage: HomeCubit.get(context).oneUserData.userData.avatar.isNotEmpty ? NetworkImage(HomeCubit.get(context).oneUserData.userData.avatar) :
                  const NetworkImage('https://t3.ftcdn.net/jpg/03/29/17/78/360_F_329177878_ij7ooGdwU9EKqBFtyJQvWsDmYSfI1evZ.jpg',),
                  child: HomeCubit.get(context).oneUserData.userData.avatar.isNotEmpty ? null : Text(
                      HomeCubit.get(context).oneUserData.userData.name[0].toUpperCase(),
                    style: TextStyle(
                      fontSize: 30,
                      color: ColorManager.black,
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
                icon: const Icon(FontAwesomeIcons.solidComments),
                title: Text('Chat'.tr(context)),
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
