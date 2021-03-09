
import 'package:contact_book/common/constants/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact.g.dart';

@JsonSerializable()
class ContactModel extends Object with _$ContactSerializerMixin {
  String id;
  String name;
  String primaryPhone;
  String secondaryPhone;
  String primaryEmail;
  String secondaryEmail;
  String contactImage;
  String address;

  ContactModel(
      {this.id,
      this.name,
      this.primaryPhone,
      this.secondaryPhone,
      this.primaryEmail,
      this.secondaryEmail,
      this.contactImage,
      this.address,});

  static Future<List<ContactModel>> fromContactJson(List<dynamic> json) async {
    List<ContactModel> contactList = new List<ContactModel>();
    for (var contact in json) {
      contactList.add(new ContactModel(
        id: contact['_id'],
        name: contact['name'],
        primaryPhone: contact['primaryPhone'],
        secondaryPhone: contact['secondaryPhone'],
        primaryEmail: contact['primaryEmail'],
        secondaryEmail: contact['secondaryEmail'],
        contactImage: contact['contact_image'],
         address: contact['address'],
      ));
    }
    return contactList;
  }

  factory ContactModel.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);

  Map toMap() {
    Map<String, dynamic> contactMap = <String, dynamic>{
      ContactTable.NAME: name,
      ContactTable.PRIMARY_PHONE: primaryPhone,
      ContactTable.SECONDARY_PHONE: secondaryPhone,
      ContactTable.PRIMARY_EMAIL: primaryEmail,
      ContactTable.SECONDARY_EMAIL: secondaryEmail,
      ContactTable.CONTACT_IMAGE: contactImage,
      ContactTable.ADDRESS: address,
    };

    return contactMap;
  }

  static ContactModel fromMap(Map map) {
    return new ContactModel(
      id: map[ContactTable.ID].toString(),
      name: map[ContactTable.NAME],
      primaryPhone: map[ContactTable.PRIMARY_PHONE],
      secondaryPhone: map[ContactTable.SECONDARY_PHONE],
      primaryEmail: map[ContactTable.PRIMARY_EMAIL],
      secondaryEmail: map[ContactTable.SECONDARY_EMAIL],
      contactImage: map[ContactTable.CONTACT_IMAGE],
      address: map[ContactTable.ADDRESS],
    );
  }
}

// @JsonSerializable()
// class ContactModel extends ContactEntity {
//          String id;
//   final String name;
//   final String primaryPhone;
//   final String primaryEmail;
//   final String address;
//   final String secondaryPhone;
//   final String secondaryEmail;
//   final String contactImage;

//   ContactModel(
//       {this.id,
//       this.address,
//       this.contactImage,
//       this.name,
//       this.primaryEmail,
//       this.primaryPhone,
//       this.secondaryEmail,
//       this.secondaryPhone})
//       : super(
//             id: id,
//             name: name,
//             primaryEmail: primaryEmail,
//             secondaryEmail: secondaryEmail,
//             primaryPhone: primaryPhone,
//             secondaryPhone: secondaryPhone,
//             address: address,
//             contactImage: contactImage,);

//   factory ContactModel.fromJson(Map<String, dynamic> json) {
//     return ContactModel(
//       id: json['id'],
//       name: json['name'],
//       primaryPhone: json['primaryPhone'],
//       secondaryPhone: json['secondaryPhone'],
//       primaryEmail: json['primaryEmail'],
//       secondaryEmail: json['secondaryEmail'],
//       address: json['address'],
//       contactImage: json['contactImage'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['primaryPhone'] = this.primaryPhone;
//     data['secondaryPhone'] = this.secondaryPhone;
//     data['primaryEmail'] = this.primaryEmail;
//     data['secondaryEmail'] = this.secondaryEmail;
//     data['address'] = this.address;
//     data['contactImage'] = this.contactImage;
//     return data;
//   }
// }
