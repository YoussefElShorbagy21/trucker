import 'package:flutter/material.dart';
import 'package:login/shared/resources/app_localizations.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/font_manager.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: size.height * 0.05
        ),
      width: size.width * 0.8,
      child: Row(
        children:  [
           Expanded(
              child: Divider(
                color: ColorManager.gery,
                height: 2,
              )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5,
            ),
            child: Text('continueWith'.tr(context),
              style: TextStyle(
                color: ColorManager.black,
                fontFamily: FontConstants.fontFamily,
                fontWeight: FontWeightManager.medium,
                fontSize: FontSize.s14,
              ),
            ),
          ),
            Expanded(
              child: Divider(
                color: ColorManager.gery,
                height: 2,
              )
          ),
        ],
      ),
    );
  }
}

