// ignore_for_file: prefer_const_constructors

import 'package:expense_manager/Account/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "OpenSans",
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF128C7E),
          secondary: const Color(0xFF128C7E),
        ),
      ),
      home: LoginScreen(),
    );
  }
}
