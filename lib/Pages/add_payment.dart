// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, unused_import, avoid_print, unrelated_type_equality_checks

import 'package:expense_manager/Custom%20UIs/contact_card.dart';
import 'package:expense_manager/Custom%20UIs/pay_cont.dart';

import 'package:expense_manager/Models/contact_model.dart';
import 'package:expense_manager/Models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddPayment extends StatefulWidget {
  AddPayment({Key? key, required this.contacts, s}) : super(key: key);
  List<CustomContacts> contacts;

  @override
  State<AddPayment> createState() => _AddPaymentState();
}

class _AddPaymentState extends State<AddPayment> {
  TextEditingController amount = TextEditingController();
  bool select = false;
  int? selectedIndex;
  String name = "";
  List<PaymentContacts> paymentContacts = [];
  @override
  void initState() {
    _populatePayCont(widget.contacts);
    super.initState();
  }

  void _populatePayCont(Iterable<CustomContacts> contacts) {
    widget.contacts = contacts
        .where((element) => element.contacts.displayName != null)
        .toList();
    widget.contacts.sort(((a, b) =>
        a.contacts.displayName!.compareTo(b.contacts.displayName.toString())));
    paymentContacts =
        widget.contacts.map((e) => PaymentContacts(payCont: e)).toList();
    setState(() {
      paymentContacts;
      print(paymentContacts);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Payments",
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 135,
              ),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  selectedIndex == index ? select = true : select = false;
                  return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          name = paymentContacts[index]
                              .payCont
                              .contacts
                              .displayName
                              .toString();
                        });
                      },
                      child: PayCont(
                        contact: paymentContacts[index],
                        select: select,
                      ));
                },
                itemCount: paymentContacts.length,
              ),
            ),
            Container(
              height: 130,
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        "To:",
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
            setState(() {
              Navigator.pop(
                context,
                MessageModel(name, "", amount.text),
              );
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.payments_rounded,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Pay",
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
