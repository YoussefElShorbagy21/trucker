import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:login/modules/customer/screens/edit_post/editpsot.dart';
import 'package:login/modules/customer/screens/home/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/shared/resources/app_localizations.dart';
import '../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/font_manager.dart';
import '../home/cubit/state.dart';
import 'package:readmore/readmore.dart';

class DetailsCategoryScreen extends StatelessWidget {
  String id ;
  DetailsCategoryScreen(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => HomeScreenCubit()..getDetailsCategoryData(id),
  child: BlocConsumer<HomeScreenCubit, HomeScreenState>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = HomeScreenCubit.get(context).getDetailsEquipment.equipment ;
    var userCubit = HomeScreenCubit.get(context).userData ;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFf7f7f7),
        elevation: 0,
        leading: Container(
          padding: const EdgeInsets.all(8),
          child: FloatingActionButton.small(
            backgroundColor: ColorManager.white,
            shape: const StadiumBorder(),
              onPressed: (){
              Navigator.pop(context);
              },
              elevation: 0,
            child:  Icon(Icons.arrow_back_sharp,size: 25,color: ColorManager.black,)),
        )
        ,
        actions:  [
          if(uid == cubit.userId)
              Container(
            padding: const EdgeInsets.all(8),
            child: FloatingActionButton.small(
                backgroundColor: ColorManager.white,
                shape: const StadiumBorder(),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => EditPost(id: id)));
                },
                elevation: 0,
                child:  Icon(Icons.edit,size: 25,color: ColorManager.black,)),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: FloatingActionButton.small(
                backgroundColor: ColorManager.white,
                shape: const StadiumBorder(),
                onPressed: (){},
                elevation: 0,
                child:  Icon(Icons.share,size: 25,color: ColorManager.black,)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                  color: Color(0xFFf7f7f7),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35),bottomRight: Radius.circular(35))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cubit.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: ColorManager.black
                    ),
                  ),
                  Row(
                    children: const [
                      Icon(Icons.star,size: 25,color: Colors.amberAccent,),
                      Text('4.9'),
                      SizedBox(width: 5,),
                      Text('(110 Reviews)',style: TextStyle(color: Colors.grey),),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(cubit.photo,),
                          fit: BoxFit.cover,),
                        borderRadius: BorderRadius.circular(20)
                        ,)
                      ),
                  ),
                   SizedBox(
                    height: MediaQuery.of(context).size.height / 18,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overview :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: ColorManager.gery
                    ),
                  ),
                  ReadMoreText(
                    cubit.description,
                    trimLength: 80,
                    trimLines: 2,
                    colorClickableText:ColorManager.gery,
                    trimMode: TrimMode.Length,
                    trimCollapsedText: 'Show more !',
                    lessStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: ColorManager.black
                    ),
                    trimExpandedText: 'Show less !',
                    moreStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: ColorManager.black
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 35,
                  ),
                  Row(
                    children: [
                      Column(
                        children:  [
                          Container(
                            width: MediaQuery.of(context).size.width / 8,
                            height: MediaQuery.of(context).size.height / 16,
                            decoration: BoxDecoration(
                              color: ColorManager.white1,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Icon(Icons.local_shipping_outlined,size: 25,),
                          ),
                          Text(cubit.category,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            color: ColorManager.black,
                            fontSize: 12,
                          ),),
                        ],

                      ),
                      Expanded(
                        child: Column(
                          children:  [
                            Container(
                              width: MediaQuery.of(context).size.width / 8,
                              height: MediaQuery.of(context).size.height / 16,
                              decoration: BoxDecoration(
                                color: ColorManager.white1,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Icon(Icons.attach_money_sharp,size: 25,),
                            ),
                            Text('\$${cubit.price.toString()}',
                              style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorManager.black,
                              fontSize: 12,
                            ),),
                          ],

                        ),
                      ),
                      Expanded(
                        child: Column(
                          children:  [
                            Container(
                              width: MediaQuery.of(context).size.width / 8,
                              height: MediaQuery.of(context).size.height / 16,
                              decoration: BoxDecoration(
                                color: ColorManager.white1,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Icon(Icons.star,size: 25,),
                            ),
                            Text('4.9',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorManager.black,
                              fontSize: 12,
                            ),),
                          ],

                        ),
                      ),
                      Expanded(
                        child: Column(
                          children:  [
                            Container(
                              width: MediaQuery.of(context).size.width / 8,
                              height: MediaQuery.of(context).size.height / 16,
                              decoration: BoxDecoration(
                                color: ColorManager.white1,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Icon(Icons.location_on,size: 25,),
                            ),
                            Text(cubit.government,style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorManager.black,
                              fontSize: 12,
                            ),),
                          ],

                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                  ),
                  Text(
                    '  Renter',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: ColorManager.black
                    ),
                  ),
                  Row(
                    children: [
                       Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: userCubit.avatar.isNotEmpty ? NetworkImage(userCubit.avatar) :
                          const NetworkImage('https://t3.ftcdn.net/jpg/03/29/17/78/360_F_329177878_ij7ooGdwU9EKqBFtyJQvWsDmYSfI1evZ.jpg',),
                          child: userCubit.avatar.isNotEmpty ? null : Text(
                            userCubit.name[0].toUpperCase(),
                            style: TextStyle(
                              fontSize: 30,
                              color: ColorManager.black,
                            ),
                          ),
                        ),
                      ),
                      Text(
                       userCubit.name,
                        style: TextStyle(
                            fontSize: 15,
                            color: ColorManager.black
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: MediaQuery.of(context).size.width / 7,
                        height: MediaQuery.of(context).size.height / 18,
                        decoration: BoxDecoration(
                          color: ColorManager.white1,
                          borderRadius: BorderRadius.circular(19.0),
                        ),
                        child: const Icon(Icons.chat_rounded,size: 20,),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 120,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width  * 1,
                    height: MediaQuery.of(context).size.height / 20,
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width/15,
                    ),
                    child: TextButton(
                      onPressed:(){},
                      style: TextButton.styleFrom(
                        shape:   BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: ColorManager.black,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      child:  Text("rent-title".tr(context),
                        style: TextStyle(
                          color: ColorManager.white,
                          fontFamily: FontConstants.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 150,
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  },
),
);
  }
}

