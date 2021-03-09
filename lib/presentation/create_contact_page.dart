import 'dart:convert';
import 'dart:io';

import 'package:contact_book/common/constants/constants.dart';
import 'package:contact_book/data/models/base/event_object.dart';
import 'package:contact_book/data/models/contact.dart';
import 'package:contact_book/presentation/blocs/contact_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';

class CreateContactPage extends StatefulWidget {
  @override
  _CreateContactPageState createState() => _CreateContactPageState();
}

class _CreateContactPageState extends State<CreateContactPage> {
  static final globalKey = new GlobalKey<ScaffoldState>();

  ProgressDialog progressDialog =
      ProgressDialog.getProgressDialog("CREATING CONTACT", false);

  File _imageFile;

  TextEditingController nameController = new TextEditingController(text: "");

  TextEditingController primaryPhoneController =
      new TextEditingController(text: "");

  TextEditingController secondaryPhoneController =
      new TextEditingController(text: "");

  TextEditingController primaryEmailController =
      new TextEditingController(text: "");

  TextEditingController secondaryEmailController =
      new TextEditingController(text: "");

  TextEditingController addressController = new TextEditingController(text: "");

  Widget createContactWidget = new Container();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    createContactWidget = ListView(
      reverse: true,
      children: <Widget>[
        new Center(
          child: new Container(
            margin: EdgeInsets.only(left: 30.0, right: 30.0),
            child: new Column(
              children: <Widget>[
                _contactImageContainer(),
                _formContainer(),
              ],
            ),
          ),
        )
      ],
    );
    return new Scaffold(
      key: globalKey,
      appBar: new AppBar(
        centerTitle: true,
        leading: new GestureDetector(
          onTap: () {
            Navigator.pop(context, Events.USER_HAS_NOT_CREATED_ANY_CONTACT);
          },
          child: new Icon(
            Icons.arrow_back,
            size: 30.0,
          ),
        ),
        textTheme: new TextTheme(
            // ignore: deprecated_member_use
            title: new TextStyle(
          color: Colors.white,
          fontSize: 22.0,
        )),
        iconTheme: new IconThemeData(color: Colors.white),
        title: new Text(Texts.CREATE_CONTACT),
        actions: <Widget>[
          new GestureDetector(
            onTap: () {
              _validateCreateContactForm();
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: new Icon(
                Icons.done,
                size: 30.0,
              ),
            ),
          )
        ],
      ),
      body: new Stack(
        children: <Widget>[createContactWidget, progressDialog],
      ),
      backgroundColor: Colors.grey[150],
    );
  }

  Widget _contactImageContainer() {
    return new Container(
      height: 150.0,
      margin: EdgeInsets.only(top: 10.0),
      child: new Row(
        children: <Widget>[
          _pickFromGallery(),
          _imagePicked(),
        ],
      ),
    );
  }

  Widget _imagePicked() {
    return new Flexible(
      child: _imageFile == null
          ? new Text(
              Texts.YOU_HAVE_NOT_YET_PICKED_AN_IMAGE,
              style: new TextStyle(
                color: Colors.blueGrey[400],
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
            )
          : new Image.file(
              _imageFile,
              fit: BoxFit.cover,
            ),
      fit: FlexFit.tight,
      flex: 2,
    );
  }

  Widget _pickFromGallery() {
    return new Flexible(
      child: new GestureDetector(
        onTap: () {
          _pickImage(ImageSource.gallery);
        },
        child: new Container(
          height: 60.0,
          width: 60.0,
          decoration: new BoxDecoration(
              shape: BoxShape.circle, color: Colors.blue[400]),
          child: new Icon(
            Icons.photo_library,
            size: 35.0,
            color: Colors.white,
          ),
        ),
      ),
      fit: FlexFit.tight,
      flex: 1,
    );
  }

  void _pickImage(ImageSource source) async {
    // ignore: deprecated_member_use
    File imageFile =
        await ImagePicker.pickImage(source: source, imageQuality: 50);
    setState(() {
      _imageFile = imageFile;
    });
  }

  Widget _formContainer() {
    return new Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
      child: new Form(
          child: new Theme(
              data: new ThemeData(primarySwatch: Colors.blue),
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _formField(nameController, Icons.face, Texts.NAME,
                      TextInputType.text),
                  _formField(primaryPhoneController, Icons.phone, Texts.PRIMARY_PHONE,
                      TextInputType.phone),
                  _formField(secondaryPhoneController, Icons.phone, Texts.SECONARY_PHONE,
                      TextInputType.phone),
                  _formField(primaryEmailController, Icons.email, Texts.PRIMARY_EMAIL,
                      TextInputType.emailAddress),
                  _formField(secondaryEmailController, Icons.email, Texts.SECONDARY_EMAIL,
                      TextInputType.emailAddress),
                  _formField(addressController, Icons.location_on,
                      Texts.ADDRESS, TextInputType.text),
                ],
              ))),
    );
  }

  Widget _formField(TextEditingController textEditingController, IconData icon,
      String text, TextInputType textInputType) {
    return new Container(
        child: new TextFormField(
          controller: textEditingController,
          decoration: InputDecoration(
              suffixIcon: new Icon(
                icon,
                color: Colors.blue[400],
              ),
              labelText: text,
              labelStyle: TextStyle(fontSize: 18.0)),
          keyboardType: textInputType,
        ),
        margin: EdgeInsets.only(bottom: 10.0));
  }

  void _validateCreateContactForm() {
    if (_imageFile == null) {
      showSnackBar(SnackBarText.PLEASE_PICK_AN_IMAGE_FROM_GALLERY);
      return;
    }

    String name = nameController.text;
    if (name.length < 3 || name.length > 20) {
      showSnackBar(SnackBarText.PLEASE_FILL_VALID_NAME);
      return;
    }

    String primaryPhone = primaryPhoneController.text;
    if (!isValidPhone(primaryPhone)) {
      showSnackBar(SnackBarText.PLEASE_FILL_VALID_PHONE_NO);
      return;
    }

    String secondaryPhone = secondaryPhoneController.text;
    if (!isValidPhone(secondaryPhone)) {
      showSnackBar(SnackBarText.PLEASE_FILL_VALID_PHONE_NO);
      return;
    }

    if (primaryPhone.length < 6 || primaryPhone.length > 11) {
      showSnackBar(SnackBarText.PLEASE_FILL_PHONE_NO);
      return;
    }

    if (secondaryPhone.length < 6 || secondaryPhone.length > 11) {
      showSnackBar(SnackBarText.PLEASE_FILL_PHONE_NO);
      return;
    }

    String primaryEmail = primaryEmailController.text;
    if (!isValidEmail(primaryEmail)) {
      showSnackBar(SnackBarText.PLEASE_FILL_VALID_EMAIL_ADDRESS);
      return;
    }

    String secondaryEmail = secondaryEmailController.text;
    if (!isValidEmail(secondaryEmail)) {
      showSnackBar(SnackBarText.PLEASE_FILL_VALID_EMAIL_ADDRESS);
      return;
    }

    String address = addressController.text;
    if (address.length < 3 || address.length > 1000) {
      showSnackBar(SnackBarText.PLEASE_FILL_ADDRESS);
      return;
    }

    FocusScope.of(context).requestFocus(new FocusNode());
    ContactModel contactToBeCreated = new ContactModel(
        id: "",
        name: nameController.text,
        primaryPhone: primaryPhoneController.text,
        secondaryPhone: secondaryPhoneController.text,
        primaryEmail: primaryEmailController.text,
        secondaryEmail: secondaryEmailController.text,
        address: addressController.text,
        contactImage: base64Encode(_imageFile.readAsBytesSync()));

    progressDialog.show();
    createContact(contactToBeCreated);
  }

  void createContact(ContactModel contactToBeCreated) async {
    print("fuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuk");
    print(contactToBeCreated);
    EventObject contactObject = await saveContact(contactToBeCreated);
    if (this.mounted) {
      setState(() {
        progressDialog.hide();
        switch (contactObject.id) {
          case Events.CONTACT_WAS_CREATED_SUCCESSFULLY:
            Navigator.pop(context, Events.CONTACT_WAS_CREATED_SUCCESSFULLY);
            break;
          case Events.UNABLE_TO_CREATE_CONTACT:
            Navigator.pop(context, Events.UNABLE_TO_CREATE_CONTACT);
            break;
        }
      });
    }
  }

  void showSnackBar(String textToBeShown) {
    globalKey.currentState.showSnackBar(new SnackBar(
      content: new Text(textToBeShown),
    ));
  }
}
