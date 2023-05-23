import 'package:flutter/material.dart';

import '../../../shared/resources/cateogry_contants.dart';



class CategoryView extends StatelessWidget {
  const CategoryView({
    this.height,  this.width , super.key, required this.colum, required this.items, required this.color, required this.ratio, this.direction, this.itemBuilder,
  });

  final int colum,items;
  // final Widget child;
  final Color color;
  final double? ratio,height,width;
  final direction,itemBuilder;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: color,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(kLess),//4.0
        scrollDirection: direction,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: colum,
          childAspectRatio: ratio!,
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
        ),
        itemCount: items,
        itemBuilder: itemBuilder,
      ),
    );
  }
}