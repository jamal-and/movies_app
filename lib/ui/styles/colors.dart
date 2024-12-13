import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors extends GetxController {
  // bool isLight = (Get.isDarkMode.obs.isFalse);

  // Constants Colors
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color grey = Colors.blueGrey;
  static const Color red = Color(0xffC65368);

  // Light Theme Colors
  static const Color textLight = Color(0xff4B4B4B);
  static const Color backgroundLight = Color(0xfff8f8f8);
  static const Color shapeBackgroundLight = Color(0xffffffff);
  static const Color primaryLight = Color(0xff2F99B4);
  static const Color accentLight = Color(0xff5DB3D9);

  // Dark Theme Colors
  static const Color textDark = Color(0xffffffff);
  static const Color backgroundDark = Color(0xff222831);
  static const Color shapeBackgroundDark = Color(0xff29303B);
  static const Color primaryDark = Color(0xff29A7C7);
  static const Color accentDark = Color(0xff29B4D8);

  // Dynamic Colors
  static Color textColor = const Color(0xff4B4B4B);
  static Color background = const Color(0xfffafafa);
  static Color shapeBackground = const Color(0xffffffff);
  static Color primary = const Color(0xff2F99B4);
  static Color accent = const Color(0xff5DB3D9);

  void updateColor(ThemeMode themeMode) {
    final bool isLight = themeMode == ThemeMode.light;
    background = isLight ? backgroundLight : backgroundDark;
    primary = isLight ? primaryLight : primaryDark;
    accent = isLight ? accentLight : accentDark;
    shapeBackground = isLight ? shapeBackgroundLight : shapeBackgroundDark;
    textColor = isLight ? textLight : textDark;
    update();
    //log(Theme.of(Get.context!).textTheme.bodyText1!.color!.toString());
  }

  @override
  void onReady() {
    super.onReady();
    updateColor(Get.isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }
}
