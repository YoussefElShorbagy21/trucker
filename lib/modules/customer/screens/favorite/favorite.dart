import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:login/layout/homeLayout/cubit/cubit.dart';
import 'package:login/shared/resources/app_localizations.dart';
import 'package:favorite_button/favorite_button.dart';
import '../../../../layout/homeLayout/cubit/state.dart';
import '../../../../models/categeiromodel.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/font_manager.dart';
import '../detalis gategory/details_category_screen.dart';
import '../home/cubit/cubit.dart';
import '../home/cubit/state.dart';


class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit,HomeScreenState>(
              listener: (context,state) {},
              builder: (context,state) {
                print(HomeScreenCubit.get(context).favList.length);
                print(HomeScreenCubit.get(context).favData.length);
                var cubit = HomeScreenCubit.get(context);
                return Conditional.single(
                  context: context,
                  conditionBuilder: (context) => cubit.favData.isNotEmpty,
                  widgetBuilder: (context) => Scaffold(
                    appBar: AppBar(),
                    body: RefreshIndicator(
                      onRefresh: cubit.onRefresh,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Expanded(child: listBuilderOrderFav(cubit.favData,context,const ScrollPhysics())),
                          ],
                        ),
                      ),
                    ),
                  ),
                  fallbackBuilder: (context) => Scaffold(
                    appBar: AppBar(),
                    body: Column(
                      children: [
                        cardView(context),
                        cardView(context),
                        cardView(context),
                      ],
                    ),
                  ),
                );
              },
            );
  }
}

Widget listBuilderOrderFav(List<DetailsEquipment> data, BuildContext context , ScrollPhysics physics) => SizedBox(
  height:  data.length <= 5 ? MediaQuery.of(context).size.height * 1 : MediaQuery.of(context).size.height * 1.6,
  child: ListView.builder(
    physics: physics,
    itemBuilder: (context, index) {
      int reverse = data.length - 1 - index;
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  DetailsCategoryScreen(
                    id:data[reverse].truckId,
                    cid:data[reverse].category ,
                    scid: data[reverse].subcategory,
                    bid: data[reverse].brand,
                  ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              color: ColorManager.white,
              elevation: 2,
              child: buildItemFav(context, data[reverse])),
        ),
      );
    },
    itemCount: data.length ,
  ),
);

Widget buildItemFav(BuildContext context, DetailsEquipment equipment) => Padding(
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
                          HomeScreenCubit.get(context).favData.removeWhere((element) => element.id == equipment.id);
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