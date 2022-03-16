// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, file_names

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import 'package:expense_manager/Custom%20UIs/avtar_card.dart';
import 'package:expense_manager/Custom%20UIs/contact_card.dart';
import 'package:expense_manager/Models/contact_model.dart';
import 'package:expense_manager/Pages/group_name.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> _contacts = [];
  List<CustomContacts> myContacts = [];
  List<CustomContacts> filteredContacts = [];
  List<CustomContacts> groupMembers = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllContacts();
    searchController.addListener(() {
      filterContacts();
    });
  }

  getAllContacts() async {
    List<Contact> _contactsAccess = await ContactsService.getContacts(
      withThumbnails: false,
    );
    _populateContacts(_contactsAccess);
  }

  void _populateContacts(Iterable<Contact> contacts) {
    _contacts = contacts.where((item) => item.displayName != null).toList();
    _contacts.sort(
      (a, b) => a.displayName!.compareTo(
        b.displayName.toString(),
      ),
    );
    myContacts = _contacts
        .map(
          (contacts) => CustomContacts(contacts: contacts),
        )
        .toList();
    setState(() {
      myContacts;
    });
  }

  filterContacts() {
    List<CustomContacts> _contacts = [];
    _contacts.addAll(myContacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String contactName = contact.contacts.displayName!.toLowerCase();
        return contactName.contains(searchTerm);
      });
      setState(() {
        filteredContacts = _contacts;
      });
    }
  }

  bool searchBtn = false;

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            setState(() {
              searchBtn ? searchBtn = false : Navigator.pop(context);
              searchController.clear();
            });
          },
          icon: Icon(
            Icons.arrow_back,
            color: searchBtn ? Colors.blueGrey : Colors.white,
          ),
        ),
        backgroundColor: searchBtn ? Colors.white : Color(0xFF128C7E),
        title: !searchBtn
            ? Column(
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
                    "Add participants",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              )
            : TextField(
                controller: searchController,
                autofocus: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search...",
                  hintStyle: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
        actions: [
          searchBtn
              ? Container()
              : IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 26,
                  ),
                  onPressed: () {
                    setState(() {
                      searchBtn = !searchBtn;
                    });
                  },
                ),
        ],
      ),
      body: Stack(
        children: [
          groupMembers.isNotEmpty
              ? Column(
                  children: [
                    Container(
                      height: 75,
                      color: Colors.white,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          CustomContacts gcontact = groupMembers[index];
                          return InkWell(
                            onTap: () {
                              setState(() {
                                gcontact.select = !gcontact.select;
                                if (gcontact.select == false) {
                                  groupMembers.remove(gcontact);
                                }
                              });
                            },
                            child: AvtarCard(
                              contact: gcontact,
                            ),
                          );
                        },
                        itemCount: groupMembers.length,
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                  ],
                )
              : Container(),
          Padding(
            padding: groupMembers.isNotEmpty
                ? const EdgeInsets.only(top: 85)
                : const EdgeInsets.only(top: 0),
            child: ListView.builder(
              itemBuilder: (context, index) {
                CustomContacts contact =
                    isSearching ? filteredContacts[index] : myContacts[index];

                return InkWell(
                  onTap: () {
                    setState(
                      () {
                        contact.select = !contact.select;
                        contact.select
                            ? {
                                groupMembers.add(contact),
                              }
                            : groupMembers.remove(contact);
                      },
                    );
                  },
                  child: ContactCard(
                    contact: contact,
                  ),
                );
              },
              itemCount:
                  isSearching ? filteredContacts.length : myContacts.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        child: Icon(
          Icons.arrow_forward,
          size: 30,
        ),
        onPressed: () {
          groupMembers.isNotEmpty
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => AddGroupName(
                      groupsContacts: groupMembers,
                    ),
                  ),
                )
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
                      'Please Select at least 1 contact',
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
