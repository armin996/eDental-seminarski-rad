import 'package:flutter/material.dart';

final Color primaryColor = Color(0xFF36B0F4);
final Color secondaryColor = Color(0xFFA0AEC0);
final Color buttonColor1 = Color(0xFF50E3C2);
final Color buttonColor2 = Color(0xFFFD7272);
final Color titleColor = Color(0xFF323232);
final Color textColor = Color(0xFF6E798C);
final Color scaffoldColor = Color(0xFFE8E8E8);

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: scaffoldColor,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    secondary: secondaryColor,
    error: Colors.red,
    surface: Colors.white,
    background: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onError: Colors.white,
    onSurface: textColor,
    onBackground: textColor,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: buttonColor1,
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: buttonColor1,
    ),
  ),
  appBarTheme: AppBarTheme(
    color: primaryColor,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextTheme(
      titleMedium: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ).titleMedium,
  ),
  textTheme: TextTheme(
    headlineMedium: TextStyle(
      color: titleColor,
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: textColor,
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
    ),
  ),
);
