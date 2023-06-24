import 'package:flutter/material.dart';
import 'package:login/modules/customer/screens/ordercustomer/acceptedTransactions/order_product_accpet.dart';
import 'package:login/modules/customer/screens/ordercustomer/cubit/order_cubit.dart';
import 'package:login/modules/customer/screens/ordercustomer/currentTransactions/order_product_current.dart';

class IconWidget extends StatelessWidget {
  final IconData icon;
  final Color color;

  const IconWidget({
    Key? key,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
    ),
    child: Icon(
      icon,
      color: Colors.white,
    ),
  );
}

Widget buildCurrentTransactions(context, int length) => ListTile(
  onTap: () {
    // OrderCubit().getUserDataCurrentTransactions();
    Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderProductCurrent()));
  },
  leading: const IconWidget(
    icon: Icons.emoji_transportation,
    color: Colors.blue,
  ),
  title: Text(
    'CurrentTransactions ($length)',
    style: const TextStyle(
      fontSize: 16,
    ),
  ),
  trailing: const Icon(
    Icons.arrow_forward_ios,
    size: 12,
  ),
);

Widget buildAcceptedTransactions(context , int length) => ListTile(
  onTap: () {
    // OrderCubit().getUserDataAcceptedTransactions();
    Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderProductAccept()));
  },
  leading: const IconWidget(
    icon: Icons.confirmation_number_outlined,
    color: Colors.green,
  ),
  title:  Text(
    'AcceptedTransactions ($length)',
    style: const TextStyle(
      fontSize: 16,
    ),
  ),
  trailing: const Icon(
    Icons.arrow_forward_ios,
    size: 12,
  ),
);

Widget buildDoneTransactions(context , int length) => ListTile(
  onTap: () {
  },
  leading: const IconWidget(
    icon: Icons.bookmark_added_rounded,
    color: Colors.greenAccent,
  ),
  title: Text(
    'DoneTransactions ($length)',
    style: const TextStyle(
      fontSize: 16,
    ),
  ),
  trailing: const Icon(
    Icons.arrow_forward_ios,
    size: 12,
  ),
);