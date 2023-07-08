import 'package:flutter/material.dart';

import '../../../../shared/components/input_field.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../map/map.dart';
import '../home/cubit/cubit.dart';
import '../home/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  List<String> paymentList = [
    'cash',
    'card'
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenState>(
  listener: (context, state) {
    if(state is ErrorBookTruckState)
    {
      final snackBar = SnackBar(
        margin: const EdgeInsets.all(50),
        duration: const Duration(seconds: 5),
        shape: const StadiumBorder(),
        elevation: 5,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        content: Text(state.error.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else if (state is SuccessBookTruckState)
      {
        print('asdsda');
        if(state.value['ticket']['paymentType'] == 'card'){
          print('card');
          HomeScreenCubit.get(context).getPaymentType(ticket:state.value['ticket']['_id'] );
        }
        else{
          print('cash');
          Navigator.pop(context);
        }
      }
    else if(state is SuccessGetPaymentTypeState )
      {
          WebViewController controller = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(Uri.parse(state.url));
          Navigator.push(context, MaterialPageRoute(builder: (_) => WebViewWidget(controller: controller,

          )));
      }
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                'You must add details for booking?',
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
                        title: 'paymentType',
                        controller: HomeScreenCubit.get(context).paymentType,
                        note: HomeScreenCubit.get(context).paymentType.text ,
                        validator: (value){
                          if(value == 'Category')
                          {
                            return 'please enter value';
                          }
                          return null;
                        },
                        widget: Row(
                          children: [
                            DropdownButton(
                              dropdownColor: ColorManager.black,
                              borderRadius: BorderRadius.circular(10),
                              items: paymentList.map<DropdownMenuItem<String>>((String e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e,style: const TextStyle(color: Colors.white,),)),).toList(),
                              icon: const Icon(Icons.keyboard_arrow_down_sharp,color: Colors.grey,),
                              iconSize: 32,
                              elevation: 4,
                              underline:  Container(height: 0,),
                              onChanged: (String? value)
                              {
                                HomeScreenCubit.get(context).setPayment(value!);
                              },
                            ),
                            const SizedBox(width: 6,),
                          ],
                        ),onTap: () {},
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
                                paymentType:   HomeScreenCubit
                                    .get(
                                    context)
                                    .paymentType.text,
                              );
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
      ),
    );
  },
);
  }
}
