// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

class OwnMessageCard extends StatelessWidget {
  OwnMessageCard({
    Key? key,
    required this.message,
    required this.amount,
    required this.location,
    required this.currentTime,
  }) : super(key: key);
  final String message;
  final String amount;
  final String location;

  dynamic currentTime;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          // color: Color(0xffdcf8c6),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 30,
                  top: 5,
                  bottom: 20,
                ),
                child: location.isEmpty
                    ? Text(
                        "You paid Rs.$amount to $message.",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    : Text(
                        message.isNotEmpty
                            ? "You paid Rs.$amount at $location.\n( Excluding: $message )"
                            : "You paid Rs.$amount at $location.",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      "$currentTime",
                      style: TextStyle(
                        fontSize: 13,
                        // color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.done_all,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
