import 'package:flutter/material.dart';

import 'font_manager.dart';

_getTextStyle(double fontSize , FontWeight fontWeight,Color color)
{
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: FontConstants.fontFamily,
    color: color,
  );
}

//regular style
 getRegularStyle({double fontSize = FontSize.s12 , required Color color})
{
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}

//medium style
 getMediumStyle({double fontSize = FontSize.s12 , required Color color})
{
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}

//light style
 getLightStyle({double fontSize = FontSize.s12 , required Color color})
{
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}

//semiBold style
 getSemiBoldStyle({double fontSize = FontSize.s12 , required Color color})
{
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}

//bold style
 getBoldStyle({double fontSize = FontSize.s12 , required Color color})
{
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}
