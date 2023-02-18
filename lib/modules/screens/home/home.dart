import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/modules/screens/home/cubit/cubit.dart';
import 'package:login/modules/screens/home/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

import '../../../models/categeiromodel.dart';
import '../../../shared/resources/color_manager.dart';
import '../post/newPost_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
              onRefresh: cubit.onRefresh,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                /* Container(
                            margin: EdgeInsets.all(MediaQuery.of(context).size.height / 50),
                            color: ColorManager.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: (){
                                      cubit.isClickOrder();
                                    },
                                    style:cubit.isClickedOrder ? TextButton.styleFrom(
                                      padding: const EdgeInsets.all(10),
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                                      backgroundColor:   ColorManager.white,
                                      side: BorderSide(
                                        color: ColorManager.white2,
                                        width: 4,
                                        style: BorderStyle.solid,
                                        strokeAlign: BorderSide.strokeAlignCenter,
                                      ),
                                    ) : null ,
                                    child:  Text('Order',
                                      style: TextStyle(
                                          fontSize: cubit.isClickedOrder ? 20 : 15 ,
                                          fontWeight: FontWeight.bold,
                                          color: cubit.isClickedOrder ? ColorManager.black : ColorManager.gery),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.05,
                                ),
                                Expanded(
                                  child: TextButton(
                                    onPressed: (){
                                      cubit.isClickOffer();
                                    },
                                    style: cubit.isClickedOffer ? TextButton.styleFrom(
                                      padding: const EdgeInsets.all(10),
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                                      backgroundColor:   ColorManager.white,
                                      side: BorderSide(
                                        color: ColorManager.white2,
                                        width: 4,
                                        style: BorderStyle.solid,
                                        strokeAlign: BorderSide.strokeAlignCenter,
                                      ),
                                    ) : null ,
                                    child:  Text('Offer',
                                      style: TextStyle(
                                          fontSize: cubit.isClickedOffer ? 20 : 15,
                                          fontWeight: FontWeight.bold,
                                          color: cubit.isClickedOffer ?ColorManager.black : ColorManager.gery),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),*/ // switch order & offer
                Expanded(child: listBuilderOrder(cubit.homeModel)),
              ],
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

   Widget listBuilderOrder(GetEquipment data) => ListView.builder(
     itemBuilder: (context,index) {
       int reverse = data.equipment.length - 1 - index;
       return Padding(
       padding: const EdgeInsets.all(8.0),
       child: Card(
       color: ColorManager.white,
       elevation: 2,
       child: buildItem(context,data.equipment[reverse])
       ),
       );
     },
     itemCount: data.equipment.length,
   ) ;

   Widget buildItem(BuildContext context,Equipment equipment) =>  Padding(
     padding: const EdgeInsets.all(20.0),
     child: Row(
       children: [
         Container(
           width: MediaQuery.of(context).size.width / 3 ,
           height: MediaQuery.of(context).size.width / 3,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10.0),
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
                     maxLines: 2,
                   ),
                 ),
                 Flexible(
                   child: Text(
                     equipment.type,
                     overflow: TextOverflow.ellipsis,
                     style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 18,
                         color: ColorManager.black
                     ),
                     maxLines: 2,
                   ),
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
                         equipment.description,
                         overflow: TextOverflow.ellipsis,
                       style: TextStyle(
                         color: ColorManager.black,
                         fontSize: 15
                       ),
                       ),
                     )
                   ],
                 ),
                 const SizedBox(
                   height: 10,
                 ),
                 Row(
                   children: [
                     Expanded(
                       child: Row(
                         children: [
                           Icon(Icons.attach_money_outlined, color: ColorManager.gery,size: 20,),
                           const SizedBox(
                             width: 1,
                           ),
                           Flexible(
                             child: Text(
                             equipment.price.toString(),
                               style: TextStyle(
                                   color: ColorManager.black,
                                   fontSize: 15
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                     Expanded(
                       child: Row(
                         children: [
                           FavoriteButton(
                             iconSize: 25,
                             isFavorite: equipment.favourite ,
                             valueChanged: (isFavorite){
                               equipment.favourite = isFavorite ;
                             },
                           ),
                           const SizedBox(width: 3,),
                           Text('${equipment.rating.toString()} /5',
                             style: TextStyle(
                                 color: ColorManager.gery,
                                 fontSize: 12,
                                 fontWeight: FontWeight.bold
                             ),
                           ),
                           const SizedBox(width: 10,),
                           const Icon(
                             Icons.star,
                             size: 18,
                             color: Colors.amberAccent,
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ],
             ),
           ),
         ),
       ],
     ),
   );
}
