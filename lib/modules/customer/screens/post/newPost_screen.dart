import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';


  import '../../../../layout/homeLayout/cubit/cubit.dart';
  import '../../../../layout/homeLayout/cubit/state.dart';
  import '../../../../shared/components/constants.dart';
import '../../../../shared/components/input_field.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/select_photo_options_screen.dart';

  class NewPostScreen extends StatelessWidget {
    List<String> categoryList = [
      'Aerial Lifts',
      'Air Compressors',
      'Cabin','Cranes','Dump truck',
      'Earth Moving','Material Handling','Motors'];
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

    NewPostScreen({super.key});
    @override
    Widget build(BuildContext context) {
      return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context,state)
      {
        print(HomeCubit.get(context).textController.text);
        print(HomeCubit.get(context).descriptionController.text);
        print(HomeCubit.get(context).priceController.text);
        print(HomeCubit.get(context).governmentControllerT);
        print(HomeCubit.get(context).categoryControllerT);
        print(HomeCubit.get(context).postImage);
        print(uid);
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
                  onPressed: () {
                      HomeCubit.get(context).postNewEquipment(
                          title: HomeCubit.get(context).textController.text,
                          description: HomeCubit.get(context).descriptionController.text,
                          photo: HomeCubit.get(context).postImage,
                          price: int.parse(HomeCubit.get(context).priceController.text),
                          category: HomeCubit.get(context).categoryControllerT,
                          government: HomeCubit.get(context).governmentControllerT,
                          userId: uid);
                      HomeCubit.get(context).delayFunction(5);
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
                  Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Container(
                        height: 200,
                        decoration: HomeCubit.get(context).postImage != null ?  BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image:  DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(HomeCubit.get(context).postImage!),
                          ),
                        ) :
                        BoxDecoration(
                          color: const Color(0XFF408080),
                          borderRadius: BorderRadius.circular(15.0),
                        ) ,
                      ),
                      Row(
                        children: [
                          IconButton(onPressed: (){
                            _showSelectPhotoOptions(context);
                          }
                              , icon:
                            const CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.add,
                                size: 30,
                                color: Color(0XFF408080),),),),
                          const Text('Add Image',style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ],
                  ),
                 /* Row(
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
                  ),*/
                  const SizedBox(height: 20.0,),
                  TextFormField(
                    controller: HomeCubit.get(context).textController,
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
                      counterText: '${HomeCubit.get(context).textController.text.length} / 40',
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
                    controller: HomeCubit.get(context).priceController,
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
                    note: HomeCubit.get(context).categoryControllerT ,
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
                            HomeCubit.get(context).setCategory(value!);
                          },
                        ),
                        const SizedBox(width: 6,),
                      ],
                    ),onTap: () {},
                  ),
                  InputField(
                    title: 'Government',
                    note: HomeCubit.get(context).governmentControllerT ,
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
                            HomeCubit.get(context).setGovernment(value!);
                          },
                        ),
                        const SizedBox(width: 6,),
                      ],
                    ),onTap: () {},
                  ),
               /*     const SizedBox(
                    height: 20.0,
                  ),
                   DropdownMenu(
                     controller: HomeCubit.get(context).categoryController,
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
                       ]),*/
                  const SizedBox(
                    height: 30.0,
                  ),
                /*       DropdownMenu(
                     controller: HomeCubit.get(context).governmentController,
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
                       ]),*/
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
                    controller:  HomeCubit.get(context).descriptionController,
                    decoration:   InputDecoration(
                      hoverColor: const Color(0XFF408080),
                      contentPadding: const EdgeInsets.symmetric(vertical: 45),
                      hintStyle: const TextStyle(
                        height: 3,
                      ),
                      prefixIcon: const Icon(Icons.description),
                      hintText: 'Description',
                      counterText: '${HomeCubit.get(context).descriptionController.text.length} / 140',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Description',
                    ),
                  ),
                 /*             if(HomeCubit.get(context).postImage != null)
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
                  ),*/

                ],
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
              child:  SelectPhotoOptionsScreen(
                onTap: HomeCubit.get(context).getPostImage,
              ),
            );
          }),
    );
  }