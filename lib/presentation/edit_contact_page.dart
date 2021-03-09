 

import 'dart:convert';
import 'dart:io';

import 'package:contact_book/common/constants/constants.dart';
import 'package:contact_book/data/models/base/event_object.dart';
import 'package:contact_book/data/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';

import 'blocs/contact_blocs.dart';

class EditContactPage extends StatefulWidget {
  ContactModel contact;

  EditContactPage(this.contact);

  @override
  createState() => new EditContactPageState(contact);
}

class EditContactPageState extends State<EditContactPage> {
  static final globalKey = new GlobalKey<ScaffoldState>();

  ProgressDialog progressDialog = ProgressDialog.getProgressDialog(
      ProgressDialogTitles.EDITING_CONTACT, false);

  ContactModel contact;

  File _imageFile;

  TextEditingController nameController;

  TextEditingController primaryPhoneController;

  TextEditingController secondaryPhoneController;

  TextEditingController primaryEmailController;

  TextEditingController secondaryEmailController;

  TextEditingController addressController;


  Widget editContactWidget = new Container();

  String contactImage;
  int validCount = 0;

  EditContactPageState(this.contact);

  @override
  void initState() {
    contactImage = contact.contactImage;
    nameController = new TextEditingController(text: contact.name + "");
    primaryPhoneController = new TextEditingController(text: contact.primaryPhone + "");
    secondaryPhoneController = new TextEditingController(text: contact.secondaryPhone + "");
    primaryEmailController= new TextEditingController(text: contact.primaryEmail + "");
    secondaryEmailController= new TextEditingController(text: contact.secondaryEmail + "");
    addressController = new TextEditingController(text: contact.address + "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    editContactWidget = ListView(
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
            Navigator.pop(context, Events.USER_HAS_NOT_PERFORMED_UPDATE_ACTION);
          },
          child: new Icon(
            Icons.arrow_back,
            size: 30.0,
          ),
        ),
        textTheme: new TextTheme(
            title: new TextStyle(
          color: Colors.white,
          fontSize: 22.0,
        )),
        iconTheme: new IconThemeData(color: Colors.white),
        title: new Text(Texts.EDIT_CONTACT),
        actions: <Widget>[
          new GestureDetector(
            onTap: () {
              _validateEditContactForm();
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
        children: <Widget>[editContactWidget, progressDialog],
      ),
      backgroundColor: Colors.grey[150],
    );
  }

  void _pickImage(ImageSource source) async {
    setState(() {
      ++validCount;
      contactImage = null;
    });
    var imageFile = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = imageFile;
    });
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

  Widget _imagePicked() {
    return new Flexible(
      child: _imageFile == null
          ? (contactImage != null
              ? new Image.memory(base64Decode(contactImage))
              : new Text(
                  Texts.YOU_HAVE_NOT_YET_PICKED_AN_IMAGE,
                  style: new TextStyle(
                    color: Colors.blueGrey[400],
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ))
          : new Image.file(
              _imageFile,
              fit: BoxFit.cover,
            ),
      fit: FlexFit.tight,
      flex: 2,
    );
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
                  TextInputType.phone),
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

  void _validateEditContactForm() {
    if (_imageFile == null && validCount > 0) {
      showSnackBar(
          SnackBarText.PLEASE_PICK_AN_IMAGE_FROM_GALLERY);
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

    if (primaryPhone.length < 6 || primaryPhone.length > 20) {
      showSnackBar(SnackBarText.PLEASE_FILL_PHONE_NO);
      return;
    }

  String secondaryPhone = secondaryPhoneController.text;
    if (!isValidPhone(secondaryPhone)) {
      showSnackBar(SnackBarText.PLEASE_FILL_VALID_PHONE_NO);
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
    ContactModel contactToBeEdited = new ContactModel();
    contactToBeEdited.id = contact.id;
    contactToBeEdited.name = nameController.text;
    contactToBeEdited.primaryPhone = primaryPhoneController.text;
     contactToBeEdited.secondaryPhone = secondaryPhoneController.text;
    contactToBeEdited.primaryEmail = primaryEmailController.text;
    contactToBeEdited.secondaryEmail = secondaryEmailController.text;
    contactToBeEdited.address = addressController.text;
 
    if (validCount == 0) {
      contactToBeEdited.contactImage = contactImage;
    } else {
      List<int> contactImageBytes = _imageFile.readAsBytesSync();
      contactToBeEdited.contactImage = base64Encode(contactImageBytes);
    }
    progressDialog.show();
    editContact(contactToBeEdited);
  }

  void editContact(ContactModel contactToBeEdited) async {
    EventObject contactObject = await updateContact(contactToBeEdited);
        if (this.mounted) {
          setState(() {
            progressDialog.hide();
            switch (contactObject.id) {
              case Events.CONTACT_WAS_UPDATED_SUCCESSFULLY:
                Navigator.pop(context, Events.CONTACT_WAS_UPDATED_SUCCESSFULLY);
                break;
              case Events.UNABLE_TO_UPDATE_CONTACT:
                Navigator.pop(context, Events.UNABLE_TO_UPDATE_CONTACT);
                break;
              case Events.NO_CONTACT_WITH_PROVIDED_ID_EXIST_IN_DATABASE:
                Navigator.pop(
                    context, Events.NO_CONTACT_WITH_PROVIDED_ID_EXIST_IN_DATABASE);
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
    
