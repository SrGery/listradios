import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_style.dart';

class Themes {
  static final appTheme = ThemeData(
      primaryColor: AppStyles().primary,
      hintColor: Colors.black26,
      primaryColorDark: const Color(0xff484848),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white70),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      fontFamily: 'Raleway',
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: AppStyles().secondary));
}
