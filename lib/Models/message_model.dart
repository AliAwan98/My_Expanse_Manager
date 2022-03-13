import 'package:intl/intl.dart';

class MessageModel {
  final String name;
  final String amount;
  final String location;
  dynamic currentTime = DateFormat.jm().format(DateTime.now());

  MessageModel(
    this.name,
    this.location,
    this.amount,
  );
}
