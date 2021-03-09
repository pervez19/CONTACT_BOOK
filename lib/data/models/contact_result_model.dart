import 'package:contact_book/data/models/contact.dart';

class ContactsResultModel {
  List<ContactModel> contacts;

  ContactsResultModel({this.contacts});

  ContactsResultModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      contacts = new List<ContactModel>();
      json['results'].forEach((v) {
        contacts.add(ContactModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contacts != null) {
      data['results'] = this.contacts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}