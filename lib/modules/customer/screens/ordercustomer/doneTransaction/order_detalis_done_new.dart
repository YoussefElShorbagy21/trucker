import 'package:flutter/material.dart';
import 'package:login/modules/customer/screens/ordercustomer/cubit/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/shared/network/remote/dio_helper.dart';
import '../../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../../shared/resources/color_manager.dart';
import '../../../../../shared/resources/font_manager.dart';
import '../cubit/order_cubit.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OrderDetailsDoneNew extends StatelessWidget {
  String price;

  String description;

  String id;

  String service_providerId;

  OrderDetailsDoneNew(
      {super.key,
      required this.price,
      required this.description,
      required this.id,
      required this.service_providerId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderStates>(
      listener: (context, state) {
        if (state is ErrorCreateReview) {
          final snackBar = SnackBar(
            margin: const EdgeInsets.all(50),
            duration: const Duration(seconds: 2),
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Container(
                      color: ColorManager.kGold,
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
                                BoxShadow(color: Colors.grey, blurRadius: 8),
                              ],
                            ),
                            child: Icon(
                              Icons.verified_outlined,
                              color: ColorManager.kGold,
                              size: 40,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Transportation success',
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
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                'Thank you for confirming the delivery process. We hope you received your order in a timely and satisfactory manner. Please take a moment to rate your experience with the delivery process.',
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(.5),
                                  fontSize: 13.5,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 350,
                    ),
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
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
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
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  'Booking Details',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
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
                                            color: Colors.grey),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      price.toString(),
                                      style: const TextStyle(
                                          fontSize: 15,
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
                                      Icons.add_location_outlined,
                                      size: 25,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      OrderCubit.get(context).startLocationDone,
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
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      OrderCubit.get(context)
                                          .deliveryLocationDone,
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
                    SizedBox(height: 70,),
                    HomeCubit.get(context).oneUserData.userData.role ==
                            "service_provider"
                        ? const Text(
                            'Done Transaction',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.green,
                                fontWeight: FontWeightManager.bold,
                                fontFamily: 'NiseBuschGardens'),
                          )
                        : Container(),
                    HomeCubit.get(context).oneUserData.userData.role !=
                            "service_provider"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    _showBottomSheet(
                                        context, id, service_providerId);
                                  },
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    backgroundColor: ColorManager.kGold,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                  ),
                                  child: Text(
                                    'Review',
                                    style: TextStyle(
                                      color: ColorManager.white,
                                      fontFamily: FontConstants.fontFamily,
                                      fontSize: 20,
                                      fontWeight: FontWeightManager.bold,
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
          ),
        );
      },
    );
  }
}

TextEditingController controller = TextEditingController();

double onRatingUpdate = 0;

_showBottomSheet(BuildContext context, String id, String service_providerId) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    builder: (context) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.4,
      maxChildSize: 0.9,
      minChildSize: 0.32,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -15,
              child: Container(
                width: 60,
                height: 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Rating the mission',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controller,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter value';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hoverColor: const Color(0XFF408080),
                        prefixIcon: const Icon(Icons.rate_review_outlined),
                        hintText: 'Title',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        labelText: 'Review',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const Text(
                    'Review & Rating the mission',
                    style: TextStyle(
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RatingBar.builder(
                    initialRating: 1,
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemSize: 30,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 5),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    onRatingUpdate: (index) {
                      onRatingUpdate = index;
                      print(onRatingUpdate);
                      print(controller.text);
                      OrderCubit.get(context).createReview(
                        service_providerId: service_providerId,
                        truck: id,
                        title: controller.text,
                        ratingAverage: onRatingUpdate,
                      );
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
