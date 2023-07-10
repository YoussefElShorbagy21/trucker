import 'package:flutter/material.dart';
import 'package:login/layout/homeLayout/cubit/state.dart';
import '../../layout/homeLayout/cubit/cubit.dart';
import '../../models/categeiromodel.dart';
import 'package:skeletons/skeletons.dart';
import '../../modules/customer/screens/detalis gategory/detalisNew.dart';
import '../resources/color_manager.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void navigatefisnh(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);

Widget listBuilderOrder(
        GetEquipment data, BuildContext context, ScrollPhysics physics) =>
    SizedBox(
      height: data.equipment.length <= 5
          ? MediaQuery.of(context).size.height * 1
          : MediaQuery.of(context).size.height * 1.6,
      child: ListView.builder(
        physics: physics,
        itemBuilder: (context, index) {
          int reverse = data.equipment.length - 1 - index;
          return buildNewItem(context, data.equipment[reverse]);
        },
        itemCount: data.equipment.length,
      ),
    );

Widget buildItem(BuildContext context, Equipment equipment) =>
    BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailScreen(
                id: equipment.id,
                cid: equipment.category,
                bid: equipment.brand,
              ),
            ));
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Hero(
                  tag: 'tag',
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.height / 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                        image: NetworkImage(equipment.imageCover.toString()),
                        fit: BoxFit.cover,
                      ),
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
                            equipment.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: ColorManager.black),
                            maxLines: 1,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: ColorManager.gery,
                              size: 25,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: Text(
                                equipment.currentLocation,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: ColorManager.black, fontSize: 20),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.attach_money_outlined,
                                    color: ColorManager.gery,
                                    size: 25,
                                  ),
                                  // Flexible(
                                  //   child: Text(
                                  //     equipment.price.toString(),
                                  //     style: TextStyle(
                                  //         color: ColorManager.black, fontSize: 18),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        HomeCubit.get(context).oneUserData.userData.role !=
                                "service_provider"
                            ? Expanded(
                                child: Row(
                                  children: [
                                    /*Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      padding: EdgeInsets.symmetric(
                        horizontal:
                        MediaQuery.of(context).size.width / 35,
                      ),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: ColorManager.black,
                          padding:
                          const EdgeInsets.symmetric(vertical: 4),
                        ),
                        child: Text(
                          "rent-title".tr(context),
                          style: TextStyle(
                            color: ColorManager.white,
                            fontFamily: FontConstants.fontFamily,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),*/
                                    /*   Row(
                      children: [
                        Text('${equipment.ratingCount.toDouble().toString()} / 5'
                          ,style: const TextStyle(
                            fontSize: 15,
                          ),),
                        const SizedBox(
                          width: 5,
                        ),
                        RatingBar.builder(
                          initialRating: equipment.ratingCount.toDouble(),
                          minRating: 1,
                          maxRating: 5,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 10,
                          ignoreGestures: true,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ), onRatingUpdate: (double value) {  },
                        ),

                      ],
                    ),*/
                                    const Spacer(),
                                    FavoriteButton(
                                      iconSize: 30,
                                      isFavorite: HomeCubit.get(context)
                                                  .favorites[equipment.id] ==
                                              'find'
                                          ? true
                                          : false,
                                      valueChanged: (isFavorite) {
                                        if (isFavorite == true) {
                                          HomeCubit.get(context)
                                              .addFavorite(truck: equipment.id);
                                          HomeCubit.get(context).delayTime(5);
                                          HomeCubit.get(context)
                                              .favorites[equipment.id] = 'find';
                                        } else {
                                          HomeCubit.get(context).deleteFavorite(
                                              truck: equipment.id);
                                          HomeCubit.get(context).delayTime(5);
                                          HomeCubit.get(context)
                                              .favorites[equipment.id] = '';
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

Widget cardView(context) {
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

Widget builderArticleItem(articles, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage('${articles['imageCover']}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${articles['name']}',
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${articles['description']}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

Widget articleBuilder(list, int len, context, {isSearch = false}) =>
    list.length > 0
        ? ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                builderArticleItem(list[index], context),
            separatorBuilder: (context, index) => Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
            itemCount: len,
          )
        : isSearch
            ? Container()
            : const Center(child: CircularProgressIndicator());

Widget buildNewItem(BuildContext context, Equipment equipment) =>
    GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailScreen(
            id: equipment.id,
            cid: equipment.category,
            bid: equipment.brand,
          ),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.network(
                          equipment.imageCover,
                          height: 120,
                          width: 150,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            equipment.description,
                            maxLines: 2,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            equipment.currentLocation,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          /*    RatingBar.builder(
                          initialRating: 4,
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 14,
                          itemPadding:
                          const EdgeInsets.symmetric(horizontal: 4),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.red,
                          ),
                          onRatingUpdate: (index) {},
                        ),*/
                          Text(
                            equipment.name,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    HomeCubit.get(context).oneUserData.userData.role !=
                            "service_provider"
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 7),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FavoriteButton(
                                  iconSize: 30,
                                  isFavorite: HomeCubit.get(context)
                                              .favorites[equipment.id] ==
                                          'find'
                                      ? true
                                      : false,
                                  valueChanged: (isFavorite) {
                                    if (isFavorite == true) {
                                      HomeCubit.get(context)
                                          .addFavorite(truck: equipment.id);
                                      HomeCubit.get(context).delayTime(5);
                                      HomeCubit.get(context)
                                          .favorites[equipment.id] = 'find';
                                    } else {
                                      HomeCubit.get(context)
                                          .deleteFavorite(truck: equipment.id);
                                      HomeCubit.get(context).delayTime(5);
                                      HomeCubit.get(context)
                                          .favorites[equipment.id] = '';
                                    }
                                  },
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
