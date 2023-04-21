import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/modules/customer/screens/home/cubit/state.dart';

import '../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/select_photo_options_screen.dart';
import '../home/cubit/cubit.dart';
class EditPost extends StatelessWidget {
  String id ;
   EditPost({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => HomeScreenCubit()..getDetailsCategoryData(id),
  child: BlocConsumer<HomeScreenCubit, HomeScreenState>(
      listener: (context, state) {},
      builder: (context,state)
      {
        var cubit = HomeScreenCubit.get(context).getDetailsEquipment.equipment;
        HomeCubit.get(context).textController.text = cubit.title;
        HomeCubit.get(context).descriptionController.text = cubit.description;
        HomeCubit.get(context).priceController.text = cubit.price.toString();
        HomeCubit.get(context).categoryController.text = cubit.category;
        HomeCubit.get(context).governmentController.text = cubit.government;
        print(cubit.title);
        print(HomeCubit.get(context).textController.text);
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
                    HomeScreenCubit.get(context).updatePostData(title:  HomeCubit.get(context).textController.text,
                        description: HomeCubit.get(context).descriptionController.text,
                        photo: HomeCubit.get(context).postImage,
                        price: int.parse(HomeCubit.get(context).priceController.text),
                        category: HomeCubit.get(context).categoryController.text,
                        government: HomeCubit.get(context).governmentController.text,
                        id: id);
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
                  Row(
                    children:
                    [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(HomeCubit.get(context).userData.avatar),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: Text(
                          HomeCubit.get(context).userData.name,
                          style: const TextStyle(
                            height:1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: HomeCubit.get(context).textController,
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return 'please enter value';
                      }
                      return null;
                    },
                    decoration:  const InputDecoration(
                      hintText: 'title',
                      labelText: 'Title',
                    ),
                  ),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return 'please enter value';
                      }
                      return null;
                    },
                    controller:  HomeCubit.get(context).descriptionController,
                    decoration:  const InputDecoration(
                      hintText: 'Description',
                      labelText: 'Description',
                    ),
                  ),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return 'please enter value';
                      }
                      return null;
                    },
                    controller:  HomeCubit.get(context).priceController,
                    decoration:  const InputDecoration(
                      hintText: 'price',
                      labelText: 'price',
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DropdownMenu(
                   /*   onSelected: (selected){
                        HomeCubit.get(context).setCategory(selected!);
                      },*/
                      label: const Text('category'),
                      initialSelection: 'category',
                      leadingIcon:const Icon(Icons.category),
                      menuStyle: MenuStyle(
                        surfaceTintColor: MaterialStateProperty.all(ColorManager.black),
                        elevation: const MaterialStatePropertyAll(5),
                        maximumSize: MaterialStateProperty.all(Size.fromHeight(MediaQuery.of(context).size.height/3)),
                        backgroundColor: MaterialStatePropertyAll(ColorManager.white1),
                        shape: MaterialStateProperty.all(const BeveledRectangleBorder()),
                      ),
                      dropdownMenuEntries:const [
                        DropdownMenuEntry(value: 'Aerial Lifts', label: 'Aerial Lifts'),
                        DropdownMenuEntry(value: 'Air Compressors', label: 'Air Compressors'),
                        DropdownMenuEntry(value: 'Cabin', label: 'Cabin'),
                        DropdownMenuEntry(value: 'Cranes', label: 'Cranes'),
                        DropdownMenuEntry(value: 'Dump truck', label: 'Dump truck'),
                        DropdownMenuEntry(value: 'Earth Moving', label: 'Earth Moving'),
                        DropdownMenuEntry(value: 'Material Handling', label: 'Material Handling'),
                        DropdownMenuEntry(value: 'Motors', label: 'Motors'),
                      ]),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DropdownMenu(
                /*      onSelected: (selected){
                        HomeCubit.get(context).setGovernment(selected!);
                      },*/
                      label: const Text('government', style:  TextStyle(fontSize: 10),),
                      initialSelection: 'government',
                      leadingIcon:const Icon(Icons.podcasts_sharp),
                      menuStyle: MenuStyle(
                        surfaceTintColor: MaterialStateProperty.all(ColorManager.black),
                        elevation: const MaterialStatePropertyAll(5),
                        maximumSize: MaterialStateProperty.all(Size.fromHeight(MediaQuery.of(context).size.height/5)),
                        backgroundColor: MaterialStatePropertyAll(ColorManager.white1),
                        shape: MaterialStateProperty.all(const BeveledRectangleBorder()),
                      ),
                      dropdownMenuEntries:const [
                        DropdownMenuEntry(value: "الإسكندرية",
                          label: "الإسكندرية",),
                        DropdownMenuEntry(    value: "الإسماعيلية",
                          label: "الإسماعيلية",),
                        DropdownMenuEntry(    value: "كفر الشيخ",
                          label: "كفر الشيخ",),
                        DropdownMenuEntry(    value: "أسوان",
                          label: "أسوان",),
                        DropdownMenuEntry(    value: "أسيوط",
                          label: "أسيوط",),
                        DropdownMenuEntry(    value: "الأقصر",
                          label: "الأقصر",),
                        DropdownMenuEntry(value : "الوادي الجديد",
                          label: "الوادي الجديد",),
                        DropdownMenuEntry( value: "شمال سيناء",
                          label: "شمال سيناء",),
                        DropdownMenuEntry( value: "البحيرة",
                          label: "البحيرة",),
                        DropdownMenuEntry(value: "بني سويف",
                          label: "بني سويف",),
                        DropdownMenuEntry( value: "بورسعيد",
                          label: "بورسعيد",),
                        DropdownMenuEntry(   value: "البحر الأحمر",
                          label: "البحر الأحمر",),
                        DropdownMenuEntry(  value: "الجيزة",
                          label: "الجيزة",),
                        DropdownMenuEntry(      value: "الدقهلية",
                          label: "الدقهلية",),
                        DropdownMenuEntry( value: "جنوب سيناء",
                          label: "جنوب سيناء",),
                        DropdownMenuEntry(  value: "دمياط",
                          label: "دمياط",),
                        DropdownMenuEntry(     value: "سوهاج",
                          label: "سوهاج",),
                        DropdownMenuEntry( value: "السويس",
                          label: "السويس",),
                        DropdownMenuEntry( value: "الشرقية",
                          label: "الشرقية",),
                        DropdownMenuEntry( value: "الغربية",
                          label: "الغربية",),
                        DropdownMenuEntry(    value: "الفيوم",
                          label: "الفيوم",),
                        DropdownMenuEntry(  value: "القاهرة",
                          label: "القاهرة",),
                        DropdownMenuEntry(  value: "القليوبية",
                          label: "القليوبية",),
                        DropdownMenuEntry(    value: "قنا",
                          label: "قنا",),
                        DropdownMenuEntry(   value: "مطروح",
                          label: "مطروح",),
                        DropdownMenuEntry(     value: "المنيا",
                          label: "المنيا",),
                        DropdownMenuEntry(     value: "المنوفية",
                          label: "المنوفية",),
                      ]),

                  if(HomeCubit.get(context).postImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            image:  DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(HomeCubit.get(context).postImage!),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            HomeCubit.get(context).removePostImage() ;
                          },
                          icon: const CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.close,
                                size: 20,
                                color: Colors.blue,)),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 8,
                  ),
                  TextButton(
                    onPressed: () {
                      _showSelectPhotoOptions(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        Icon(Icons.image,color: ColorManager.gery,),
                        const SizedBox(width: 8,),
                        Text('Add photo',style: TextStyle(color: ColorManager.gery),),
                      ],
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
            child:  SelectPhotoOptionsScreen(
              onTap: HomeCubit.get(context).getPostImage,
            ),
          );
        }),
  );
}