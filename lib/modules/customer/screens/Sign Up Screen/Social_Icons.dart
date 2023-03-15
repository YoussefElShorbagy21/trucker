import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../shared/resources/color_manager.dart';


class SocialIcons extends StatelessWidget {
  final String iconSource;
  final VoidCallback press;

  const SocialIcons({
    Key? key,
    required this.iconSource,
    required this.press
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color:  ColorManager.gery,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconSource,
          height: 20,
          width: 20,
          color: ColorManager.black,
        ),
      ),
    );
  }
}
