import 'package:flutter/material.dart';
import 'package:login/models/UserData.dart';
import 'package:login/modules/customer/screens/ordercustomer/cubit/order_cubit.dart';
import 'package:login/modules/customer/screens/ordercustomer/cubit/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/resources/color_manager.dart';
import 'order_detalis_current_new.dart';

class OrderProductCurrent extends StatelessWidget {
  const OrderProductCurrent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<OrderCubit, OrderStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = OrderCubit.get(context);
            return listBuilderOrderUser(cubit.companyCurrentTransactions,context);
          },
),
    );
  }
}

Widget listBuilderOrderUser(List<OneUserData> data, BuildContext context) => ListView.builder(
  itemBuilder: (BuildContext context, int index) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) =>  OrderDetailsCurrentNew(
           price: OrderCubit.get(context).bookingCurrentTransactions[index].price.toString(),
          description: OrderCubit.get(context).bookingCurrentTransactions[index].description,
          id: OrderCubit.get(context).bookingCurrentTransactions[index].id,
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
                  text:'This is your offer, click to view more',
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
