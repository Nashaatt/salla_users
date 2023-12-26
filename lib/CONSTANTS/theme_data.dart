import 'package:flutter/material.dart';

import 'app_colors.dart';


class Styles {
  static ThemeData themeData(
      {required bool isDarkTheme, required BuildContext context}) {
    return ThemeData(
      scaffoldBackgroundColor: isDarkTheme
          ? AppColors.darkScaffoldColor
          : AppColors.lightScaffoldColor,
      cardColor: isDarkTheme
          ? const Color.fromARGB(255, 85, 85, 85)
          : const Color.fromARGB(131, 250, 250, 250),
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      appBarTheme: AppBarTheme(
        toolbarHeight: 40,
        backgroundColor: isDarkTheme
            ? AppColors.darkScaffoldColor
            : AppColors.lightScaffoldColor,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: isDarkTheme ? Colors.white : Color(0xffCBB26A),
        ),
        iconTheme:
            IconThemeData(color: isDarkTheme ? Colors.white : Colors.black),
      ),
    );
  }
}
