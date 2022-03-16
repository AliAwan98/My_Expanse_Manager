// ignore_for_file: must_be_immutable, prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'package:expense_manager/Models/contact_model.dart';
import 'package:expense_manager/Models/message_model.dart';
import 'package:flutter/material.dart';

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
        elevation: 0.0,
        title: Text(
          "Add Expenses",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 38.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Location :",
              style: TextStyle(
                fontSize: 22,
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
                    hintText: "Location",
                    border: OutlineInputBorder(),
                  ),
                  controller: amount,
                ),
              ),
            ),
            Text(
              "Amount :",
              style: TextStyle(
                fontSize: 22,
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
                    hintText: "Total Amount",
                    border: OutlineInputBorder(),
                  ),
                  controller: amount,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 100,
        child: FloatingActionButton(
          elevation: 0.0,
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
