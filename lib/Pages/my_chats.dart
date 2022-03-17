// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:expense_manager/Account/login_screen.dart';
import 'package:expense_manager/Custom%20UIs/custom_group_card.dart';
import 'package:expense_manager/Models/group_model.dart';
import 'package:expense_manager/Screens/Contacts_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MyChats extends StatefulWidget {
  const MyChats({Key? key}) : super(key: key);

  @override
  State<MyChats> createState() => _MyChatsState();
}

class _MyChatsState extends State<MyChats> {
  List<GroupModel> filteredGroups = [];
  TextEditingController searchController = TextEditingController();
  bool searchBtn = false;
  

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      filterGroups();
    });
   
  }



  filterGroups() {
    List<GroupModel> _groups = [];
    _groups.addAll(GroupModel.myGroups);
    if (searchController.text.isNotEmpty) {
      _groups.retainWhere((group) {
        String searchTerm = searchController.text.toLowerCase();
        String groupName = group.name.toLowerCase();
        return groupName.contains(searchTerm);
      });
      setState(() {
        filteredGroups = _groups;
      });
    }
  }

  _deleteGroup(String name, index) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Delete Group',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        content: Text(
          'Delete my $name Group',
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancell'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              'DELETE',
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              setState(() {
                GroupModel.myGroups.removeAt(index);
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: searchBtn
            ? IconButton(
                onPressed: () {
                  if (searchBtn) {
                    setState(() {
                      searchBtn = false;
                      searchController.clear();
                    });
                  }
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: searchBtn ? Colors.blueGrey : Colors.white,
                ),
              )
            : null,
        // backgroundColor: searchBtn ? Colors.white : Color(0xFF128C7E),
        title: !searchBtn
            ? Text("My Groups")
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
                    setState(
                      () {
                        searchBtn = !searchBtn;
                      },
                    );
                  },
                ),
          searchBtn
              ? Container()
              : PopupMenuButton<int>(
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                      value: 1,
                      child: Text(
                        "Settings",
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 2,
                      child: Text(
                        "Privacy Policy page",
                      ),
                    ),
                    PopupMenuDivider(),
                    PopupMenuItem<int>(
                      value: 3,
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text("Logout")
                        ],
                      ),
                    ),
                  ],
                  onSelected: (item) => SelectedItem(
                    context,
                    item,
                  ),
                )
        ],
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) {
          GroupModel myGroup =
              isSearching ? filteredGroups[index] : GroupModel.myGroups[index];
          return InkWell(
            onLongPress: () {
              _deleteGroup(myGroup.name, index);
            },
            child: CustomGroupCard(
              groupModel: myGroup,
            ),
          );
        }),
        itemCount:
            isSearching ? filteredGroups.length : GroupModel.myGroups.length,
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        onPressed: () async {
          final PermissionStatus permissionStatus = await _getPermission();
          if (permissionStatus == PermissionStatus.granted) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ContactsPage()));
          }
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  //Check contacts permission
  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.granted;
    } else {
      return permission;
    }
  }

  void SelectedItem(BuildContext context, item) {
    switch (item) {
      case 3:
        FirebaseAuth.instance.signOut();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (c) => LoginScreen()));
        break;
    }
  }
}
