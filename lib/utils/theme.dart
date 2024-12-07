import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  fontFamily: 'Poppins',
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),

  ),
);


ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.black,
  textTheme: TextTheme(
    bodyLarge: TextStyle(fontSize: 14, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 16, color: Colors.white70),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
  ),
);