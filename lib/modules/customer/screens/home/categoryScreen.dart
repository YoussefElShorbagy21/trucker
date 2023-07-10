import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:login/layout/homeLayout/cubit/state.dart';
import 'package:login/shared/resources/app_localizations.dart';
import '../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/input_field.dart';
import '../../../../shared/resources/color_manager.dart';

class CategoryScreens extends StatelessWidget {
  String title;

  String name;

  CategoryScreens(this.title, this.name, {super.key});

  /* List<String> brandList = [
    'Scania',
    'Iveco',
    'Man',
    'Volvo',];*/
  @override
  Widget build(BuildContext context) {
    print(HomeCubit.get(context).homeModel.equipment.length);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is HomeErrorGetFilterDataCategory) {
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
        var cubit = HomeCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              HomeCubit.get(context).homeModel.equipment.isNotEmpty,
          widgetBuilder: (context) => Scaffold(
            appBar: AppBar(title: Text(name), actions: [
               Text(
                'Filter'.tr(context),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            actions: [
                              const SizedBox(
                                height: 20,
                              ),
                              InputField(
                                title: 'Brand'.tr(context),
                                note: HomeCubit.get(context).brandControllerF,
                                widget: Row(
                                  children: [
                                    DropdownButton(
                                      dropdownColor: ColorManager.black,
                                      borderRadius: BorderRadius.circular(10),
                                      items: HomeCubit.get(context)
                                          .nameBrand
                                          .map<DropdownMenuItem<String>>(
                                            (String e) =>
                                                DropdownMenuItem<String>(
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
                                        HomeCubit.get(context)
                                            .setBrandF(value!);
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
                                height: 20,
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child:  Text('Cancel'.tr(context)),
                                  ),
                                  const Spacer(),
                                  ElevatedButton(
                                    onPressed: () {
                                      HomeCubit.get(context)
                                          .getFilterDataCategory(
                                              title,
                                              HomeCubit.get(context)
                                                  .idBrandControllerF);
                                      Navigator.pop(context);
                                    },
                                    child:  Text('Apply'.tr(context)),
                                  ),
                                ],
                              ),
                            ],
                          );
                        });
                  },
                  icon: Icon(
                    Icons.filter_list,
                    size: 25,
                    color: ColorManager.black,
                  )),
            ]),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: listBuilderOrder(
                          cubit.homeModel, context, const ScrollPhysics())),
                ],
              ),
            ),
          ),
          fallbackBuilder: (context) => Scaffold(
            appBar: AppBar(title: Text(name), actions: [
              Text(
                'Filter'.tr(context),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            actions: [
                              const SizedBox(
                                height: 20,
                              ),
                              InputField(
                                title: 'Brand'.tr(context),
                                note: HomeCubit.get(context).brandControllerF,
                                widget: Row(
                                  children: [
                                    DropdownButton(
                                      dropdownColor: ColorManager.black,
                                      borderRadius: BorderRadius.circular(10),
                                      items: HomeCubit.get(context)
                                          .nameBrand
                                          .map<DropdownMenuItem<String>>(
                                            (String e) =>
                                                DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(
                                                e,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
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
                                        HomeCubit.get(context)
                                            .setBrandF(value!);
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
                                height: 20,
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Cancel'.tr(context),
                                    ),
                                  ),
                                  const Spacer(),
                                  ElevatedButton(
                                    onPressed: () {
                                      HomeCubit.get(context)
                                          .getFilterDataCategory(
                                              title,
                                              HomeCubit.get(context)
                                                  .idBrandControllerF);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Apply'.tr(context)),
                                  ),
                                ],
                              ),
                            ],
                          );
                        });
                  },
                  icon: Icon(
                    Icons.filter_list,
                    size: 25,
                    color: ColorManager.black,
                  )),
            ]),
            body: Column(
              children: [
                cardView(context),
                cardView(context),
                cardView(context),
              ],
            ),
          ),
        );
      },
    );
  }
}
