import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/modules/customer/screens/home/cubit/state.dart';

import '../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/components/input_field.dart';
import '../../../../shared/resources/color_manager.dart';
import '../detalis gategory/changephoto.dart';
import '../home/cubit/cubit.dart';


class EditPost extends StatelessWidget {
  String id ; String cid; String scid; String bid;
   EditPost({required this.id,required this.cid ,required this.scid ,required this.bid, Key? key}) : super(key: key);
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
  /*List<String> brandList = [
    'Scania',
    'Iveco',
    'Man',
    'Volvo',];*/
  List<String> governmentList = [
    "الإسكندرية","الإسماعيلية",
    "كفر الشيخ","أسوان",
    "أسيوط", "الأقصر",
    "الوادي الجديد","شمال سيناء",
    "البحيرة","بني سويف","بورسعيد","البحر الأحمر",
    "الجيزة","الدقهلية","جنوب سيناء","دمياط",
    "سوهاج","السويس","الشرقية","الغربية",
    "الفيوم","القاهرة","القليوبية",
    "قنا","مطروح","المنوفية","المنيا"
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => HomeScreenCubit()..getDetailsCategoryData(id,cid,scid,bid)
    ..idCategory(cid)..idSubCategory(scid)..idBrand(bid),
  child: BlocConsumer<HomeScreenCubit, HomeScreenState>(
      listener: (context, state) {
        if(state is ErrorUpdatePostState)
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
      },
      builder: (context,state)
      {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0,
            title:  Text('Update Post',style: TextStyle(color: ColorManager.gery),),
            actions:
            [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  onPressed: () {
                    HomeScreenCubit.get(context).updatePostData(
                        name:  HomeScreenCubit.get(context).editTextController.text,
                        description:  HomeScreenCubit.get(context).editDescriptionController.text,
                        price: int.parse(HomeScreenCubit.get(context).editPriceController.text),
                        id: id,
                        priceAfterDiscount: 400,
                        category: HomeScreenCubit.get(context).editIdCategoryControllerT,
                        subcategory: HomeScreenCubit.get(context).editIdSubCategoryControllerT,
                        brand: HomeScreenCubit.get(context).editIdBrandControllerT,
                        locationFrom: HomeScreenCubit.get(context).editLocationFromControllerT,
                        locationTo: HomeScreenCubit.get(context).editLocationToControllerT,
                        userId: uid,);
                    Navigator.pop(context);
                  },
                  child:  Text('Update',style: TextStyle(color: ColorManager.black),),
                ),
              )
            ],
            leading: IconButton(
              onPressed: ()
              {
                Navigator.pop(context);
              },
              icon:  Icon(
                Icons.arrow_back_outlined,
                color: ColorManager.black,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                children:
                [
                  Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image:  DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(HomeScreenCubit.get(context).detailsEquipment.imageCover),
                          ),
                        )
                      ),
                      Row(
                        children: [
                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_) =>  ChangePhoto(id: id,)));
                          }
                            , icon:
                            const CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.change_circle_outlined,
                                size: 30,
                                color: Color(0XFF408080),),),),
                          const Text('Change Image',style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0,),
                  TextFormField(
                    controller: HomeScreenCubit.get(context).editTextController,
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return 'please enter value';
                      }
                      return null;
                    },
                    decoration:   InputDecoration(
                      hoverColor: const Color(0XFF408080),
                      prefixIcon: const Icon(Icons.title),
                      counterText: '${HomeScreenCubit.get(context).editTextController.text.length} / 40',
                      hintText: 'title',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      labelText: 'Title',
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: HomeScreenCubit.get(context).editPriceController,
                    keyboardType: TextInputType.number,
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return 'please enter value';
                      }
                      return null;
                    },
                    decoration:   InputDecoration(
                      hoverColor: const Color(0XFF408080),
                      prefixIcon: const Icon(Icons.price_change),
                      hintText: 'Price',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      labelText: 'Price',
                    ),
                  ),
                  InputField(
                    title: 'Category',
                    note: HomeScreenCubit.get(context).editCategoryControllerT ,
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
                            HomeScreenCubit.get(context).updateCategory(value!);
                          },
                        ),
                        const SizedBox(width: 6,),
                      ],
                    ),onTap: () {},
                  ),
                  InputField(
                    title: 'SubCategory',
                    note: HomeScreenCubit.get(context).editSubCategoryControllerT ,
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
                            HomeScreenCubit.get(context).updateSubCategory(value!);
                          },
                        ),
                        const SizedBox(width: 6,),
                      ],
                    ),onTap: () {},
                  ),
                  InputField(
                    title: 'Brand',
                    note: HomeScreenCubit.get(context).editBrandControllerT ,
                    widget: Row(
                      children: [
                        DropdownButton(
                          dropdownColor: ColorManager.black,
                          borderRadius: BorderRadius.circular(10),
                          items: HomeCubit.get(context).nameBrand
                              .map<DropdownMenuItem<String>>((String e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e,style: const TextStyle(color: Colors.white,),)),).toList(),
                          icon: const Icon(Icons.keyboard_arrow_down_sharp,color: Colors.grey,),
                          iconSize: 32,
                          elevation: 4,
                          underline:  Container(height: 0,),
                          onChanged: (String? value)
                          {
                            HomeScreenCubit.get(context).updateBrand(value!);
                          },
                        ),
                        const SizedBox(width: 6,),
                      ],
                    ),onTap: () {},
                  ),
                  InputField(
                    title: 'locationFrom',
                    note: HomeScreenCubit.get(context).editLocationFromControllerT ,
                    widget: Row(
                      children: [
                        DropdownButton(
                          dropdownColor: ColorManager.black,
                          borderRadius: BorderRadius.circular(10),
                          items: governmentList.map<DropdownMenuItem<String>>((String e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e,style: const TextStyle(color: Colors.white,),)),).toList(),
                          icon: const Icon(Icons.keyboard_arrow_down_sharp,color: Colors.grey,),
                          iconSize: 32,
                          elevation: 4,
                          underline:  Container(height: 0,),
                          onChanged: (String? value)
                          {
                            HomeScreenCubit.get(context).updateLocationFrom(value!);
                          },
                        ),
                        const SizedBox(width: 6,),
                      ],
                    ),onTap: () {},
                  ),
                  InputField(
                    title: 'locationTo',
                    note: HomeScreenCubit.get(context).editLocationToControllerT ,
                    widget: Row(
                      children: [
                        DropdownButton(
                          dropdownColor: ColorManager.black,
                          borderRadius: BorderRadius.circular(10),
                          items: governmentList.map<DropdownMenuItem<String>>((String e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e,style: const TextStyle(color: Colors.white,),)),).toList(),
                          icon: const Icon(Icons.keyboard_arrow_down_sharp,color: Colors.grey,),
                          iconSize: 32,
                          elevation: 4,
                          underline:  Container(height: 0,),
                          onChanged: (String? value)
                          {
                            HomeScreenCubit.get(context).updateLocationTo(value!);
                          },
                        ),
                        const SizedBox(width: 6,),
                      ],
                    ),onTap: () {},
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    maxLines: 3,
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return 'please enter value';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.multiline,
                    controller:  HomeScreenCubit.get(context).editDescriptionController,
                    decoration:   InputDecoration(
                      hoverColor: const Color(0XFF408080),
                      contentPadding: const EdgeInsets.symmetric(vertical: 45),
                      hintStyle: const TextStyle(
                        height: 3,
                      ),
                      prefixIcon: const Icon(Icons.description),
                      hintText: 'Description',
                      counterText: '${HomeScreenCubit.get(context).editDescriptionController.text.length} / 140',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Description',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
);
  }
}

