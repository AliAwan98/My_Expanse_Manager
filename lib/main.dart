// ignore_for_file: prefer_const_constructors

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:expense_manager/Account/login_screen.dart';
import 'package:expense_manager/Pages/my_chats.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      home: AnimatedSplashScreen(
        splash: CircularProgressIndicator(),
        nextScreen: FirebaseAuth.instance.currentUser == null
            ? LoginScreen()
            : MyChats(),
      ),
    );
  }
}
