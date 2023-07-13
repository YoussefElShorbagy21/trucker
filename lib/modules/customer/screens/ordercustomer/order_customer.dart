import 'package:flutter/material.dart';
import 'package:login/modules/customer/screens/ordercustomer/cubit/order_cubit.dart';
import 'package:login/modules/customer/screens/ordercustomer/cubit/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/shared/resources/app_localizations.dart';
import 'orderwidget.dart';

class OrderCustomer extends StatelessWidget {
  const OrderCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<OrderCubit, OrderStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit =
              OrderCubit.get(context).oneUserDataCurrentTransactions.userData;
          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  ' Track your orders status'.tr(context),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 25,
              ),
              buildCurrentTransactions(
                  context, cubit.currentTransactions.length),
              SizedBox(
                height: MediaQuery.of(context).size.height / 25,
              ),
              buildAcceptedTransactions(
                  context, cubit.acceptedTransactions.length),
              SizedBox(
                height: MediaQuery.of(context).size.height / 25,
              ),
              buildDoneTransactions(context, cubit.doneTransactions.length),
            ],
          );
        },
      ),
    );
  }
}
