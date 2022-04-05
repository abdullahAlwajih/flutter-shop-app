import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppThemes {
  static ThemeData lightThemeData = ThemeData(
    primarySwatch: Colors.purple,
    colorScheme: AppColors.colorSchemeLight,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Lato',
    textTheme: textTheme,
    appBarTheme: appBarTheme,
    inputDecorationTheme: const InputDecorationTheme(
      isCollapsed: true,
      contentPadding: EdgeInsets.all(5),
      border: UnderlineInputBorder(borderSide: BorderSide(width: 0.5)),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 0.5)),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 0.5)),
      disabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 0.5)),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    dialogTheme: const DialogTheme(
        titleTextStyle: TextStyle(
            fontSize: 18.0, color: Colors.black87, fontWeight: FontWeight.bold),
        contentTextStyle: TextStyle(fontSize: 14.0, color: Colors.black87),
        backgroundColor: Colors.white),
  );

  static TextTheme textTheme = const TextTheme(
    headline1: TextStyle(
        // fontSize: 96.0,
        // fontWeight: light,
        // height:  -1.5
        ),
    headline2: TextStyle(
        // fontSize: 60.0,
        // fontWeight: light,
        // height:  -0.5
        ),
    headline3: TextStyle(
        // fontSize: 48.0,
        // fontWeight: regular,
        // height:  0.0,
        ),
    headline4: TextStyle(
        // fontSize: 34.0,
        // fontWeight: regular,
        // height:  0.25
        ),
    headline5: TextStyle(
        // fontSize: 24.0,
        // fontWeight: regular,
        // height:  0.0
        ),
    headline6: TextStyle(
        // fontSize: 20.0,
        // fontWeight: medium,
        // height:  0.15
        ),
    subtitle1: TextStyle(
        // fontSize: 16.0,
        // fontWeight: regular,
        // height:  0.15
        ),
    subtitle2: TextStyle(
        // fontSize: 14.0,
        // fontWeight: medium,
        // height:  0.1
        ),
    bodyText1: TextStyle(
        // fontSize: 16.0,
        // fontWeight: regular,
        // height:  0.5
        ),
    bodyText2: TextStyle(
        // fontSize: 14.0 ,
        // fontWeight: regular,
        // height: 0.25
        ),
    button: TextStyle(
        // fontSize: 14.0 ,
        // fontWeight: medium,
        // height: 1.25
        ),
    caption: TextStyle(
        // fontSize: 12.0 ,
        // fontWeight: regular,
        // height: 0.4
        ),
    overline: TextStyle(
        // fontSize: 10.0 ,
        // fontWeight: regular,
        // height:  1.5
        ),
  );

  static AppBarTheme appBarTheme = AppBarTheme(
    toolbarTextStyle: textTheme.headline6?.copyWith(
        fontWeight: FontWeight.w700, color: Colors.white, fontSize: 20.0),
    centerTitle: true,
    titleTextStyle: textTheme.headline1?.copyWith(
        fontWeight: FontWeight.w700, color: Colors.white, fontSize: 20),
  );
}
