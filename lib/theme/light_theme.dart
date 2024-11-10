
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  // appBarTheme: const AppBarTheme(
  //   backgroundColor: Colors.transparent,
  //   elevation: 0,
  //   //color: Colors.blue,
  //   // titleTextStyle: TextStyle(
  //   //   color: Colors.white,
  //   //   fontSize: 24,
  //   //   fontWeight: FontWeight.w500,
  //   // ),
  //   // iconTheme: IconThemeData(
  //   //   color: Colors.white,
  //   // ),
  // ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
    titleMedium: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  ),
  // // textButtonTheme: TextButtonThemeData(
  // //   style: TextButton.styleFrom(
  // //     foregroundColor: Colors.white,
  // //     backgroundColor: Colors.blue,
  // //     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
  // //     //textStyle: const TextStyle(fontWeight: FontWeight.bold),
  // //   ),
  // // ),
  // elevatedButtonTheme: ElevatedButtonThemeData(
  //   style: ElevatedButton.styleFrom(
  //     backgroundColor: Colors.blue,
  //     foregroundColor: Colors.white,
  //     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
  //     textStyle: const TextStyle(fontWeight: FontWeight.bold),
  //   ),
  // ),
  // outlinedButtonTheme: OutlinedButtonThemeData(
  //   style: OutlinedButton.styleFrom(
  //     foregroundColor: Colors.blue,
  //     side: const BorderSide(color: Colors.blue),
  //     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
  //     textStyle: const TextStyle(fontWeight: FontWeight.bold),
  //   ),
  // ),
);
