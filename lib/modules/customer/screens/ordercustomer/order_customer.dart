import 'package:flutter/material.dart';
import 'package:login/modules/customer/screens/ordercustomer/cubit/order_cubit.dart';
import 'package:login/modules/customer/screens/ordercustomer/cubit/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            var cubit = OrderCubit.get(context).oneUserDataCurrentTransactions.userData ;
            return ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Card(
                      color: Colors.white,
                      elevation: 2,
                      child: buildCurrentTransactions(context,cubit.currentTransactions.length)),
                  SizedBox(
                    height:  MediaQuery.of(context).size.height / 10,
                  ),
                  Card(
                    color: Colors.white, elevation: 2, child: buildAcceptedTransactions(context,cubit.acceptedTransactions.length),),
                  SizedBox(
                    height:  MediaQuery.of(context).size.height / 10,
                  ),
                  Card(
                      color: Colors.white,
                      elevation: 2,
                      child: buildDoneTransactions(context,cubit.doneTransactions.length)),
                ],
              );
          },
),
    );
  }
}