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
      // timeout: Duration(
      //   seconds: 60,
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "OTP Verification",
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "images/otp.png",
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 20,
            ),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  verifyPhoneNumber();
                },
                child: Text(
                  "Verifying : ${widget.codeDigits}-${widget.phone}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(40),
            child: Pinput(
              length: 6,
              focusNode: _pinOTPCodeFocus,
              controller: _pinOTPCodeController,
              onSubmitted: (pin) async {
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
        ],
      ),
    );
  }
}
