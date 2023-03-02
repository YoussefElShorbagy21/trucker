import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../chats_screen/chat_home.dart';
import 'setting_widget/setting_page.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(4, 9, 35, 1),
                Color(0xff191919),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 73),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => const ChatHome()));
                        },
                        icon: const Icon(
                          AntDesign.arrowleft,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          AntDesign.logout,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                   SizedBox(
                    height: screenHeight * 0.028,    //20
                  ),
                  const Text(
                    'My\nProfile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      // fontFamily: '',
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Container(
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
                                      height: localHeight * 0.33, // 80
                                    ),
                                    const Text(
                                      'Master Joe', //name of user
                                      style: TextStyle(
                                        color: Color.fromRGBO(39, 105, 171, 1),
                                        // fontFamily: '',
                                        fontSize: 37,
                                      ),
                                    ),
                                     SizedBox(
                                      height: localHeight * 0.02, //5
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Orders',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                // fontFamily: '',
                                                fontSize: 25,
                                              ),
                                            ),
                                            const Text(
                                              '10', //numbers of orders
                                              style: TextStyle(
                                                color:
                                                Color.fromRGBO(39, 105, 171, 1),
                                                // fontFamily: '',
                                                fontSize: 25,
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
                                            height: 50,
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
                                              'Offer',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                // fontFamily: '',
                                                fontSize: 25,
                                              ),
                                            ),
                                            const Text(
                                              '0',  //numbers of offers
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    39, 105, 171, 1),
                                                // fontFamily: '',
                                                fontSize: 25,
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
                                child: Container(
                                  child: const CircleAvatar(
                                    radius:80,
                                    backgroundImage: AssetImage('assets/images/chat_photo/greg.jpg'),
                                    // child: Image.asset(
                                    //   'assets/images/chat_photo/greg.jpg',
                                    //   width: localWidth * 0.45,
                                    //   fit: BoxFit.fitWidth,
                                    // ),
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
                          const Text(
                            'My Orders',
                            style: TextStyle(
                              color: Color.fromRGBO(39, 105, 171, 1),
                              fontSize: 27,
                              // fontFamily: '',
                            ),
                          ),
                          const Divider(
                            thickness: 2.5,
                          ),
                           SizedBox(
                            height: screenHeight * 0.04,//10
                          ),
                          Container(
                            height: screenHeight * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                           SizedBox(
                            height: screenHeight * 0.04,//10
                          ),
                          Container(
                            height: screenHeight * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
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
  }
}