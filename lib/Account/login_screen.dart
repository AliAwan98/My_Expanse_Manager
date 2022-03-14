// ignore_for_file: prefer_const_constructors, unnecessary_const, prefer_const_literals_to_create_immutables

import 'package:country_list_pick/country_list_pick.dart';
import 'package:expense_manager/Account/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String dialCodeDigits = "+92";
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     left: 28,
            //     right: 28,
            //   ),
            //   child: Image.asset(
            //     "images/login_image.jpeg",
                
            //   ),
            // ),
            Container(
              width: 280,
              margin: EdgeInsets.only(
                top: 20,
              ),
              child: Center(
                child: Text(
                  "Enter your phone number to get started",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: 300,
              margin: EdgeInsets.only(
                top: 10,
              ),
              child: Center(
                child: Text(
                  "You will receive a verification code.Carrier rates may apply.",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
              ),
              width: 180,
              height: 40,
              child: CountryListPick(
                appBar: AppBar(
                  title: Text('Pick your country'),
                ),
                theme: CountryTheme(
                  isShowFlag: false,
                  isShowTitle: true,
                  isShowCode: false,
                  isDownIcon: true,
                ),
                initialSelection: '+92',
                onChanged: (country) {
                  setState(
                    () {
                      dialCodeDigits = country!.dialCode!;
                    },
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Card(
                      child: Center(
                        child: Text(
                          dialCodeDigits,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    width: 250,
                    height: 50,
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OTPCodeScreen(
                        phone: _controller.text,
                        codeDigits: dialCodeDigits,
                      ),
                    ),
                  );
                },
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
