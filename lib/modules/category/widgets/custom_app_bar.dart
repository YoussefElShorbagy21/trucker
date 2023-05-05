import 'package:flutter/material.dart';

import '../../../shared/resources/color_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, this.title, this.child, this.action})
      : super(key: key);

  final String? title;
  final Widget? child;
  final action;

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title!,
        style: TextStyle(color: ColorManager.black),
      ),
      centerTitle: true,
      backgroundColor: ColorManager.cWhite,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: ColorManager.cGold),
      leading: child,
      actions: action,
    );
  }
}
