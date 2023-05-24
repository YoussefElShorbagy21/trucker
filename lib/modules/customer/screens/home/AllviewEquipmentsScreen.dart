import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import '../../../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class AllViewEquipments extends StatelessWidget {
  const AllViewEquipments({super.key});
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
                appBar: AppBar(),
                body: RefreshIndicator(
                  onRefresh: cubit.onRefresh,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Expanded(child: SizedBox(
                        height: MediaQuery.of(context).size.height * 1
                            ,child: listBuilderOrder(cubit.homeModel,context, const ScrollPhysics()))),
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
        )
    );
  }
}
