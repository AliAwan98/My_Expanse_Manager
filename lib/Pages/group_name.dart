// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_print

import 'package:expense_manager/Custom%20UIs/participant_card.dart';
import 'package:expense_manager/Models/contact_model.dart';
import 'package:expense_manager/Models/group_model.dart';

import 'package:expense_manager/Pages/my_chats.dart';

import 'package:flutter/material.dart';

class AddGroupName extends StatefulWidget {
  AddGroupName({
    Key? key,
    required this.groupsContacts,
  }) : super(key: key);
  List<CustomContacts> groupsContacts;

  @override
  State<AddGroupName> createState() => _AddGroupNameState();
}

class _AddGroupNameState extends State<AddGroupName> {
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New group",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Add subject",
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 110,
              // color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blueGrey[200],
                          radius: 25,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 160,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              autofocus: true,
                              controller: name,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(),
                                hintText: "Type group subject here...",
                                isDense: true,
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.emoji_emotions_outlined,
                            color: Colors.blueGrey[300],
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    "Provide a group subject and optional group icon",
                    style: TextStyle(
                      color: Colors.blueGrey[400],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 120.0,
              left: 30,
            ),
            child: Text(
              "Partcipants:",
              style: TextStyle(
                color: Colors.blueGrey[500],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 150,
            ),
            child: Container(
              alignment: Alignment.center,
              // color: Colors.white,
              child: GridView.builder(
                scrollDirection: Axis.vertical,

                itemBuilder: (context, index) {
                  return ParticipantCard(
                    contact: widget.groupsContacts[index],
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  // vertical spacing between the items
                  mainAxisSpacing: 5,
                  // horizontal spacing between the items
                  // crossAxisSpacing: 10,
                ),
                // number of items in your list
                itemCount: widget.groupsContacts.length,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 148,
            ),
            child: Divider(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        child: Icon(
          Icons.check,
        ),
        onPressed: () {
          name.text.isNotEmpty
              ? {
                  setState(() {
                    GroupModel.myGroups.add(
                      GroupModel(
                        name: name.text,
                        selectedContacts: widget.groupsContacts,
                        myMessages: [],
                      ),
                    );
                  }),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => MyChats(),
                    ),
                  )
                }
              : showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(
                      'Error',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    ),
                    content: Text(
                      'Please enter Group name',
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text(
                          'OK',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
