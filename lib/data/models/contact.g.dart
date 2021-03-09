part of 'contact.dart';

ContactModel _$ContactFromJson(Map<String, dynamic> json) => new ContactModel(
    id: json['_id'] as String,
    name: json['name'] as String,
    primaryPhone: json['primaryPhone'] as String,
    secondaryPhone: json['secondaryPhone'] as String,
    primaryEmail: json['primaryEmail'] as String,
    secondaryEmail: json['secondaryEmail'] as String,
    contactImage: json['contact_image'] as String,
    address: json['address'] as String);
    

abstract class _$ContactSerializerMixin {
  String get id;

  String get name;

  String get primaryPhone;

  String get secondaryPhone;

  String get primaryEmail;

  String get secondaryEmail;

  String get contactImage;

  String get address;

  Map<String, dynamic> toJson() => <String, dynamic>{
        '_id': id,
        'name': name,
        'primaryPhone': primaryPhone,
        'secondaryPhone': secondaryPhone,
        'primaryEmail': primaryEmail,
        'secondaryEmail': secondaryEmail,
        'contact_image': contactImage,
        'address': address
      };
}