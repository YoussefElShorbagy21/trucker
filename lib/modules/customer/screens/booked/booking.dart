import 'package:flutter/material.dart';

import '../../../../shared/components/input_field.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../map/map.dart';
import '../home/cubit/cubit.dart';

class BookingScreen extends StatelessWidget {
  String id ;
  String userId ;
   BookingScreen({Key? key, required this.id , required this.userId}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<String> governmentList = [
    "الإسكندرية",
    "الإسماعيلية",
    "كفر الشيخ",
    "أسوان",
    "أسيوط",
    "الأقصر",
    "الوادي الجديد",
    "شمال سيناء",
    "البحيرة",
    "بني سويف",
    "بورسعيد",
    "البحر الأحمر",
    "الجيزة",
    "الدقهلية",
    "جنوب سيناء",
    "دمياط",
    "سوهاج",
    "السويس",
    "الشرقية",
    "الغربية",
    "الفيوم",
    "القاهرة",
    "القليوبية",
    "قنا",
    "مطروح",
    "المنوفية",
    "المنيا"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'You Must add details for booking?',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key:formKey ,
                child: Column(
                  children: [
                    InputField(
                      controller: HomeScreenCubit
                          .get(context)
                          .startLocationControllerMap,
                      title: 'startLocation',
                      note: HomeScreenCubit
                          .get(context)
                          .startLocationControllerMap
                          .text,
                      onTap: () {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter value';
                        }
                        return null;
                      },
                      widget: Row(
                        children: [
                          DropdownButton(
                            dropdownColor:
                            ColorManager
                                .black,
                            borderRadius:
                            BorderRadius
                                .circular(
                                10),
                            items:
                            governmentList
                                .map<
                                DropdownMenuItem<
                                    String>>(
                                  (String e) => DropdownMenuItem<
                                  String>(
                                  value:
                                  e,
                                  child:
                                  Text(
                                    e,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  )),
                            )
                                .toList(),
                            icon: const Icon(
                              Icons
                                  .keyboard_arrow_down_sharp,
                              color:
                              Colors.grey,
                            ),
                            iconSize: 32,
                            elevation: 4,
                            underline:
                            Container(
                              height: 0,
                            ),
                            onChanged:
                                (String?
                            value) {
                              HomeScreenCubit.get(
                                  context)
                                  .getParsedResponseForQuery(
                                  value);
                              Future.delayed(
                                  const Duration(
                                      seconds:
                                      1),
                                      () {
                                    print(
                                        'dealy');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => Mapid(
                                              i: 0,
                                            )));
                                  });
                            },
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                        ],
                      ),
                    ),
                    InputField(
                      controller: HomeScreenCubit
                          .get(context)
                          .deliveryLocationControllerMap,
                      title:
                      'deliveryLocation',
                      note: HomeScreenCubit
                          .get(context)
                          .deliveryLocationControllerMap
                          .text,
                      onTap: () {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter value';
                        }
                        return null;
                      },
                      widget: Row(
                        children: [
                          DropdownButton(
                            dropdownColor:
                            ColorManager
                                .black,
                            borderRadius:
                            BorderRadius
                                .circular(
                                10),
                            items:
                            governmentList
                                .map<
                                DropdownMenuItem<
                                    String>>(
                                  (String e) => DropdownMenuItem<
                                  String>(
                                  value:
                                  e,
                                  child:
                                  Text(
                                    e,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  )),
                            )
                                .toList(),
                            icon: const Icon(
                              Icons
                                  .keyboard_arrow_down_sharp,
                              color:
                              Colors.grey,
                            ),
                            iconSize: 32,
                            elevation: 4,
                            underline:
                            Container(
                              height: 0,
                            ),
                            onChanged:
                                (String?
                            value) {
                              HomeScreenCubit.get(
                                  context)
                                  .getParsedResponseForQuery(
                                  value);
                              Future.delayed(
                                  const Duration(
                                      seconds:
                                      1),
                                      () {
                                    print(
                                        'dealy');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => Mapid(
                                              i: 1,
                                            )));
                                  });
                            },
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                        ],
                      ),
                    ),
                    InputField(
                      controller: HomeScreenCubit
                          .get(context)
                          .descriptionControllerMap,
                      title: '',
                      keyboardType:
                      TextInputType.text,
                      note: 'description',
                      onTap: () {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter value';
                        }
                        return null;
                      },
                    ),
                    InputField(
                      controller: HomeScreenCubit
                          .get(context)
                          .priceControllerMap,
                      title: '',
                      keyboardType:
                      TextInputType
                          .number,
                      note: 'price',
                      onTap: () {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter value';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey
                              .currentState!
                              .validate()) {
                            HomeScreenCubit.get(
                                context)
                                .bookTruck(
                              description:
                              HomeScreenCubit
                                  .get(
                                  context)
                                  .descriptionControllerMap
                                  .text,
                              price: HomeScreenCubit
                                  .get(
                                  context)
                                  .priceControllerMap
                                  .text,
                              userId: userId,
                              truckId: id,
                              startLocation:
                              HomeScreenCubit
                                  .get(
                                  context)
                                  .startLocation,
                              deliveryLocation:
                              HomeScreenCubit
                                  .get(
                                  context)
                                  .deliveryLocation,
                            );
                            Navigator.pop(
                                context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(), backgroundColor: Colors.black,
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
