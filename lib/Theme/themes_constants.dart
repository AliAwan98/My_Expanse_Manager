// ignore_for_file: unused_element, deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';

ThemeData get lightTheme => ThemeData(
      fontFamily: "OpenSans",
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0xFF128C7E),
        secondary: const Color(0xFF128C7E),
      ),
    );
// ThemeData(
//       fontFamily: "OpenSans",
//       primarySwatch: Colors.grey,
//       primaryColor: Colors.white,
//       brightness: Brightness.light,
//       backgroundColor: const Color(0xFFE5E5E5),
//       accentColor: Colors.black,
//       accentIconTheme: IconThemeData(color: Colors.white),
//       dividerColor: Colors.white54,
// );
ThemeData get darkTheme => ThemeData(
      fontFamily: "OpenSans",
      primarySwatch: Colors.grey,
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      backgroundColor: const Color(0xFF212121),
      accentColor: Colors.white,
      accentIconTheme: IconThemeData(color: Colors.black),
      dividerColor: Colors.black12,
    );
