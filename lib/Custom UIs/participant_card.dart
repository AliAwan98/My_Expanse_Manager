// ignore_for_file: prefer_const_constructors

import 'package:expense_manager/Models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ParticipantCard extends StatelessWidget {
  const ParticipantCard({Key? key, required this.contact}) : super(key: key);
  final CustomContacts contact;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 8,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 23,
                child: SvgPicture.asset(
                  "images/person.svg",
                  color: Colors.white,
                  height: 30,
                  width: 30,
                ),
                backgroundColor: Colors.blueGrey[200],
              ),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            contact.contacts.displayName.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
