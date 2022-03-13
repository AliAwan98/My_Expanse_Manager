import 'package:expense_manager/Models/contact_model.dart';
import 'package:expense_manager/Models/message_model.dart';

class GroupModel {
  final String name;
  final String icon = "images/groups.svg";
  List<CustomContacts> selectedContacts = [];
  List<MessageModel> myMessages = [];
  GroupModel({
    required this.name,
    required this.selectedContacts,
    required this.myMessages,
  });
  static List<GroupModel> myGroups = [
    GroupModel(
      name: "Family",
      selectedContacts: [],
      myMessages: [],
    )
  ];
}
