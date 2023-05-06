import 'package:flutter/material.dart';

import '../../../shared/resources/cateogry_contants.dart';
import '../../../shared/resources/color_manager.dart';


class CategoryItems extends StatelessWidget {
  const CategoryItems({
    super.key,
    required this.height,
    required this.width,
    required this.radius,
    required this.titleSize,
    required this.image,
    required this.title,
    required this.color,
  });

  final double height, width, radius, titleSize;
  final String image, title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kLess),//4.0
      child: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  ColorManager.cDark,
                  BlendMode.difference,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: title,
                    style: TextStyle(color: color, fontSize: titleSize),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
