// ignore_for_file: prefer_const_constructors, unused_field

import 'package:expense_manager/Account/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:expense_manager/Pages/my_chats.dart';
import 'package:expense_manager/Theme/themes_constants.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Brightness? _brightness;
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    _brightness = WidgetsBinding.instance?.window.platformBrightness;
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: AnimatedSplashScreen(
        splash: Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          ),
        ),
        nextScreen:

            // FirebaseAuth.instance.currentUser == null
            LoginScreen(),
        // MyChats(),
      ),
    );
  }
}
