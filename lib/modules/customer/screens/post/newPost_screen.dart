import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/shared/resources/app_localizations.dart';

import '../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../layout/homeLayout/cubit/state.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/components/input_field.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/select_photo_options_screen.dart';

class NewPostScreen extends StatelessWidget {
  List<String> categoryList = [
    'Truck',
    'pick up',
    'Heavy Equipment',
    'Others',
  ];

  /*List<String> brandList = [
      'Scania',
      'Iveco',
      'Man',
      'Volvo',
    ];*/
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is HomePostEquipmentErrorState) {
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
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0,
            title: Text(
              'Create Post'.tr(context),
              style: TextStyle(color: ColorManager.gery),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      HomeCubit.get(context).postNewEquipment(
                        name: HomeCubit.get(context).textController.text,
                        description:
                            HomeCubit.get(context).descriptionController.text,
                        imageCover: HomeCubit.get(context).postImage,
                        category: HomeCubit.get(context).idCategoryControllerT,
                        currentLocation:
                            HomeCubit.get(context).currentLocation.text,
                        userId: uid,
                        brand: HomeCubit.get(context).idBrandControllerT,
                      );
                      HomeCubit.get(context).delayFunction(10);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Post'.tr(context),
                    style: TextStyle(color: ColorManager.black),
                  ),
                ),
              )
            ],
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_outlined,
                color: ColorManager.black,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Container(
                          height: 200,
                          decoration: HomeCubit.get(context).postImage != null
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(
                                        HomeCubit.get(context).postImage!),
                                  ),
                                )
                              : BoxDecoration(
                                  color: const Color(0XFF408080),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                _showSelectPhotoOptions(context);
                              },
                              icon: const CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Color(0XFF408080),
                                ),
                              ),
                            ),
                            Text(
                              'Add Image'.tr(context),
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: HomeCubit.get(context).textController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter value'.tr(context);
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hoverColor: const Color(0XFF408080),
                        prefixIcon: const Icon(Icons.title),
                        counterText:
                            '${HomeCubit.get(context).textController.text.length} / 40',
                        hintText: 'title'.tr(context),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        labelText: 'Title'.tr(context),
                      ),
                    ),
                    InputField(
                      title: 'Category'.tr(context),
                      controller: HomeCubit.get(context).categoryControllerT,
                      note: HomeCubit.get(context).categoryControllerT.text,
                      validator: (value) {
                        if (value == 'Category') {
                          return 'please enter value'.tr(context);
                        }
                        return null;
                      },
                      widget: Row(
                        children: [
                          DropdownButton(
                            dropdownColor: ColorManager.black,
                            borderRadius: BorderRadius.circular(10),
                            items: categoryList
                                .map<DropdownMenuItem<String>>(
                                  (String e) => DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      )),
                                )
                                .toList(),
                            icon: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: Colors.grey,
                            ),
                            iconSize: 32,
                            elevation: 4,
                            underline: Container(
                              height: 0,
                            ),
                            onChanged: (String? value) {
                              HomeCubit.get(context).setCategory(value!);
                            },
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                    InputField(
                      title: 'Brand'.tr(context),
                      controller: HomeCubit.get(context).brandControllerT,
                      note: HomeCubit.get(context).brandControllerT.text,
                      validator: (value) {
                        if (value == 'brand') {
                          return 'please enter value'.tr(context);
                        }
                        return null;
                      },
                      widget: Row(
                        children: [
                          DropdownButton(
                            dropdownColor: ColorManager.black,
                            borderRadius: BorderRadius.circular(10),
                            items: HomeCubit.get(context)
                                .nameBrand
                                .map<DropdownMenuItem<String>>(
                                  (String e) => DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      )),
                                )
                                .toList(),
                            icon: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: Colors.grey,
                            ),
                            iconSize: 32,
                            elevation: 4,
                            underline: Container(
                              height: 0,
                            ),
                            onChanged: (String? value) {
                              HomeCubit.get(context).setBrand(value!);
                            },
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                    InputField(
                      title: 'currentLocation'.tr(context),
                      controller: HomeCubit.get(context).currentLocation,
                      note: HomeCubit.get(context).currentLocation.text,
                      validator: (value) {
                        if (value == 'currentLocation') {
                          return 'please enter value'.tr(context);
                        }
                        return null;
                      },
                      widget: Row(
                        children: [
                          DropdownButton(
                            dropdownColor: ColorManager.black,
                            borderRadius: BorderRadius.circular(10),
                            items: governmentList
                                .map<DropdownMenuItem<String>>(
                                  (String e) => DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      )),
                                )
                                .toList(),
                            icon: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: Colors.grey,
                            ),
                            iconSize: 32,
                            elevation: 4,
                            underline: Container(
                              height: 0,
                            ),
                            onChanged: (String? value) {
                              HomeCubit.get(context).setcurrentLocation(value!);
                            },
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      maxLines: 3,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter value'.tr(context);
                        }
                        return null;
                      },
                      keyboardType: TextInputType.multiline,
                      controller: HomeCubit.get(context).descriptionController,
                      decoration: InputDecoration(
                        hoverColor: const Color(0XFF408080),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 45),
                        hintStyle: const TextStyle(
                          height: 3,
                        ),
                        prefixIcon: const Icon(Icons.description),
                        hintText: 'Description'.tr(context),
                        counterText:
                            '${HomeCubit.get(context).descriptionController.text.length} / 140',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Description'.tr(context),
                      ),
                    ),
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

void _showSelectPhotoOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0),
      ),
    ),
    builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.28,
        maxChildSize: 0.4,
        minChildSize: 0.28,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: SelectPhotoOptionsScreen(
              onTap: HomeCubit.get(context).getPostImage,
            ),
          );
        }),
  );
}
