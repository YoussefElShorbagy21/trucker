import 'package:flutter/material.dart';
import 'package:login/modules/customer/screens/ordercustomer/acceptedTransactions/order_product_accpet.dart';
import 'package:login/modules/customer/screens/ordercustomer/currentTransactions/order_product_current.dart';
import 'package:login/shared/resources/app_localizations.dart';

import '../../../../shared/resources/color_manager.dart';
import 'doneTransaction/order_product_done.dart';

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
    icon: Icons.hourglass_empty_outlined,
    color: Color(0xFFF1B963),
  ),
  title: Text(
    'CurrentTransactions '.tr(context)+'($length)',
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
    icon: Icons.no_crash_outlined,
    color: Color(0xFF22A699),
  ),
  title:  Text(
    'AcceptedTransactions '.tr(context)+'($length)',
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
    Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderProductDone()));
  },
  leading:  IconWidget(
    icon: Icons.verified_outlined,
    color: ColorManager.kGold,
  ),
  title: Text(
    'DoneTransactions '.tr(context)+'($length)',
    style: const TextStyle(
      fontSize: 16,
    ),
  ),
  trailing: const Icon(
    Icons.arrow_forward_ios,
    size: 12,
  ),
);