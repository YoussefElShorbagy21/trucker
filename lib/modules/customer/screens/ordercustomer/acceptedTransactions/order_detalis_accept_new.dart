import 'package:flutter/material.dart';
import 'package:login/modules/customer/screens/ordercustomer/cubit/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../../shared/resources/color_manager.dart';
import '../../../../../shared/resources/font_manager.dart';
import '../cubit/order_cubit.dart';
import 'mapTracking.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

class OrderDetailsAcceptNew extends StatelessWidget {
  String price;

  String description;

  String id;
  String serviceId;
  double sourceLatLo;
  double sourceLatLa;
  double destinationLo;
  double destinationLa;

  OrderDetailsAcceptNew({
    super.key,
    required this.price,
    required this.description,
    required this.id,
    required this.sourceLatLa,
    required this.sourceLatLo,
    required this.destinationLa,
    required this.destinationLo,
    required this.serviceId,
  });

  @override
  Widget build(BuildContext context) {
    String verify = ' ';
    return BlocConsumer<OrderCubit, OrderStates>(
      listener: (context, state) {
        if (state is ErrorConfirmProcess) {
          final snackBar = SnackBar(
            margin: const EdgeInsets.all(50),
            duration: const Duration(seconds: 5),
            shape: const StadiumBorder(),
            elevation: 5,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text(
              state.error.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: const Color(0xFF22A699),
                      width: double.infinity,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                                boxShadow: [
                                  BoxShadow(color: Colors.grey, blurRadius: 8)
                                ]),
                            child: const Icon(
                              Icons.no_crash_outlined,
                              color: Color(0xFF22A699),
                              size: 40,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Accepted order',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 150,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.emoji_objects_outlined,
                                  size: 25,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'hint',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'your order has been accepted by the delivery person. Please wait for the delivery of your order and enter the OTP code',
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(.5),
                                  fontSize: 15,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 350),
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.description_outlined,
                                  size: 25,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'description',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9.0,
                              ),
                              child: Text(
                                description,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.withOpacity(0.8),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height / 30
                            ),
                            const Text(
                              'Booking Details',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Text(
                                    'EGP',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  price.toString(),
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                             SizedBox(
                                height: MediaQuery.of(context).size.height / 30
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.add_location_outlined,
                                  size: 25,
                                  color: Colors.grey,
                                ),
                                Expanded(
                                  child: Text(
                                    OrderCubit.get(context)
                                        .startLocationCurrent,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height / 30
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.share_location,
                                  size: 25,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    OrderCubit.get(context)
                                        .deliveryLocationCurrent,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    HomeCubit.get(context).oneUserData.userData.role ==
                        "service_provider"
                        ? Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height / 15,
                      padding: EdgeInsets.symmetric(
                        horizontal:
                        MediaQuery.of(context).size.width / 15,
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MapTracking(
                                serviceId: serviceId,
                                id: id,
                                sourceLatLa: sourceLatLa,
                                sourceLatLo: sourceLatLo,
                                destinationLa: destinationLa,
                                destinationLo: destinationLo,
                              ),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: const Color(0xFF22A699),
                          padding:
                          const EdgeInsets.symmetric(vertical: 10),
                        ),
                        child: Text(
                          'Follow You Map',
                          style: TextStyle(
                            color: ColorManager.white,
                            fontFamily: FontConstants.fontFamily,
                            fontSize: 18,
                            fontWeight: FontWeightManager.semiBold,
                          ),
                        ),
                      ),
                    )
                        : Container(),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    HomeCubit.get(context).oneUserData.userData.role !=
                            "service_provider"
                        ? Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height / 15,
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 15,
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MapTracking(
                                      serviceId: serviceId,
                                      id: id,
                                      sourceLatLa: sourceLatLa,
                                      sourceLatLo: sourceLatLo,
                                      destinationLa: destinationLa,
                                      destinationLo: destinationLo,
                                    ),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: const Color(0xFF22A699),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                              ),
                              child: Text(
                                'Follow Your Product',
                                style: TextStyle(
                                  color: ColorManager.white,
                                  fontFamily: FontConstants.fontFamily,
                                  fontSize: 18,
                                  fontWeight: FontWeightManager.semiBold,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    //مربع لادخال الكود
                    HomeCubit.get(context).oneUserData.userData.role ==
                            "service_provider"
                        ? Column(
                            children: [
                              OtpTextField(
                                  numberOfFields: 6,
                                  borderColor: ColorManager.white,
                                  focusedBorderColor: ColorManager.black,
                                  showFieldAsBox: true,
                                  clearText: OrderCubit.get(context).clearText,
                                  keyboardType: TextInputType.text,
                                  onSubmit: (String verificationCode) {
                                    verify = verificationCode;
                                    print(id);
                                    print(verificationCode);
                                  }),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 30,
                              ),
                              Conditional.single(
                                  context: context,
                                  conditionBuilder: (BuildContext context) =>
                                      state is! LoadingConfirmProcess,
                                  widgetBuilder: (context) {
                                    return Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width /
                                                35,
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          OrderCubit.get(context)
                                              .confirmProcess(verify, id);
                                        },
                                        style: TextButton.styleFrom(
                                          shape: const StadiumBorder(),
                                          backgroundColor: ColorManager.black,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14),
                                        ),
                                        child: Text(
                                          "ارسال الكود",
                                          style: TextStyle(
                                            color: ColorManager.white,
                                            fontFamily:
                                                FontConstants.fontFamily,
                                            fontSize: FontSize.s22,
                                            fontWeight:
                                                FontWeightManager.semiBold,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  fallbackBuilder: (context) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 30,
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
