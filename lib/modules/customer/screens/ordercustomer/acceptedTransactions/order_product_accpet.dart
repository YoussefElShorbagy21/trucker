import 'package:flutter/material.dart';
import 'package:login/models/UserData.dart';
import 'package:login/modules/customer/screens/ordercustomer/cubit/order_cubit.dart';
import 'package:login/modules/customer/screens/ordercustomer/cubit/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/shared/resources/app_localizations.dart';
import '../../../../../shared/resources/color_manager.dart';
import 'order_detalis_accept_new.dart';

class OrderProductAccept extends StatelessWidget {
  const OrderProductAccept({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<OrderCubit, OrderStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = OrderCubit.get(context);
            return listBuilderOrderUser(cubit.companyAcceptedTransactions,context);
          },
),
    );
  }
}

Widget listBuilderOrderUser(List<OneUserData> data, BuildContext context) => ListView.builder(
  itemBuilder: (BuildContext context, int index) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) =>  OrderDetailsAcceptNew(
           price: OrderCubit.get(context).bookingAcceptedTransactions[index].price.toString(),
          description: OrderCubit.get(context).bookingAcceptedTransactions[index].description,
          id: OrderCubit.get(context).bookingAcceptedTransactions[index].id,
          sourceLatLa: OrderCubit.get(context).bookingAcceptedTransactions[index].startLocationLa,
          sourceLatLo: OrderCubit.get(context).bookingAcceptedTransactions[index].startLocationLo,
          destinationLa: OrderCubit.get(context).bookingAcceptedTransactions[index].deliveryLocationLa,
          destinationLo: OrderCubit.get(context).bookingAcceptedTransactions[index].deliveryLocationLo,
          serviceId: OrderCubit.get(context).bookingAcceptedTransactions[index].serviceProviderId,
        )
        ));
      },
      child: buildItemUserOrder(context,data[index]),
    );
  },
  itemExtent: 120,
  itemCount: data.length,
);

Widget buildItemUserOrder(BuildContext context, OneUserData oneUserData) =>  Padding(
  padding: const EdgeInsets.all(5.0),
  child: Card(
    color: Colors.white,
    elevation: 2,
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: CircleAvatar(
            radius: 35,
            backgroundImage: oneUserData.userData.avatar.isNotEmpty ? NetworkImage(oneUserData.userData.avatar) :
            const NetworkImage('https://t3.ftcdn.net/jpg/03/29/17/78/360_F_329177878_ij7ooGdwU9EKqBFtyJQvWsDmYSfI1evZ.jpg',),
            child: oneUserData.userData.avatar.isNotEmpty ? null : Text(
              oneUserData.userData.name[0].toUpperCase(),
              style: TextStyle(
                fontSize: 30,
                color: ColorManager.black,
              ),
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(oneUserData.userData.name,style: const TextStyle(fontSize: 20),),
              Text(oneUserData.userData.phone,style: const TextStyle(fontSize: 20),),
              RichText(text:  TextSpan(
                  text:'This is your offer, click to view more'.tr(context),
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      color: Colors.black)
              ),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
