import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/modules/screens/search/search_screen.dart';

import '../../shared/resources/color_manager.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';


class HomeLayout extends StatelessWidget {


  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit(),
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: ColorManager.white,
              leading: IconButton(
                onPressed: (){},
                icon: Icon(Icons.local_shipping_outlined,size: 30,color: ColorManager.gery,),
              ),
              actions: [
                IconButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                    },
                    icon: Icon(Icons.search,size: 30,color: ColorManager.gery,),
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomBar(
              curve: Curves.linear,
              selectedIndex: cubit.currentIndex,
              items:   [
                BottomBarItem(
                  icon: const Icon(Icons.home),
                  title: const Text('Home'),
                  activeColor: ColorManager.black,
                ),
                BottomBarItem(
                  icon: const Icon(Icons.favorite),
                  title: const Text('Favorite'),
                  activeColor: ColorManager.black,
                ),
                BottomBarItem(
                  icon: const Icon(Icons.network_check_outlined),
                  title: const Text('Communication'),
                  activeColor: ColorManager.black,
                ),
                BottomBarItem(
                  icon: const Icon(Icons.person),
                  title: const Text('Profile'),
                    activeColor: ColorManager.black,
                ),
              ],
              onTap: (int value) {
                cubit.changeBottomNavIndex(value);
              },
            ),
          );
        },
      ),
    );
  }
}
