// ignore_for_file: prefer_const_constructors, avoid_print, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:expense_manager/Custom%20UIs/own_msg_card.dart';
import 'package:expense_manager/Models/group_model.dart';
import 'package:expense_manager/Models/message_model.dart';
import 'package:expense_manager/Pages/add_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IndividualChat extends StatefulWidget {
  const IndividualChat({
    Key? key,
    required this.groupModel,
  }) : super(key: key);
  final GroupModel groupModel;

  @override
  _IndividualChatState createState() => _IndividualChatState();
}

class _IndividualChatState extends State<IndividualChat> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController amount = TextEditingController();
  TextEditingController location = TextEditingController();
  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  void initState() {
    super.initState();
  }

  String? name;
  MessageModel? result;

  addPayment(BuildContext context) async {
    result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => AddPayment(
          contacts: widget.groupModel.selectedContacts,
        ),
      ),
    );
    setState(() {
      widget.groupModel.myMessages.add(result!);
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => _scrollToBottom());

    return Stack(
      children: [
        Image.asset(
          "images/backgroundImg.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              elevation: 0.0,
              leadingWidth: 70,
              titleSpacing: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                    CircleAvatar(
                      child: SvgPicture.asset(
                        widget.groupModel.icon,
                        color: Colors.white,
                        height: 36,
                        width: 36,
                      ),
                      radius: 20,
                      backgroundColor: Colors.blueGrey,
                    ),
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.groupModel.name,
                        style: TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "last seen today at 12:05",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
                IconButton(icon: Icon(Icons.call), onPressed: () {}),
                PopupMenuButton<String>(
                  padding: EdgeInsets.all(0),
                  onSelected: (value) {
                    print(value);
                  },
                  itemBuilder: (BuildContext contesxt) {
                    return [
                      PopupMenuItem(
                        child: Text("View Contact"),
                        value: "View Contact",
                      ),
                      PopupMenuItem(
                        child: Text("Media, links, and docs"),
                        value: "Media, links, and docs",
                      ),
                      PopupMenuItem(
                        child: Text("Whatsapp Web"),
                        value: "Whatsapp Web",
                      ),
                      PopupMenuItem(
                        child: Text("Search"),
                        value: "Search",
                      ),
                      PopupMenuItem(
                        child: Text("Mute Notification"),
                        value: "Mute Notification",
                      ),
                      PopupMenuItem(
                        child: Text("Wallpaper"),
                        value: "Wallpaper",
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                widget.groupModel.selectedContacts.isNotEmpty
                    ? Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 175,
                          color: Colors.grey[300],
                          child: ListView.builder(
                            itemBuilder: ((context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  child: SvgPicture.asset(
                                    "images/person.svg",
                                    color: Colors.white,
                                    height: 30,
                                    width: 30,
                                  ),
                                  backgroundColor: Colors.blueGrey[200],
                                ),
                                title: Text(widget
                                    .groupModel
                                    .selectedContacts[index]
                                    .contacts
                                    .displayName
                                    .toString()),
                              );
                            }),
                            itemCount:
                                widget.groupModel.selectedContacts.length,
                          ),
                        ),
                      )
                    : Container(),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemCount: widget.groupModel.myMessages.length + 1,
                    itemBuilder: (context, index) {
                      if (index == widget.groupModel.myMessages.length) {
                        return Container();
                      }

                      return OwnMessageCard(
                        message: widget.groupModel.myMessages[index].name,
                        amount: widget.groupModel.myMessages[index].amount,
                        location: widget.groupModel.myMessages[index].location,
                        currentTime:
                            widget.groupModel.myMessages[index].currentTime,
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                widget.groupModel.selectedContacts.isNotEmpty
                                    ? addPayment(context)
                                    : null;
                              },
                              child: Text(
                                "Add Payment",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  widget.groupModel.selectedContacts.isNotEmpty
                                      ? {
                                          amount.clear(),
                                          location.clear(),
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Location :",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    width: 250,
                                                    height: 50,
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Location",
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                      controller: location,
                                                      autofocus: true,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Amount :",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    width: 250,
                                                    height: 50,
                                                    child: TextField(
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Total Amount",
                                                          border:
                                                              OutlineInputBorder(),
                                                        ),
                                                        controller: amount,
                                                        keyboardType:
                                                            TextInputType
                                                                .phone),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Center(
                                                    child: ElevatedButton(
                                                      
                                                      onPressed: () {
                                                        setState(
                                                          () {
                                                            widget.groupModel
                                                                .myMessages
                                                                .add(
                                                              MessageModel(
                                                                "",
                                                                location.text,
                                                                amount.text,
                                                              ),
                                                            );

                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        );
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .add_shopping_cart_rounded,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "Add",
                                                            style: TextStyle(
                                                              fontSize: 25,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        }
                                      : null;
                                });
                              },
                              child: Text(
                                "Add Expenses",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
