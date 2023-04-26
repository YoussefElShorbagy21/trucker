import 'package:flutter/material.dart';
import 'package:login/modules/custom_rating/custom_rating.dart';
import 'package:login/modules/customer/screens/home/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/shared/network/remote/dio_helper.dart';
import 'package:login/shared/resources/app_localizations.dart';

import '../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/font_manager.dart';
import '../edit_post/editpsot.dart';
import '../home/cubit/state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailsCategoryScreen extends StatelessWidget {
  String id;

  DetailsCategoryScreen(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeScreenCubit()..getDetailsCategoryData(id),
      child: BlocConsumer<HomeScreenCubit, HomeScreenState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit =
              HomeScreenCubit.get(context).getDetailsEquipment.equipment;
          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.category),
              toolbarHeight: 70,
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    FontAwesomeIcons.chevronLeft,
                    size: 30,
                    color: ColorManager.black,
                  )),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => EditPost(
                                    id: id,
                                  )));
                    },
                    icon: Icon(
                      Icons.edit,
                      size: 30,
                      color: ColorManager.black,
                    )),
                IconButton(
                    onPressed: () {
                      DioHelper.deleteData(url: 'Equipments/$id');
                      HomeScreenCubit.get(context).onRefresh();
                      Future.delayed(const Duration(seconds: 5), () {
                        Navigator.pop(context);
                      });
                    },
                    icon: Icon(
                      Icons.dangerous,
                      size: 30,
                      color: ColorManager.black,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.share,
                      size: 30,
                      color: ColorManager.black,
                    )),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cubit.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: ColorManager.black),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const CustomRating(),
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              cubit.photo,
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        )),
                    Text(
                      'Overview',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: ColorManager.black),
                    ),
                    Text(
                      cubit.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: ColorManager.gery,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 6,
                                height: MediaQuery.of(context).size.width / 6,
                                decoration: BoxDecoration(
                                  color: ColorManager.kGray,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: const Icon(
                                  Icons.category,
                                  size: 35,
                                ),
                              ),
                              Text(
                                cubit.category,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.black,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 6,
                                height: MediaQuery.of(context).size.width / 6,
                                decoration: BoxDecoration(
                                  color: ColorManager.kGray,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: const Icon(
                                  Icons.star,
                                  size: 35,
                                ),
                              ),
                              Text(
                                '4.5',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.black,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 6,
                                height: MediaQuery.of(context).size.width / 6,
                                decoration: BoxDecoration(
                                  color: ColorManager.kGray,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: const Icon(
                                  Icons.monetization_on,
                                  size: 35,
                                ),
                              ),
                              Text(
                                '9000',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.black,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 6,
                                height: MediaQuery.of(context).size.width / 6,
                                decoration: BoxDecoration(
                                  color: ColorManager.kGray,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: const Icon(
                                  Icons.location_pin,
                                  size: 35,
                                ),
                              ),
                              Text(
                                cubit.government,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.black,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Renter',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: ColorManager.black),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                                HomeCubit.get(context).userData.avatar),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            HomeCubit.get(context).userData.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              // color: ColorManager.gery
                            ),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 10,
                            height: MediaQuery.of(context).size.width / 10,
                            decoration: BoxDecoration(
                              color: ColorManager.kGray,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Icon(
                              Icons.message,
                              size: 20,
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width / 18,
                        // ),
                        // Expanded(
                        //   child: Container(
                        //     width: MediaQuery.of(context).size.width / 10,
                        //     height: MediaQuery.of(context).size.width / 10,
                        //     decoration: BoxDecoration(
                        //       // color: ColorManager.gery,
                        //       borderRadius: BorderRadius.circular(10.0),
                        //     ),
                        //     child: const Icon(Icons.call,size: 20,),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              width: MediaQuery.of(context).size.width / 5,
              height: MediaQuery.of(context).size.width / 5,
              decoration: BoxDecoration(
                // color: ColorManager.gery,
                borderRadius: BorderRadius.circular(35.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Expanded(
                  child: Container(
                    width: 180,
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 50,
                    ),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        backgroundColor: ColorManager.black,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: Text(
                        'rent-title'.tr(context),
                        style: TextStyle(
                          color: ColorManager.white,
                          fontFamily: FontConstants.fontFamily,
                          fontSize: FontSize.s22,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
