import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:login/layout/homeLayout/cubit/cubit.dart';
import 'package:login/layout/homeLayout/cubit/state.dart';
import '../../../../shared/components/components.dart';

class FilterEquipments extends StatelessWidget {
  const FilterEquipments({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              cubit.homeModelFilter.equipment.isNotEmpty,
          widgetBuilder: (context) => Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height * 1,
                          child: listBuilderOrder(cubit.homeModelFilter,
                              context, const ScrollPhysics()))),
                ],
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
