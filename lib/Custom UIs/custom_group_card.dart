// ignore_for_file: prefer_const_constructors

import 'package:expense_manager/Models/group_model.dart';
import 'package:expense_manager/Screens/individual_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomGroupCard extends StatelessWidget {
  const CustomGroupCard({
    Key? key,
    required this.groupModel,
  }) : super(key: key);
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contex) => IndividualChat(
                groupModel: groupModel,
              ),
            ),
          );
        },
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: SvgPicture.asset(
                  groupModel.icon,
                  color: Colors.white,
                  height: 36,
                  width: 36,
                ),
                backgroundColor: Colors.blueGrey,
              ),
              title: Text(
                groupModel.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 80),
              child: Divider(
                thickness: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
