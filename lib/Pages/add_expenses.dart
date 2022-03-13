// ignore_for_file: must_be_immutable, prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'package:expense_manager/Custom%20UIs/participant_card.dart';
import 'package:expense_manager/Models/contact_model.dart';
import 'package:expense_manager/Models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddExpenses extends StatefulWidget {
  AddExpenses({Key? key, required this.contacts, s}) : super(key: key);
  List<CustomContacts> contacts;

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  TextEditingController amount = TextEditingController();
  TextEditingController location = TextEditingController();
  bool select = true;
  int? selectedIndex;
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Expenses",
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 210,
              ),
              child: GridView.builder(
                scrollDirection: Axis.vertical,

                itemBuilder: (context, index) {
                  return ParticipantCard(
                    contact: widget.contacts[index],
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
                itemCount: widget.contacts.length,
              ),
            ),
            Container(
              height: 205,
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Location:",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 150,
                      height: 50,
                      child: Card(
                        child: TextField(
                          autofocus: true,
                          controller: location,
                          decoration: InputDecoration(
                            hintText: "Description",
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(
                              top: 20,
                              left: 10,
                              right: 5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Amount:",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 150,
                      height: 50,
                      child: Card(
                        child: TextField(
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          controller: amount,
                          decoration: InputDecoration(
                            hintText: "Rs.",
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(
                              top: 20,
                              left: 10,
                              right: 5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 8,
                      ),
                      child: Text(
                        "Paid by:",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 100,
        child: FloatingActionButton(
          isExtended: true,
          onPressed: () {
            select
                ? {
                    Navigator.pop(
                      context,
                      MessageModel(
                        name,
                        location.text,
                        amount.text,
                      ),
                    )
                  }
                : null;
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_shopping_cart_rounded,
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
    );
  }
}
