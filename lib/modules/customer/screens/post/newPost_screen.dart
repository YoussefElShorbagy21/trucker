import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../layout/homeLayout/cubit/state.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/resources/color_manager.dart';

class NewPostScreen extends StatelessWidget {

  final textController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  dynamic categoryController = '';
  dynamic governmentController = '';
  NewPostScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context,state)
    {
      var pImage = HomeCubit.get(context).postImage;
      var cubit = HomeCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: 0,
          title:  Text('Create Post',style: TextStyle(color: ColorManager.gery),),
          actions:
          [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: ()
                {
                  HomeCubit.get(context).postNewEquipment(
                      title: textController.text,
                      description: descriptionController.text,
                      photo: cubit.postImage,
                      price: int.parse(priceController.text),
                      category: categoryController,
                      government: governmentController,
                      userId: uid);
                      cubit.postImage = null ;
                      Navigator.pop(context);
                },
              child:  Text('Post',style: TextStyle(color: ColorManager.black),),
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
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage('https://images.ctfassets.net/hrltx12pl8hq/3j5RylRv1ZdswxcBaMi0y7/b84fa97296bd2350db6ea194c0dce7db/Music_Icon.jpg'),
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
                  controller:  textController,
                  decoration:  const InputDecoration(
                    hintText: 'title',
                    labelText: 'Title',
                  ),
                ),
                TextFormField(
                  controller:  descriptionController,
                  decoration:  const InputDecoration(
                    hintText: 'Description',
                    labelText: 'Description',
                  ),
                ),
                TextFormField(
                  controller:  priceController,
                  decoration:  const InputDecoration(
                    hintText: 'price',
                    labelText: 'price',
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                 DropdownMenu(
                     onSelected: (selected){
                       categoryController = selected ;
                       print(categoryController);
                     },
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
                     enableFilter: true,
                     enableSearch: true,
                     onSelected: (selected){
                       governmentController = selected ;
                       print(governmentController);
                     },
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
                const SizedBox(
                  height: 20.0,
                ),
                if(HomeCubit.get(context).postImage != null)
                Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 2.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image:  DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(pImage!),
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
                  HomeCubit.get(context).getPostImage() ;
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
    );
  }


}
