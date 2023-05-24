import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:login/layout/homeLayout/cubit/cubit.dart';
import 'package:login/shared/resources/app_localizations.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/input_field.dart';
import '../../../../shared/resources/color_manager.dart';
import '../post/newPost_screen.dart';
import '../search/search_screen.dart';
import 'AllviewEquipmentsScreen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'filter_screen.dart';
import 'package:skeletons/skeletons.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  List<String> categoryList = [
    'Truck',
    'pick up',
    'Heavy Equipment',
    'Others',];
  List<String> subCategoryList = [
    'truck1',
    'truck2',
    'truck3',
    'truck4',
    'pick up1',];
  List<String> brandList = [
    'Scania',
    'Iveco',
    'Man',
    'Volvo',];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeScreenCubit()..getHomeData(),
        child: BlocConsumer<HomeScreenCubit, HomeScreenState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = HomeScreenCubit.get(context);
            return Scaffold(
              body: RefreshIndicator(
                color: ColorManager.black,
                backgroundColor: ColorManager.white1,
                onRefresh: cubit.onRefresh,
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'title_home'.tr(context),
                          style:  const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: Card(
                            color: ColorManager.white,
                            elevation: 0,
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.search,
                                    size: 25,
                                    color: ColorManager.black,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  SearchScreen()));
                                    },
                                    child: Text('search-title'.tr(context),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: ColorManager.gery,
                                        )),
                                  ),
                                  const Spacer(),
                                  IconButton(onPressed: (){
                                    showDialog(context: context,
                                        builder: (BuildContext context) {
                                      return  AlertDialog(
                                        actions: [
                                          InputField(
                                            title: 'Category',
                                            note: HomeCubit.get(context).categoryControllerF ,
                                            widget: Row(
                                              children: [
                                                DropdownButton(
                                                  dropdownColor: ColorManager.black,
                                                  borderRadius: BorderRadius.circular(10),
                                                  items: categoryList.map<DropdownMenuItem<String>>((String e) => DropdownMenuItem<String>(
                                                      value: e,
                                                      child: Text(e,style: const TextStyle(color: Colors.white,),)),).toList(),
                                                  icon: const Icon(Icons.keyboard_arrow_down_sharp,color: Colors.grey,),
                                                  iconSize: 32,
                                                  elevation: 4,
                                                  underline:  Container(height: 0,),
                                                  onChanged: (String? value)
                                                  {
                                                    HomeCubit.get(context).setCategoryF(value!);
                                                  },
                                                ),
                                                const SizedBox(width: 6,),
                                              ],
                                            ),onTap: () {},
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          InputField(
                                            title: 'SubCategory',
                                            note: HomeCubit.get(context).subCategoryControllerF ,
                                            widget: Row(
                                              children: [
                                                DropdownButton(
                                                  dropdownColor: ColorManager.black,
                                                  borderRadius: BorderRadius.circular(10),
                                                  items: subCategoryList.map<DropdownMenuItem<String>>((String e) => DropdownMenuItem<String>(
                                                      value: e,
                                                      child: Text(e,style: const TextStyle(color: Colors.white,),)),).toList(),
                                                  icon: const Icon(Icons.keyboard_arrow_down_sharp,color: Colors.grey,),
                                                  iconSize: 32,
                                                  elevation: 4,
                                                  underline:  Container(height: 0,),
                                                  onChanged: (String? value)
                                                  {
                                                    HomeCubit.get(context).setSubCategoryF(value!);
                                                  },
                                                ),
                                                const SizedBox(width: 6,),
                                              ],
                                            ),onTap: () {},
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          InputField(
                                            title: 'Brand',
                                            note: HomeCubit.get(context).brandControllerF ,
                                            widget: Row(
                                              children: [
                                                DropdownButton(
                                                  dropdownColor: ColorManager.black,
                                                  borderRadius: BorderRadius.circular(10),
                                                  items: brandList.map<DropdownMenuItem<String>>((String e) => DropdownMenuItem<String>(
                                                      value: e,
                                                      child: Text(e,style: const TextStyle(color: Colors.white,),)),).toList(),
                                                  icon: const Icon(Icons.keyboard_arrow_down_sharp,color: Colors.grey,),
                                                  iconSize: 32,
                                                  elevation: 4,
                                                  underline:  Container(height: 0,),
                                                  onChanged: (String? value)
                                                  {
                                                    HomeCubit.get(context).setBrandF(value!);
                                                  },
                                                ),
                                                const SizedBox(width: 6,),
                                              ],
                                            ),onTap: () {},
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              ElevatedButton(onPressed: (){
                                                Navigator.pop(context);
                                              }, child: const Text('Cancel')),
                                              const Spacer(),
                                              ElevatedButton(onPressed: (){
                                                HomeCubit.get(context).getFilterData(
                                                    HomeCubit.get(context).idCategoryControllerF,
                                                    HomeCubit.get(context).idSubCategoryControllerF,
                                                    HomeCubit.get(context).idBrandControllerF);
                                                Navigator.pop(context);
                                                Navigator.push(context, MaterialPageRoute(builder: (_) => const FilterEquipments()));

                                              }, child: const Text('Apply')),
                                            ],
                                          ),
                                        ],
                                      );
                                        }
                                    );
                                  },
                                      icon:   Icon(
                                    Icons.filter_list_alt,
                                    size: 25,
                                    color: ColorManager.black,
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'home-title'.tr(context),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                        const AllViewEquipments()));
                              },
                              child: Text(
                                'View All(${cubit.homeModel.equipment.length.toString()})',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>HomeScreenCubit.get(context).homeModel.equipment.isNotEmpty,
                          widgetBuilder: (context) => SizedBox(
                              height:  cubit.homeModel.equipment.length <= 5 ? MediaQuery.of(context).size.height * 1 : MediaQuery.of(context).size.height * 1.4,
                              child: listBuilderOrder(cubit.homeModel, context , const NeverScrollableScrollPhysics())),
                          fallbackBuilder: (context) =>    Column(
                            children: [
                              _cardView(context),
                              _cardView(context),
                              _cardView(context),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              floatingActionButton: HomeCubit.get(context).oneUserData.userData.role != "service_provider" ? null : FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewPostScreen()));
                },
                materialTapTargetSize: MaterialTapTargetSize.padded,
                elevation: 5,
                backgroundColor: ColorManager.white,
                child: Icon(
                  Icons.add,
                  size: 30,
                  color: ColorManager.black,
                ),
              ),
            );
          },
        ));
  }



}

Widget _cardView(context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      color: Colors.white,
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              //circle
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    shape: BoxShape.rectangle,
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.height / 5,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: SkeletonParagraph(
                  style: SkeletonParagraphStyle(
                      lines: 3,
                      spacing: 6,
                      lineStyle: SkeletonLineStyle(
                        randomLength: true,
                        height: 40,
                        borderRadius: BorderRadius.circular(8),
                        minLength: MediaQuery.of(context).size.width / 4,
                        maxLength: MediaQuery.of(context).size.width / 2,
                      )),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    ),
  );
}