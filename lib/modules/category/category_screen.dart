import 'package:flutter/material.dart';
import 'package:login/layout/homeLayout/cubit/state.dart';
import 'package:login/shared/resources/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/homeLayout/cubit/cubit.dart';
import '../../shared/resources/cateogry_contants.dart';
import '../../shared/resources/color_manager.dart';
import '../customer/screens/home/categoryScreen.dart';
import 'widgets/category_items.dart';
import 'widgets/category_view.dart';
import 'widgets/custom_app_bar.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isList = false;
  @override
  Widget build(BuildContext context)  {
    return BlocConsumer<HomeCubit, HomeStates>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return Scaffold(
      backgroundColor: ColorManager.cDark,
      appBar: CustomAppBar(
        title: "Category".tr(context),
        action: [
          IconButton(
            icon: isList ? const Icon(Icons.apps) : const Icon(Icons.list),
            onPressed: (){
              setState(() {
                    isList = !isList;
                  });
                },
              ),
        ],
      ),
      body:  CategoryView(
        color: ColorManager.cWhite,
        colum: isList ? 1 : 2 ,
        items: HomeCubit.get(context).listCate.length,
        ratio: isList ? 2.6 : 1.3,
        direction: Axis.vertical,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              HomeCubit.get(context).getCategoryData(HomeCubit.get(context).listCate[index].id);
              Navigator.push(context, MaterialPageRoute(builder: (_) =>  CategoryScreens(HomeCubit.get(context).listCate[index].id.toString(),
                  HomeCubit.get(context).listCate[index].name)));
            },
            child: CategoryItems(
              height: 150.0,
              radius: kLessPadding,
              width: MediaQuery.of(context).size.width,
              color: ColorManager.cWhite,
              title:HomeCubit.get(context).listCate[index].name ,
              titleSize: 20,
              image: categoryList[index].image ?? 'assets/images/category_img/truck.jpg',
            ),
          );
        },
      ),
    );
  },
);
  }
}

