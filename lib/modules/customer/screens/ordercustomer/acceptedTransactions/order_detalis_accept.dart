import 'package:flutter/material.dart';
import 'package:login/modules/customer/screens/ordercustomer/cubit/order_cubit.dart';
import 'package:login/modules/customer/screens/ordercustomer/cubit/order_state.dart';

import '../../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../../shared/resources/color_manager.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/resources/font_manager.dart';
import 'mapTracking.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

class OrderDetailsAccept extends StatelessWidget {
  String price ;
  String description ;
  String id ;
  double sourceLatLo;
  double sourceLatLa;
  double destinationLo;
  double destinationLa;
  OrderDetailsAccept({super.key,required this.price,required this.description,required this.id
  ,required this.sourceLatLa,required this.sourceLatLo,required this.destinationLa,required this.destinationLo,
  });

  @override
  Widget build(BuildContext context) {
    String verify = ' ' ;
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<OrderCubit, OrderStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = OrderCubit.get(context).detailsEquipmentAcceptedTransactions;
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
                                      OrderCubit.get(context).startLocationAccepted,
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
                                      OrderCubit.get(context).deliveryLocationAccepted,
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
                const Text('Accepted',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.green,
                  fontWeight: FontWeightManager.bold,
                  fontFamily: 'NiseBuschGardens'
                ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                HomeCubit.get(context).oneUserData.userData.role != "service_provider" ? Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height / 15,
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 15,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) =>  MapTracking(
                        sourceLatLa: sourceLatLa,
                        sourceLatLo: sourceLatLo,
                        destinationLa: destinationLa,
                        destinationLo: destinationLo,
                      )));
                    },
                    style: TextButton.styleFrom(
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: Text(
                      'Follow Your Product',
                      style: TextStyle(
                        color: ColorManager.white,
                        fontFamily: FontConstants.fontFamily,
                        fontSize: 20,
                        fontWeight: FontWeightManager.semiBold,
                      ),
                    ),
                  ),
                ) : Container(),
                //مربع لادخال الكود
                HomeCubit.get(context).oneUserData.userData.role == "service_provider" ?Column(
                  children: [
                    OtpTextField(
                        numberOfFields: 6,
                        borderColor: ColorManager.white,
                        focusedBorderColor: ColorManager.black,
                        showFieldAsBox: true,
                        clearText: OrderCubit.get(context).clearText,
                        keyboardType: TextInputType.text,
                        onSubmit: (String verificationCode){
                          verify = verificationCode ;
                          print(id);
                          print(verificationCode);
                        }
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    Conditional.single(
                        context: context ,
                        conditionBuilder: (BuildContext  context) => state is! LoadingConfirmProcess,
                        widgetBuilder: (context){
                          return Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width/35,
                            ),
                            child: TextButton(
                              onPressed:(){
                               OrderCubit.get(context).confirmProcess(verify, id);
                              } ,
                              style: TextButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor: ColorManager.black,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              child:  Text("ارسال الكود",
                                style: TextStyle(
                                  color: ColorManager.white,
                                  fontFamily: FontConstants.fontFamily,
                                  fontSize: FontSize.s22,
                                  fontWeight: FontWeightManager.semiBold,
                                ),
                              ),
                            ),
                          );
                        },
                        fallbackBuilder: (context) {
                          return const Center(child: CircularProgressIndicator()) ;
                        }
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
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
