import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:login/modules/customer/screens/edit_post/editpsot.dart';
import 'package:login/modules/customer/screens/home/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/shared/resources/app_localizations.dart';
import '../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../layout/homeLayout/homelayout.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/font_manager.dart';
import '../home/cubit/state.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
                            RatingBar.builder(
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
                            Text(cubit.ratingCount.toDouble().toString()),
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
                                        fontSize: 15,
                                        color: ColorManager.gery),
                                  ),
                                  Text(
                                    "Date updated: ${cubit.updatedAt.toIso8601String().split('T').first.toString()}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
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
                                          Icons.subway,
                                          size: 25,
                                        ),
                                      ),
                                      Text(
                                        cubit.subcategory == HomeScreenCubit.get(context).subCategory.id ? HomeScreenCubit.get(context).subCategory.name : '' ,
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
                                          Icons.brightness_auto_rounded,
                                          size: 25,
                                        ),
                                      ),
                                      Text(
                                        cubit.brand == HomeScreenCubit.get(context).brand.id ? HomeScreenCubit.get(context).brand.name : '' ,
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
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
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
                                        cubit.locationFrom,
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
                                          Icons.edit_location_sharp,
                                          size: 25,
                                        ),
                                      ),
                                      Text(
                                        cubit.locationTo,
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
                            onPressed: () {},
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
