// ignore_for_file: prefer_const_constructors, unnecessary_const, prefer_const_literals_to_create_immutables

import 'package:country_list_pick/country_list_pick.dart';
import 'package:expense_manager/Account/otp_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String dialCodeDigits = "+92";
  String countryName = "Pakistan";
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
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
            SizedBox(
              child: CountryListPick(
                appBar: AppBar(
                  title: Text('Pick your country'),
                ),
                // if you need custom picker use this
                pickerBuilder: (context, countryListPick) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          // color: Colors.black12,
                          ),
                    ),
                    width: 305,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          countryName,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          width: 160,
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                        ),
                      ],
                    ),
                  );
                },
                initialSelection: '+92',
                onChanged: (country) {
                  setState(
                    () {
                      dialCodeDigits = country!.dialCode!;
                      countryName = country.name!;
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: Center(
                    child: Text(
                      dialCodeDigits,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 250,
                  height: 50,
                  margin: EdgeInsets.only(
                    left: 10,
                  ),
                  child: Center(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Phone",
                        hintText: "Phone Number",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      controller: _controller,
                    ),
                  ),
                ),
              ],
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
