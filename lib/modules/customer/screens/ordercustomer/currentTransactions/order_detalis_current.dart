import 'package:flutter/material.dart';
import 'package:login/modules/customer/screens/ordercustomer/cubit/order_cubit.dart';
import 'package:login/modules/customer/screens/ordercustomer/cubit/order_state.dart';

import '../../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../../shared/resources/color_manager.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/resources/font_manager.dart';
class OrderDetailsCurrent extends StatelessWidget {
  String price ;
  String description ;
  String id ;
  OrderDetailsCurrent({super.key,required this.price,required this.description,required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<OrderCubit, OrderStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = OrderCubit.get(context).detailsEquipmentCurrentTransactions;
        return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: Color(0xFFf7f7f7),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Overview :',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: ColorManager.gery),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5,0,0,0),
                        child: Text(
                          cubit.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: ColorManager.black),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                 cubit.imageCover,
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 18,
                      ),
                      Text(
                        'Overview :',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: ColorManager.gery),
                      ),
                      ReadMoreText(
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
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'تفاصيل الطلب:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: ColorManager.gery),
                      ),
                      Text(
                        'description :',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: ColorManager.gery),
                      ),
                      ReadMoreText(
                        description,
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 35,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width / 8,
                                      height:
                                      MediaQuery.of(context).size.height / 16,
                                      decoration: BoxDecoration(
                                        color: ColorManager.white1,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: const Icon(
                                        Icons.price_change,
                                        size: 25,
                                      ),
                                    ),
                                    Text(
                                     price,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ColorManager.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      width:
                                      MediaQuery.of(context).size.width / 8,
                                      height:
                                      MediaQuery.of(context).size.height / 16,
                                      decoration: BoxDecoration(
                                        color: ColorManager.white1,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: const Icon(
                                        Icons.location_city,
                                        size: 25,
                                      ),
                                    ),
                                    Text(
                                      OrderCubit.get(context).startLocationCurrent,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ColorManager.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      width:
                                      MediaQuery.of(context).size.width / 8,
                                      height:
                                      MediaQuery.of(context).size.height / 16,
                                      decoration: BoxDecoration(
                                        color: ColorManager.white1,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: const Icon(
                                        Icons.location_on,
                                        size: 25,
                                      ),
                                    ),
                                    Text(
                                      OrderCubit.get(context).deliveryLocationCurrent,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ColorManager.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50,
                      ),
                    ],
                  ),
                ),
                HomeCubit.get(context).oneUserData.userData.role != "service_provider" ? const Text('Waiting',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.green,
                      fontWeight: FontWeightManager.bold,
                      fontFamily: 'NiseBuschGardens'
                  ),
                ) : Container(),
                HomeCubit.get(context).oneUserData.userData.role == "service_provider" ? RichText(
                  text: TextSpan(
                  text: 'الرجاء الرد علي هذا الطلب :',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: ColorManager.black),
                ),
                  textAlign: TextAlign.center,
                ) : Container(),
                HomeCubit.get(context).oneUserData.userData.role == "service_provider" ? Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height / 20,
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 15,
                      ),
                      child: TextButton(
                        onPressed: () {
                          OrderCubit.get(context).confirmTicket(
                              id,
                              true);
                        },
                        style: TextButton.styleFrom(
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        child: Text(
                          'قبول',
                          style: TextStyle(
                            color: ColorManager.white,
                            fontFamily: FontConstants.fontFamily,
                            fontSize: 15,
                            fontWeight: FontWeightManager.semiBold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height / 20,
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 15,
                      ),
                      child: TextButton(
                        onPressed: () {
                          OrderCubit.get(context).confirmTicket(
                              id,
                              false);
                        },
                        style: TextButton.styleFrom(
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        child: Text(
                          'رفض',
                          style: TextStyle(
                            color: ColorManager.white,
                            fontFamily: FontConstants.fontFamily,
                            fontSize: 15,
                            fontWeight: FontWeightManager.semiBold,
                          ),
                        ),
                      ),
                    )
                  ],
                ) : Container(),
              ],
            ),
          );
      },
),
    );
  }
}
