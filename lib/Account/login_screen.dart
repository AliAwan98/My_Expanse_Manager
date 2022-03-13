// ignore_for_file: prefer_const_constructors, unnecessary_const

import 'package:country_code_picker/country_code_picker.dart';
import 'package:expense_manager/Account/otp_screen.dart';
import 'package:flutter/material.dart';

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
            Padding(
              padding: const EdgeInsets.only(
                left: 28,
                right: 28,
              ),
              child: Image.asset(
                "images/login.jpg",
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20,
              ),
              child: Center(
                child: Text(
                  "Phone (OTP) Authentication",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 400,
              height: 60,
              child: CountryCodePicker(
                onChanged: (country) {
                  setState(
                    () {
                      dialCodeDigits = country.dialCode!;
                    },
                  );
                },
                initialSelection: "Pakistan",
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10,
              ),
              child:
                  // TextField(
                  //   decoration: InputDecoration(
                  //     hintText: "Phone Number",
                  //     prefix: Padding(
                  //       padding: EdgeInsets.all(4),
                  //       child: Text(
                  //         dialCodeDigits,
                  //       ),
                  //     ),
                  //   ),
                  //   maxLength: 12,
                  //   keyboardType: TextInputType.number,
                  //   controller: _controller,
                  // ),
                  TextField(
                keyboardType: TextInputType.phone,
                controller: _controller,
                maxLength: 11,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30),
                      ),
                    ),
                    filled: true,
                    prefixIcon: Icon(
                      Icons.phone_iphone,
                      color: Colors.cyan,
                    ),
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Enter Your Phone Number...",
                    fillColor: Colors.white70),
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
