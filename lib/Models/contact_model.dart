import 'package:contacts_service/contacts_service.dart';

class CustomContacts {
  final Contact contacts;
  bool select;

  CustomContacts({
    required this.contacts,
    this.select = false,
  });
}

class PaymentContacts {
  final CustomContacts payCont;
  bool select;
  PaymentContacts({
    required this.payCont,
    this.select = false,
  });
}
