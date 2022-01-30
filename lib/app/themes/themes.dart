import 'package:flutter/material.dart';

class CustomTheme {
  static final primaryColorDark = Colors.yellow;
  static final primaryColorLight = Color(0xff00A294);

  final darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    primaryColor: primaryColorDark,
    secondaryHeaderColor: Colors.black,
    hintColor: Colors.grey,
    textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Roboto',
          bodyColor: Colors.white70,
        ),
    primaryTextTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Roboto',
          bodyColor: Colors.black,
        ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primaryColorDark,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColorDark,
    ),
    iconTheme: IconThemeData(color: Colors.white),
    primaryIconTheme: IconThemeData(color: primaryColorDark),
    dividerColor: Colors.transparent,
  );

  final lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    primaryColor: primaryColorLight,
    secondaryHeaderColor: Colors.white,
    hintColor: Colors.grey,
    textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Roboto',
          bodyColor: Color.fromRGBO(90, 90, 90, 1),
        ),
    primaryTextTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Roboto',
          bodyColor: Colors.black,
        ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primaryColorLight,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColorLight,
    ),
    iconTheme: IconThemeData(color: Colors.grey),
    primaryIconTheme: IconThemeData(color: Color.fromRGBO(234, 125, 91, 0.9)),
    dividerColor: Colors.transparent,
  );
}
