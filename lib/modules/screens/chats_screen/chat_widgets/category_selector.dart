import 'package:flutter/material.dart';

import '../../../../shared/resources/color_manager.dart';

//!!!this screen un used because i don't want to make status like whats app :)
//!!! you can delete this screen !!!

class CategorySelector extends StatefulWidget {
  const CategorySelector({Key? key}) : super(key: key);

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex = 0;
  final List<String> categories = ['Messages', 'Status', 'Calls'];

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return Container(
      height: heightScreen / 8,
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widthScreen / 45, //20.0
                  vertical: heightScreen / 25, //30.0
                ),
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color: index == selectedIndex ? ColorManager.white : Colors.white60,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
