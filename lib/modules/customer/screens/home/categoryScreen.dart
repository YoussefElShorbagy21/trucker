import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import '../../../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class CategoryScreens extends StatelessWidget {
  String title ;
  String name ;
  CategoryScreens(this.title, this.name , {super.key});

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
              conditionBuilder: (context) => HomeScreenCubit.get(context).homeModel.equipment.isNotEmpty ,
              widgetBuilder: (context) => Scaffold(
                appBar: AppBar(
                  title: Text(name),
                ),
                body: RefreshIndicator(
                  onRefresh: cubit.onRefresh,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: listBuilderOrder(cubit.homeModel,context,const ScrollPhysics())),
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
