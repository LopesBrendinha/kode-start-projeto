import 'package:flutter/material.dart';

class AppColors {
  // Paleta Dark 
  static Color primaryColorDark = const Color(0xff5D78F0);
  static Color primaryColorLight = const Color(0xff87A1FA);
  static Color appBarColor = const Color(0xff1C1B1F);
  static Color backgroundColor = const Color(0xFF000000);
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color red = const Color(0xffD53C2E);
  static Color green = const Color(0xff34C759);
  static Color gray = const Color(0xffC7C7C7);

  // Paleta Light 
  static Color lightPrimaryColorDark = const Color(0xff5D78F0);
  static Color lightPrimaryColorLight = const Color(0xff87A1FA); 
  static Color lightAppBarColor = Colors.white;
  static Color lightBackgroundColor = const Color(0xFFF5F5F5);
  static Color lightWhite = Colors.white;
  static Color lightBlack = const Color(0xFF222222);
  static Color lightRed = const Color(0xffE57373);
  static Color lightGreen = const Color(0xff81C784);
  static Color lightGray = const Color(0xffE0E0E0);


  static Color getPrimaryColor(bool isDark) => isDark ? primaryColorDark : lightPrimaryColorDark;
  static Color getAppBarColor(bool isDark) => isDark ? appBarColor : lightAppBarColor;
  static Color getBackgroundColor(bool isDark) => isDark ? backgroundColor : lightBackgroundColor;
  static Color getTextColor(bool isDark) => isDark ? white : lightBlack;
  static Color getCardColor(bool isDark) => isDark ? primaryColorLight : lightWhite;
}