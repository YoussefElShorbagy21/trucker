import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:login/modules/customer/screens/home/categoryScreen.dart';
import 'package:login/shared/resources/app_localizations.dart';
import 'package:favorite_button/favorite_button.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/font_manager.dart';
import '../../../../models/categeiromodel.dart';
import '../detalis gategory/details_category_screen.dart';
import '../post/newPost_screen.dart';
import '../search/search_screen.dart';
import 'AllviewEquipmentsScreen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
  List<String> title = [
    "Aerial Lifts",
    "Air Compressors",
    "Cabin",
    "Cranes",
    "Dump truck",
    "Earth Moving",
    "Material Handling",
    "Motors"
  ];

   List<String> image = [
     "https://e7.pngegg.com/pngimages/746/473/png-clipart-aerial-work-platform-genie-elevator-architectural-engineering-business-business-blue-angle.png",
     "https://www.pngfind.com/pngs/m/428-4280926_photo-compressor-png-air-compressor-png-transparent-png.png",
     "https://www.clipartmax.com/png/middle/172-1723861_cabin-insurance-wooden-house-transparent-background.png",
     "https://www.pngkey.com/png/full/72-726232_crawler-crane.png",
     "https://p7.hiclipart.com/preview/923/331/796/dump-truck.jpg",
     "https://www.pngkit.com/png/detail/150-1505520_bulldozer1-earth-moving-equipment.png",
     "https://p7.hiclipart.com/preview/544/342/492/forklift-linde-material-handling-clip-art-forklift-truck.jpg",
     "https://www.seekpng.com/png/detail/256-2566528_electric-motor-png-transparent-image-electric-motor-no.png"
   ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
    create: (context) => HomeScreenCubit()..getHomeData(),
    child : BlocConsumer<HomeScreenCubit,HomeScreenState>(
      listener: (context,state) {},
      builder: (context,state) {
        var cubit = HomeScreenCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => HomeScreenCubit.get(context).homeModel.equipment.isNotEmpty ,
          widgetBuilder: (context) => Scaffold(
            body: RefreshIndicator(
              color: ColorManager.black,
              backgroundColor: ColorManager.white1,
              onRefresh: cubit.onRefresh,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('title_home'.tr(context),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Montserrat',
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
                              Icon(Icons.search,
                                size: 25,
                                color: ColorManager.black,),
                              TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (_) => SearchScreen()));
                              },
                                child: Text('search-title'.tr(context),
                            style: TextStyle(
                              fontSize: 12,
                              color: ColorManager.gery,
                            )),),
                              const Spacer(),
                              Icon(Icons.filter_list_alt,
                                size: 25,
                                color: ColorManager.black,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Text('trend-title'.tr(context),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),),
                    listBuilderCategory(context),
                    Row(
                      children: [
                        Text('home-title'.tr(context),
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),),
                        const Spacer(),
                        TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const AllViewEquipments()));
                            },
                            child: Text('view_all(${cubit.homeModel.results.toString()})',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),),),
                      ],
                    ),
                    listBuilderOrder(cubit.homeModel, context),
                  ],
          ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewPostScreen()));
              },
              materialTapTargetSize: MaterialTapTargetSize.padded,
              elevation: 5,
              backgroundColor: ColorManager.white,
              child:  Icon(Icons.add,size: 30,color: ColorManager.black,),
            ),
          ),
          fallbackBuilder: (context) => const Center(child: CircularProgressIndicator()) ,
        );
      },
    )
    );
  }

   Widget listBuilderOrder(GetEquipment data , BuildContext context) => SizedBox(
     width: double.infinity,
     height: MediaQuery.of(context).size.height / 2,
     child: ListView.builder(
       itemBuilder: (context,index) {
         int reverse = data.equipment.length - 1 - index;
         return GestureDetector(
           onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsCategoryScreen(data.equipment[reverse].id)));
           },
           child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Card(
           color: ColorManager.white,
           elevation: 2,
           child: buildItem(context,data.equipment[reverse])
           ),
           ),
         );
       },
       itemCount: data.equipment.length,
     ),
   ) ;

   Widget buildItem(BuildContext context,Equipment equipment) =>  Padding(
     padding: const EdgeInsets.all(20.0),
     child: Row(
       children: [
         Container(
           width: MediaQuery.of(context).size.width / 3 ,
           height: MediaQuery.of(context).size.height/ 5,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(15.0),
             image:  DecorationImage(
               image: NetworkImage(equipment.photo.toString()),
               fit: BoxFit.cover,
             ),

           ),

         ),
         const SizedBox(
           width: 10,
         ),
         Expanded(
           child: SizedBox(
             height: 130,
             width: double.infinity,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
               mainAxisSize: MainAxisSize.min,
               children: [
                 Flexible(
                   child: Text(
                     equipment.title,
                     overflow: TextOverflow.ellipsis,
                     style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 25,
                         color: ColorManager.black
                     ),
                     maxLines: 1,
                   ),
                 ),
                 Row(
                   children: [
                     Expanded(
                       child: Row(
                         children: [
                           Icon(Icons.attach_money_outlined, color: ColorManager.gery,size: 25,),
                           Flexible(
                             child: Text(
                               equipment.price.toString(),
                               style: TextStyle(
                                   color: ColorManager.black,
                                   fontSize: 18
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),

                   ],
                 ),
                 const SizedBox(
                   height: 5,
                 ),
                 Row(
                   children: [
                     Icon(Icons.location_on_outlined, color: ColorManager.gery,size: 25,),
                     const SizedBox(
                       width: 5,
                     ),
                     Flexible(
                       child: Text(
                         equipment.government,
                         overflow: TextOverflow.ellipsis,
                       style: TextStyle(
                         color: ColorManager.black,
                         fontSize: 20
                       ),
                       ),
                     )
                   ],
                 ),
                 const SizedBox(
                   height: 5,
                 ),
                 Expanded(
                   child: Row(
                     children: [
                       Container(
                         width: 120,
                         padding: EdgeInsets.symmetric(
                             horizontal: MediaQuery.of(context).size.width/35,
                             ),
                         child: TextButton(
                               onPressed:(){} ,
                               style: TextButton.styleFrom(
                                   shape: BeveledRectangleBorder(
                                     borderRadius: BorderRadius.circular(10),
                                   ),
                                   backgroundColor: ColorManager.black,
                                   padding: const EdgeInsets.symmetric(vertical: 4),
                                 ),
                               child:  Text("rent-title".tr(context),
                                   style: TextStyle(
                                     color: ColorManager.white,
                                     fontFamily: FontConstants.fontFamily,
                                     fontSize: 15,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                             ),
                      ),
                       const SizedBox(width: 3,),
                       FavoriteButton(
                         iconSize: 30,
                         isFavorite: true,
                         valueChanged: (isFavorite){
                         },
                       ),
                     ],
                   ),
                 ),
               ],
             ),
           ),
         ),
       ],
     ),
   );

   Widget listBuilderCategory(BuildContext context) => SizedBox(
     height: MediaQuery.of(context).size.height / 5,
     width: double.infinity,
     child: ListView.builder(
       scrollDirection: Axis.horizontal,
      itemBuilder: (context,index) {
        return GestureDetector(
          onTap: (){
            print(title[index]);
            Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryScreen(title[index])));
          },
            child: buildCategory(context,title[index],image[index]));
      },
      itemCount: 8,
  ),
   ) ;

   Widget buildCategory(BuildContext context,String text,String img) =>  Padding(
     padding: const EdgeInsets.all(8.0),
     child: Column(
       children:  [
         Container(
           width: MediaQuery.of(context).size.width / 4,
           height: MediaQuery.of(context).size.width / 4,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(15.0),
             image:   DecorationImage(
               image: NetworkImage(img),
               fit: BoxFit.cover,
             ),
           ),

         ),
         Text(text,style: TextStyle(
           fontWeight: FontWeight.bold,
           color: ColorManager.gery,
           fontSize: 15,
         ),),
       ],

     ),
   );
}
