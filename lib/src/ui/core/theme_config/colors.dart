import 'package:flutter/material.dart';

class AppColors {
  static const Color darkBlueGray = Color(0xFF2C3E50);
  static const Color blueGray = Color(0xFF375A7F);
  static const Color drakGray = Color(0xFF222222);
  static const Color gray = Color(0xFF3A3A3A);
  static const Color lightGray200 = Color(0xFF75818C);
  static const Color lightGray100 = Color(0xFF7F8C8D);
  static const Color lightGray = Color(0xFFB9C4C4);

  static const Color lightBlue = Color(0XFFD7E3FF);
  static const Color blue = Color(0XFF055AB2);
  static const Color white = Color(0XFFFFFFFF);
  static const Color red = Color(0XFFBA1A1A);
  static const Color purple = Color(0XFF810081);
  static const Color pink = Color(0XFFFDAFF2);
  static const Color lightRedPink = Color(0XFFFFB4AB);

  static const Color redOrange = Color(0XFFC44133);
  static const Color green = Color(0XFF00bc8c);
  static const Color lightPurple = Color(0XFFEBDCFF);

  // Esquema de cores claro
  static const lightCodeScheme = ColorScheme.light(
    brightness: Brightness.light,
    primary: darkBlueGray,
    onPrimary: white,
    //surface: lightGray,
    //secondary: lightGray,
    secondary: lightGray200,
    error: redOrange,
    onError: white,
    scrim: green,
  );

  // Esquema de cores escuro
  static const darkCodeScheme = ColorScheme.dark(
    brightness: Brightness.dark,
    surface: drakGray,
    primary: blueGray,
    onPrimary: white,
    secondary: lightGray200,
    error: redOrange,
    onError: white,
    scrim: green,
  );
}
