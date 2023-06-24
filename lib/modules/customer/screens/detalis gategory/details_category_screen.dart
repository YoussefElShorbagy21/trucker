import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:login/modules/customer/screens/edit_post/editpsot.dart';
import 'package:login/modules/customer/screens/home/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/shared/resources/app_localizations.dart';
import '../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../layout/homeLayout/homelayout.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/components/input_field.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/font_manager.dart';
import '../../map/map.dart';
import '../home/cubit/state.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


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
final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class DetailsCategoryScreen extends StatelessWidget {
  String id; String cid; String scid; String bid;
  DetailsCategoryScreen({required this.id,required this.cid ,required this.scid ,required this.bid,Key? key}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeScreenCubit()..getDetailsCategoryData(id,cid,scid,bid),
      child: BlocConsumer<HomeScreenCubit, HomeScreenState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeScreenCubit.get(context).detailsEquipment;
          var userCubit = HomeScreenCubit.get(context).oneUserData;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFFf7f7f7),
              elevation: 0,
              leading: Container(
                padding: const EdgeInsets.all(8),
                child: FloatingActionButton.small(
                    backgroundColor: ColorManager.white,
                    shape: const StadiumBorder(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    elevation: 0,
                    child: Icon(
                      Icons.arrow_back_sharp,
                      size: 25,
                      color: ColorManager.black,
                    )),
              ),
              actions: [
                if (uid == cubit.userId) Container(
                      padding: const EdgeInsets.all(8),
                      child: FloatingActionButton.small(
                          backgroundColor: ColorManager.white,
                          shape: const StadiumBorder(),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => EditPost(id: id,scid: scid,cid: cid,bid: bid,)));
                          },
                          elevation: 0,
                          child: Icon(
                            Icons.edit,
                            size: 25,
                            color: ColorManager.black,
                          )),
                    ),
                if (uid == cubit.userId) Container(
                      padding: const EdgeInsets.all(8),
                      child: FloatingActionButton.small(
                          backgroundColor: ColorManager.white,
                          shape: const StadiumBorder(),
                          onPressed: () {
                            showDialog(context: context,
                                builder: (BuildContext context) {
                              return  AlertDialog(
                                content:
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      const Text.rich(
                                        TextSpan( text: 'Are you sure?? \n You want delete you post !!'),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Row(
                                        children: [
                                          ElevatedButton(onPressed: (){
                                            Navigator.pop(context);
                                          }, child: const Text('Cancel')),
                                          const Spacer(),
                                          ElevatedButton(onPressed: (){
                                            DioHelper.deleteData(url: 'truck/$id');
                                            Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeLayout()));
                                          }, child: const Text('Apply')),
                                        ],
                                      ),
                                    ],
                                  ),

                              );
                            }
                            );
                          },
                          elevation: 0,
                          child: Icon(
                            Icons.delete_outline_sharp,
                            size: 25,
                            color: ColorManager.black,
                          )),
                    ),
                Container(
                    padding: const EdgeInsets.all(8),
                    child: FloatingActionButton.small(
                        backgroundColor: ColorManager.white,
                        shape: const StadiumBorder(),
                        onPressed: () {},
                        elevation: 0,
                        child: Icon(
                          Icons.share,
                          size: 25,
                          color: ColorManager.black,
                        )),
                  ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        color: Color(0xFFf7f7f7),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(35),
                            bottomRight: Radius.circular(35))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5,0,0,0),
                          child: Text(
                            cubit.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: ColorManager.black),
                          ),
                        ),
                        Row(
                          children:  [
                          /*  RatingBar.builder(
                              initialRating: cubit.ratingCount.toDouble(),
                              minRating: 1,
                              maxRating: 5,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 11,
                              ignoreGestures: true,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ), onRatingUpdate: (double value) {  },
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(cubit.ratingCount.toDouble().toString()),*/
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '(${cubit.reviews.length.toString()} Reviews)',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                              child: Column(
                                children: [
                                  Text(
                                    "Date created: ${cubit.createdAt.toIso8601String().split('T').first.toString()}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        color: ColorManager.gery),
                                  ),
                                  Text(
                                    "Date updated: ${cubit.updatedAt.toIso8601String().split('T').first.toString()}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        color: ColorManager.gery),
                                  ),
                                ],
                              ),
                            ),
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
                                  image: NetworkImage(
                                    cubit.imageCover,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              )),
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
                              color: ColorManager.gery),
                        ),
                        ReadMoreText(
                          cubit.description,
                          trimLength: 80,
                          trimLines: 2,
                          colorClickableText: ColorManager.gery,
                          trimMode: TrimMode.Length,
                          trimCollapsedText: 'Show more !',
                          lessStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: ColorManager.black),
                          trimExpandedText: 'Show less !',
                          moreStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: ColorManager.black),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 35,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width / 8,
                                        height:
                                        MediaQuery.of(context).size.height / 16,
                                        decoration: BoxDecoration(
                                          color: ColorManager.white1,
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: const Icon(
                                          Icons.local_shipping_outlined,
                                          size: 25,
                                        ),
                                      ),
                                      Text(
                                        cubit.category == HomeScreenCubit.get(context).categoryModel.id ? HomeScreenCubit.get(context).categoryModel.name : '' ,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                               /* Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        width:
                                        MediaQuery.of(context).size.width / 8,
                                        height:
                                        MediaQuery.of(context).size.height / 16,
                                        decoration: BoxDecoration(
                                          color: ColorManager.white1,
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: const Icon(
                                          Icons.attach_money_sharp,
                                          size: 25,
                                        ),
                                      ),
                                      Text(
                                        '\$${cubit.price.toString()}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),*/
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        width:
                                        MediaQuery.of(context).size.width / 8,
                                        height:
                                        MediaQuery.of(context).size.height / 16,
                                        decoration: BoxDecoration(
                                          color: ColorManager.white1,
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: const Icon(
                                          Icons.star,
                                          size: 25,
                                        ),
                                      ),
                                      Text(
                                        '4.9',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        width:
                                        MediaQuery.of(context).size.width / 8,
                                        height:
                                        MediaQuery.of(context).size.height / 16,
                                        decoration: BoxDecoration(
                                          color: ColorManager.white1,
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: const Icon(
                                          Icons.location_on,
                                          size: 25,
                                        ),
                                      ),
                                      Text(
                                        cubit.currentLocation,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
                              color: ColorManager.black),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: userCubit.userData.avatar.isNotEmpty
                                    ? NetworkImage(userCubit.userData.avatar)
                                    : const NetworkImage(
                                        'https://t3.ftcdn.net/jpg/03/29/17/78/360_F_329177878_ij7ooGdwU9EKqBFtyJQvWsDmYSfI1evZ.jpg',
                                      ),
                                child: userCubit.userData.avatar.isNotEmpty
                                    ? null
                                    : Text(
                                        userCubit.userData.name[0].toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: ColorManager.black,
                                        ),
                                      ),
                              ),
                            ),
                            Text(
                              userCubit.userData.name,
                              style: TextStyle(
                                  fontSize: 15, color: ColorManager.black),
                            ),
                            const Spacer(),
                            Container(
                              width: MediaQuery.of(context).size.width / 7,
                              height: MediaQuery.of(context).size.height / 18,
                              decoration: BoxDecoration(
                                color: ColorManager.white1,
                                borderRadius: BorderRadius.circular(19.0),
                              ),
                              child: const Icon(
                                Icons.chat_rounded,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 120,
                        ),
                        HomeCubit.get(context).oneUserData.userData.role != "service_provider" ? Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height / 20,
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 15,
                          ),
                          child: TextButton(
                            onPressed: () {
                              showDialog(context: context,
                                  builder: (BuildContext context) {
                                    return  SingleChildScrollView(
                                      child: AlertDialog(
                                        actions: [
                                          Form(
                                            key: formKey,
                                            child: Column(
                                                children: [
                                                  InputField(
                                                    controller: HomeScreenCubit.get(context).priceControllerMap,
                                                    title: 'price',
                                                    keyboardType: TextInputType.number,
                                                    note: 'price',
                                                    onTap: () {} ,
                                                    validator: (value){
                                                      if(value!.isEmpty)
                                                      {
                                                        return 'please enter value';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  InputField(
                                                    controller: HomeScreenCubit.get(context).descriptionControllerMap,
                                                    title: 'description',
                                                    keyboardType: TextInputType.text,
                                                    note: 'description' ,
                                                    onTap: () {},
                                                    validator:(value){
                                                      if(value!.isEmpty)
                                                      {
                                                        return 'please enter value';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  InputField(
                                                    controller: HomeScreenCubit.get(context).startLocationControllerMap,
                                                    title: 'startLocation',
                                                    note: HomeScreenCubit.get(context).startLocationControllerMap.text,
                                                    onTap: () {},
                                                    validator:(value){
                                                      if(value!.isEmpty)
                                                      {
                                                        return 'please enter value';
                                                      }
                                                      return null;
                                                    },
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
                                                           HomeScreenCubit.get(context).getParsedResponseForQuery(value);
                                                           Future.delayed(const Duration(seconds: 1),(){
                                                             print('dealy');
                                                             Navigator.push(context, MaterialPageRoute(builder: (_) =>  Mapid(i: 0,)));
                                                           });
                                                          },
                                                        ),
                                                        const SizedBox(width: 6,),
                                                      ],
                                                    ),
                                                  ),
                                                  InputField(
                                                    controller: HomeScreenCubit.get(context).deliveryLocationControllerMap,
                                                    title: 'deliveryLocation',
                                                    note: HomeScreenCubit.get(context).deliveryLocationControllerMap.text,
                                                    onTap: () {},
                                                    validator:(value){
                                                      if(value!.isEmpty)
                                                      {
                                                        return 'please enter value';
                                                      }
                                                      return null;
                                                    },
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
                                                            HomeScreenCubit.get(context).getParsedResponseForQuery(value);
                                                            Future.delayed(const Duration(seconds: 1),(){
                                                              print('dealy');
                                                              Navigator.push(context, MaterialPageRoute(builder: (_) =>  Mapid(i: 1,)));
                                                            });
                                                          },
                                                        ),
                                                        const SizedBox(width: 6,),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                                                if(formKey.currentState!.validate())
                                                  {
                                                    HomeScreenCubit.get(context).bookTruck(
                                                        description: HomeScreenCubit.get(context).descriptionControllerMap.text,
                                                        price:HomeScreenCubit.get(context).priceControllerMap.text,
                                                        userId: cubit.userId,
                                                        truckId: id,
                                                        startLocation:HomeScreenCubit.get(context).startLocation,
                                                        deliveryLocation: HomeScreenCubit.get(context).deliveryLocation,
                                                    );
                                                    Navigator.pop(context);
                                                  }
                                                print(HomeScreenCubit.get(context).descriptionControllerMap.text);
                                                print(HomeScreenCubit.get(context).priceControllerMap.text);
                                                print(HomeScreenCubit.get(context).startLocation);
                                                print(HomeScreenCubit.get(context).deliveryLocation);
                                                print(uid);
                                                print(id);
                                              }, child: const Text('Apply')),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                              );
                            },
                            style: TextButton.styleFrom(
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: ColorManager.black,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                            child: Text(
                              "rent-title".tr(context),
                              style: TextStyle(
                                color: ColorManager.white,
                                fontFamily: FontConstants.fontFamily,
                                fontSize: 15,
                                fontWeight: FontWeightManager.semiBold,
                              ),
                            ),
                          ),
                        ) : Container(),
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
