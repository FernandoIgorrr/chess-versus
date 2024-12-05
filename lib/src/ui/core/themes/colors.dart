import 'package:flutter/material.dart';

class AppColors {
  static const Color lightBlue = Color(0XFFD7E3FF);
  static const Color blue = Color(0XFF055AB2);
  static const Color white = Color(0XFFFFFFFF);
  static const Color red = Color(0XFFBA1A1A);
  static const Color purple = Color(0XFF810081);
  static const Color pink = Color(0XFFFDAFF2);
  static const Color lightRedPink = Color(0XFFFFB4AB);
  static const Color darkRed = Color(0XFF690005);
  static const Color lightPurple = Color(0XFFEBDCFF);

  // Esquema de cores claro
  static const lightCodeScheme = ColorScheme.light(
    brightness: Brightness.light,
    primary: lightBlue,
    onPrimary: blue,
    secondary: lightPurple,
    error: white,
    onError: red,
  );

  // Esquema de cores escuro
  static const darkCodeScheme = ColorScheme.dark(
    brightness: Brightness.dark,
    primary: purple,
    onPrimary: pink,
    secondary: lightPurple,
    error: lightRedPink,
    onError: darkRed,
  );
}
