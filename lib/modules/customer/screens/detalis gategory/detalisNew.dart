import 'package:flutter/material.dart';
import 'package:login/shared/resources/app_localizations.dart';
import 'package:readmore/readmore.dart';

import '../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../layout/homeLayout/homelayout.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/font_manager.dart';
import '../booked/booking.dart';
import '../edit_post/editpsot.dart';
import '../home/cubit/cubit.dart';
import '../home/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailScreen extends StatefulWidget {

  String id;
  String cid;
  String scid;
  String bid;
  DetailScreen({super.key, required this.id, required this.cid, required this.scid, required this.bid});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => HomeScreenCubit()..getDetailsCategoryData(widget.id, widget.cid,widget.scid, widget.bid),
  child: BlocConsumer<HomeScreenCubit, HomeScreenState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var cubit = HomeScreenCubit.get(context).detailsEquipment;
    var userCubit = HomeScreenCubit.get(context).oneUserData;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.5 + 16,
                        bottom: 20,
                        right: 32,
                        left: 32),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(60),
                          bottomRight: Radius.circular(60),
                        ),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cubit.name,
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Row(
                                children: [
                                  const Icon(
                                    Icons.car_crash_sharp,
                                    size: 22,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    cubit.category ==
                                        HomeScreenCubit.get(context)
                                            .categoryModel
                                            .id
                                        ? HomeScreenCubit.get(context)
                                        .categoryModel
                                        .name
                                        : '',
                                  ),
                                ],
                              ),
                               Row(
                                children: [
                                  const Icon(
                                    Icons.alarm,
                                    size: 22,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                   cubit.createdAt.toIso8601String().split('T').first.toString(),

                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 22,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    cubit.currentLocation,
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  Hero(
                    tag: 'tag',
                    child: SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(60),
                          bottomLeft: Radius.circular(60),
                        ),
                        child: Image.network(
                          cubit.imageCover,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  if (uid == cubit.userId)
                      Positioned(
                      top: 40,
                      right: 80,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 8)
                            ]),
                        child: IconButton(
                          icon:  Icon(
                            Icons.edit,
                            color: ColorManager.cGold,
                            size: 20,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => EditPost(
                                      id: widget.id,
                                      scid: widget.scid,
                                      cid: widget.cid,
                                      bid: widget.bid,
                                    )));
                          },
                        ),
                      ),
                    ),

                  if (uid == cubit.userId)
                      Positioned(
                    top: 40,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 8)
                          ]),
                      child: IconButton(
                        icon:  Icon(
                          Icons.delete_outline_sharp,
                          color:ColorManager.cGold,
                          size: 20,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      const Text.rich(
                                        TextSpan(
                                            text:
                                            'Are you sure?? \n You want delete you post !!'),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cancel')),
                                          const Spacer(),
                                          ElevatedButton(
                                              onPressed: () {
                                                DioHelper.deleteData(
                                                    url: 'truck/$widget.id');
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                        const HomeLayout()));
                                              },
                                              child: const Text('Apply')),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                  ),


                  Positioned(
                    top: 40,
                    left: 24,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 8)
                          ]),
                      child: IconButton(
                        icon:  Icon(
                          Icons.arrow_back_ios,
                          color: ColorManager.cGold,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),

                  Positioned(
                    right: 34,
                    bottom: 80,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 8)
                          ]),
                      child: const Icon(
                        Icons.fire_truck_sharp  ,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),

              ///Spacing
              const SizedBox(
                height: 24,
              ),

              ///About text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  "About",
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              ///About detail text
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child:  ReadMoreText(
                  cubit.description,
                  trimLength: 80,
                  trimLines: 2,
                  colorClickableText: ColorManager.gery,
                  trimMode: TrimMode.Length,
                  trimCollapsedText: 'Show more !',
                  lessStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: ColorManager.black),
                  trimExpandedText: 'Show less !',
                  moreStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: ColorManager.black),
                ),
              ),

              const SizedBox(
                height: 40,
              ),
              Text(
                '  Renter',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: ColorManager.black),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: userCubit
                          .userData.avatar.isNotEmpty
                          ? NetworkImage(userCubit.userData.avatar)
                          : const NetworkImage(
                        'https://t3.ftcdn.net/jpg/03/29/17/78/360_F_329177878_ij7ooGdwU9EKqBFtyJQvWsDmYSfI1evZ.jpg',
                      ),
                      child: userCubit.userData.avatar.isNotEmpty
                          ? null
                          : Text(
                        userCubit.userData.name[0]
                            .toUpperCase(),
                        style: TextStyle(
                          fontSize: 30,
                          color: ColorManager.black,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    userCubit.userData.name,
                    style: TextStyle(
                        fontSize: 15, color: ColorManager.black),
                  ),
                  const Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width / 7,
                    height: MediaQuery.of(context).size.height / 18,
                    decoration: BoxDecoration(
                      color: ColorManager.white1,
                      borderRadius: BorderRadius.circular(19.0),
                    ),
                    child: const Icon(
                      Icons.chat_rounded,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 120,
              ),
              HomeCubit.get(context).oneUserData.userData.role !=
                  "service_provider"
                  ? Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height / 20,
                padding: EdgeInsets.symmetric(
                  horizontal:
                  MediaQuery.of(context).size.width / 15,
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BookingScreen(
                      id: widget.id,
                      userId: cubit.userId,
                    )));
                  },
                  style: TextButton.styleFrom(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: ColorManager.black,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10),
                  ),
                  child: Text(
                    "rent-title".tr(context),
                    style: TextStyle(
                      color: ColorManager.white,
                      fontFamily: FontConstants.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeightManager.semiBold,
                    ),
                  ),
                ),
              )
                  : Container(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 150,
              ),
            ],
          ),
        ),
      ),
    );
  },
),
);
  }
}