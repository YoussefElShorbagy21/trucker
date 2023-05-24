import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/shared/resources/app_localizations.dart';
import '../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../layout/homeLayout/cubit/state.dart';
import '../../../../shared/resources/color_manager.dart';
import 'setting_widget/setting_page.dart';
import 'setting_widget/setting_widget.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<HomeCubit,HomeStates>(
        listener:(context,state) {},
        builder: (context, state) {
         return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration:   BoxDecoration(
            gradient: LinearGradient(
              colors: [
                // Color.fromRGBO(4, 9, 35, 1),
                // Color.fromRGBO(39, 105, 171, 1),
               //  ColorManager.black,
               const Color.fromRGBO(4, 9, 35, 1),
                ColorManager.white,
              ],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                   SizedBox(
                    height: screenHeight * 0.028,    //20
                  ),
                  //   Text(
                  //   'My\nProfile'.tr(context),
                  //   textAlign: TextAlign.center,
                  //   style: const TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 34,
                  //     fontFamily: 'NiseBuschGardens',
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 22,
                  // ),
                  SizedBox(
                    height: screenHeight * 0.43,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double localHeight = constraints.maxHeight;
                        double localWidth = constraints.maxWidth;

                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: localHeight * 0,
                              left: localWidth*0,
                              right: localWidth*0,
                              child: Container(
                                height: localHeight * 0.72,
                                width: localWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                     SizedBox(
                                      height: localHeight * 0.25,
                                    ),
                                     Text(
                                       HomeCubit.get(context).oneUserData.userData.name, //name of user
                                      style: const TextStyle(
                                        color: Color.fromRGBO(39, 105, 171, 1),
                                        fontFamily: 'Nunito',
                                        fontSize: 30,
                                      ),
                                    ),
                                     SizedBox(
                                      height: localHeight /100,
                                    ),
                                    Text(
                                      HomeCubit.get(context).oneUserData.userData.email, //name of user
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Color.fromRGBO(39, 105, 171, 1),
                                        fontFamily: 'Nunito',
                                        fontSize: 20,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Orders'.tr(context),
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'NiseBuschGardens',
                                                fontSize: 20,
                                              ),
                                            ),
                                            const Text(
                                              '10', //numbers of orders
                                              style: TextStyle(
                                                color:
                                                Color.fromRGBO(39, 105, 171, 1),
                                                fontFamily: 'NiseBuschGardens',
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 25,
                                            vertical: 8,
                                          ),
                                          child: Container(
                                            height: 40,
                                            width: 3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(100),
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Offers'.tr(context),
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'NiseBuschGardens',
                                                fontSize: 20,
                                              ),
                                            ),
                                            const Text(
                                              '0',  //numbers of offers
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    39, 105, 171, 1),
                                                fontFamily: 'NiseBuschGardens',
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 110,
                              right: 20,
                              child: IconButton(
                                icon: Icon(
                                  AntDesign.setting,
                                  color: Colors.grey[700],
                                  size: 30,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) => const SettingsChange()));
                                },
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundImage: HomeCubit.get(context).oneUserData.userData.avatar.isNotEmpty ? NetworkImage(HomeCubit.get(context).oneUserData.userData.avatar) :
                                  const NetworkImage('https://t3.ftcdn.net/jpg/03/29/17/78/360_F_329177878_ij7ooGdwU9EKqBFtyJQvWsDmYSfI1evZ.jpg',),
                                  child: HomeCubit.get(context).oneUserData.userData.avatar.isNotEmpty ? null : Text(
                                    HomeCubit.get(context).oneUserData.userData.name[0].toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 80,
                                      color: ColorManager.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                   SizedBox(
                    height: screenHeight * 0.07,//30
                  ),
                  Container(  //container on which all previous Orders will appear
                    height: screenHeight * 0.5,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                           SizedBox(
                            height: screenHeight * 0.04, //20
                          ),
                           Text(
                            'Edit'.tr(context),
                            style: TextStyle(
                              color: ColorManager.blueGrey,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                            // TextStyle(
                            //   color: Color.fromRGBO(39, 105, 171, 1),
                            //   fontSize: 27,
                            //   fontFamily: 'NiseBuschGardens',
                            // ),
                          ),
                          const Divider(
                            thickness: 2.5,
                          ),
                           SizedBox(
                            height: screenHeight * 0.04,//10
                          ),
                          Container(
                            height: screenHeight * 0.25,
                            decoration: BoxDecoration(
                              // color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                             child: Column(
                               children: [
                                 buildMyOrder(context),
                                 const SizedBox(height: 20),
                                 buildPayment(context),
                                 const SizedBox(height: 20),
                                 HomeCubit.get(context).oneUserData.userData.role == "service_provider" ?  Container(): buildFavorite(context),
                               ],
                             ),
                          ),
                          //  SizedBox(
                          //   height: screenHeight * 0.04,//10
                          // ),
                          // Container(
                          //   height: screenHeight * 0.15,
                          //   decoration: BoxDecoration(
                          //     color: Colors.grey,
                          //     borderRadius: BorderRadius.circular(30),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  },
);
  }
}