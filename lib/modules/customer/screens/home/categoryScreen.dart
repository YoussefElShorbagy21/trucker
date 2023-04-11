import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:login/shared/resources/app_localizations.dart';
import 'package:favorite_button/favorite_button.dart';
import '../../../../models/categeiromodel.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/font_manager.dart';
import '../detalis gategory/details_category_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class CategoryScreen extends StatelessWidget {
  String title ;

  CategoryScreen(this.title,{super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeScreenCubit()..getCategoryData(title),
        child : BlocConsumer<HomeScreenCubit,HomeScreenState>(
          listener: (context,state) {},
          builder: (context,state) {
            var cubit = HomeScreenCubit.get(context);
            return Conditional.single(
              context: context,
              conditionBuilder: (context) => HomeScreenCubit.get(context).homeModel1.equipment.isNotEmpty ,
              widgetBuilder: (context) => Scaffold(
                appBar: AppBar(
                  title: Text(cubit.homeModel1.equipment[0].category),
                ),
                body: RefreshIndicator(
                  onRefresh: cubit.onRefresh,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: listBuilderOrder(cubit.homeModel1)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              fallbackBuilder: (context) => Scaffold(
                appBar: AppBar(),
                body: Column(
                  children:  [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height/ 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image:  const DecorationImage(
                          image: AssetImage('assets/images/forklift_03.jpg'),
                          fit: BoxFit.cover,
                        ),

                      ),

                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text('There Was No Equipments',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),)
                  ],
                ),
              ) ,
            );
          },
        )
    );
  }
}

Widget listBuilderOrder(GetEquipment data) => ListView.builder(
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
