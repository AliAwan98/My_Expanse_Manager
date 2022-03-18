// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:expense_manager/Pages/my_chats.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OTPCodeScreen extends StatefulWidget {
  const OTPCodeScreen({
    Key? key,
    required this.phone,
    required this.codeDigits,
  }) : super(key: key);
  final String phone;
  final String codeDigits;
  @override
  State<OTPCodeScreen> createState() => _OTPCodeScreenState();
}

class _OTPCodeScreenState extends State<OTPCodeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinOTPCodeController = TextEditingController();
  final FocusNode _pinOTPCodeFocus = FocusNode();
  String? verificationCode;
  bool start = false;
  @override
  void initState() {
    super.initState();
    verifyPhoneNumber();
  }

  verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "${widget.codeDigits + widget.phone}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential).then(
          (value) {
            if (value.user != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyChats(),
                ),
              );
            }
          },
        );
      },
      verificationFailed: (FirebaseException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.message.toString(),
            ),
            duration: Duration(
              seconds: 3,
            ),
          ),
        );
      },
      codeSent: (String vID, int? resendToken) {
        setState(
          () {
            verificationCode = vID;
          },
        );
      },
      codeAutoRetrievalTimeout: (String vID) {
        setState(
          () {
            verificationCode = vID;
          },
        );
      },
      timeout: Duration(
        seconds: 60,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "OTP Verification",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "images/otp.png",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                    ),
                  ),
                  Text(
                    "Enter 6 digit OTP",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   child: Center(
            //     child: GestureDetector(
            //       onTap: () {
            //         verifyPhoneNumber();
            //       },
            //       child: Text(
            //         "Enter your 6 digit OTP",
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.all(40),
              child: Pinput(
                length: 6,
                autofocus: true,
                focusNode: _pinOTPCodeFocus,
                controller: _pinOTPCodeController,
                onSubmitted: (pin) async {
                  start = true;

                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(
                      PhoneAuthProvider.credential(
                        verificationId: verificationCode!,
                        smsCode: pin,
                      ),
                    )
                        .then(
                      (value) {
                        if (value.user != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MyChats(),
                            ),
                          );
                        }
                      },
                    );
                  } catch (e) {
                    FocusScope.of(context).unfocus();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Invalid OTP",
                        ),
                        duration: Duration(
                          seconds: 3,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 50,
              width: 50,
              child: Center(
                child: start ? CircularProgressIndicator() : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
