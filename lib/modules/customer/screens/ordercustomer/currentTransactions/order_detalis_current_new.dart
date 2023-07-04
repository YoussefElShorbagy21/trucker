import 'package:flutter/material.dart';
import 'package:login/modules/customer/screens/ordercustomer/cubit/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../../shared/resources/color_manager.dart';
import '../../../../../shared/resources/font_manager.dart';
import '../cubit/order_cubit.dart';

class OrderDetailsCurrentNew extends StatelessWidget {
  String price;

  String description;

  String id;

  OrderDetailsCurrentNew({
    super.key,
    required this.price,
    required this.description,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderStates>(
      listener: (context, state) {
        if (state is ErrorConfirmTicketOrderState) {
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
              child: Column(
                children: [
                  Container(
                    color: const Color(0xFFffd494),
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
                            ],
                          ),
                          child: const Icon(
                            Icons.hourglass_empty_outlined,
                            color: Color(0xFFffd494),
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Waiting for accept',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 150),
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 6,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.emoji_objects_outlined,
                                size: 25,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 10,
                              ),
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
                                const EdgeInsets.symmetric(horizontal: 9.0),
                            child: Text(
                              'Your order is currently being processed and we are working to assign a delivery person. Please keep an eye out for a notification with an estimated delivery time.',
                              style: TextStyle(
                                color: Colors.grey.withOpacity(.5),
                                fontSize: 14.5,
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
                    height: MediaQuery.of(context).size.height / 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    Icons.description_outlined,
                                    size: 25,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  description,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.withOpacity(0.8),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
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
                              const SizedBox(height: 30),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.add_location_outlined,
                                    size: 25,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    OrderCubit.get(context)
                                        .startLocationCurrent,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.share_location,
                                    size: 25,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    OrderCubit.get(context)
                                        .deliveryLocationCurrent,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  HomeCubit.get(context).oneUserData.userData.role !=
                          "service_provider"
                      ? const Text(
                          'Waiting',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.green,
                              fontWeight: FontWeightManager.bold,
                              fontFamily: 'NiseBuschGardens'),
                        )
                      : Container(),
                  HomeCubit.get(context).oneUserData.userData.role ==
                          "service_provider"
                      ? RichText(
                          text: TextSpan(
                            text: 'Please respond to this request :',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: ColorManager.black),
                          ),
                          textAlign: TextAlign.center,
                        )
                      : Container(),
                  const SizedBox(
                    height: 40,
                  ),
                  HomeCubit.get(context).oneUserData.userData.role ==
                          "service_provider"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  OrderCubit.get(context)
                                      .confirmTicket(id, false);
                                },
                                style: TextButton.styleFrom(
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  backgroundColor: Colors.red,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                ),
                                child: Text(
                                  'reject',
                                  style: TextStyle(
                                    color: ColorManager.white,
                                    fontFamily: FontConstants.fontFamily,
                                    fontSize: 15,
                                    fontWeight: FontWeightManager.semiBold,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  OrderCubit.get(context)
                                      .confirmTicket(id, true);
                                },
                                style: TextButton.styleFrom(
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  backgroundColor: Colors.green,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                ),
                                child: Text(
                                  'Acceptance',
                                  style: TextStyle(
                                    color: ColorManager.white,
                                    fontFamily: FontConstants.fontFamily,
                                    fontSize: 15,
                                    fontWeight: FontWeightManager.semiBold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
