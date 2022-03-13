// // ignore_for_file: prefer_const_constructors

// import 'package:expense_manager/Account/login_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("Home Screen"),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Image.asset(
//               "images/welcome.jpg",
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.all(65),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.red,
//               ),
//               onPressed: () {
//                 FirebaseAuth.instance.signOut();
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => LoginScreen(),
//                   ),
//                 );
//               },
//               child: Text(
//                 "Logout",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
