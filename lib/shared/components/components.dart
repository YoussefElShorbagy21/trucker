import 'package:flutter/material.dart';
import 'package:login/layout/homeLayout/cubit/state.dart';
import 'package:login/shared/resources/app_localizations.dart';
import '../../layout/homeLayout/cubit/cubit.dart';
import '../../models/categeiromodel.dart';
import '../../modules/customer/screens/detalis gategory/details_category_screen.dart';
import 'package:skeletons/skeletons.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void navigatefisnh(context , widget) =>  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) => widget,
    ),
        (route) => false
);


Widget listBuilderOrder(GetEquipment data, BuildContext context , ScrollPhysics physics) => SizedBox(
  height:  data.equipment.length <= 5 ? MediaQuery.of(context).size.height * 1 : MediaQuery.of(context).size.height * 1.6,
  child: ListView.builder(
    physics: physics,
    itemBuilder: (context, index) {
      int reverse = data.equipment.length - 1 - index;
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  DetailsCategoryScreen(
                    id:data.equipment[reverse].truckId,
                    cid:data.equipment[reverse].category ,
                    scid: data.equipment[reverse].subcategory,
                    bid: data.equipment[reverse].brand,
                  ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              color: ColorManager.white,
              elevation: 2,
              child: buildItem(context, data.equipment[reverse])),
        ),
      );
    },
    itemCount: data.equipment.length ,
  ),
);

Widget buildItem(BuildContext context, Equipment equipment) => BlocConsumer<HomeCubit, HomeStates>(
listener: (context, state) {},
builder: (context, state) {
  return Padding(
padding: const EdgeInsets.all(20.0),
child: Row(
  children: [
    Container(
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
                    equipment.locationFrom,
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
                      Flexible(
                        child: Text(
                          equipment.price.toString(),
                          style: TextStyle(
                              color: ColorManager.black, fontSize: 18),
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
            HomeCubit.get(context).oneUserData.userData.role != "service_provider" ? Expanded(
              child: Row(
                children: [
                  Container(
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
                  ),
                  const Spacer(),
                  FavoriteButton(
                    iconSize: 30,
                    isFavorite: HomeCubit.get(context).favorites[equipment.id] == 'find' ? true  : false,
                    valueChanged: (isFavorite) {
                      if(isFavorite == true) {
                        HomeCubit.get(context).addFavorite(truck: equipment.id);
                        HomeCubit.get(context).delayTime(5);
                        HomeCubit.get(context).favorites[equipment.id] = 'find' ;
                      }
                      else {
                        HomeCubit.get(context).deleteFavorite(truck: equipment.id);
                        HomeCubit.get(context).delayTime(5);
                        HomeCubit.get(context).favorites[equipment.id] = '';
                      }
                    },
                  ),
                ],
              ),
            ) :
            Container(),
          ],
        ),
      ),
    ),
  ],
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