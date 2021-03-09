import 'package:flutter/material.dart';

class ContactTable {
  static String TABLE_NAME = "Contact";
  static String ID = "_id";
  static String NAME = "name";
  static String PRIMARY_PHONE = "primaryPhone";
  static String PRIMARY_EMAIL = "primaryEmail";
  static String ADDRESS = "address";
  static String SECONDARY_PHONE = "secondaryPhone";
  static String SECONDARY_EMAIL = "secondaryEmail";
  static String CONTACT_IMAGE = "contact_image";
}

class SharedPreferenceKeys {
  static const String AUTO_INCREMENT = "Auto Increment";
  static const String CONTACTS = "Contacts";
  static const String DELETED_CONTACTS = "Deleted Contacts";
}

class Events {
  static const int READ_CONTACTS_SUCCESSFUL = 500;
  static const int NO_CONTACTS_FOUND = 501;

  static const int CONTACT_WAS_CREATED_SUCCESSFULLY = 506;
  static const int UNABLE_TO_CREATE_CONTACT = 507;
  static const int USER_HAS_NOT_CREATED_ANY_CONTACT = 508;

  static const int CONTACT_WAS_DELETED_SUCCESSFULLY = 509;
  static const int PLEASE_PROVIDE_THE_ID_OF_THE_CONTACT_TO_BE_DELETED = 510;
  static const int NO_CONTACT_WITH_PROVIDED_ID_EXIST_IN_DATABASE = 511;
  static const int UNABLE_TO_DELETE_CONTACT = 512;

  static const int CONTACT_WAS_UPDATED_SUCCESSFULLY = 513;
  static const int UNABLE_TO_UPDATE_CONTACT = 514;
  static const int USER_HAS_NOT_PERFORMED_UPDATE_ACTION = 515;

  static const int SEARCH_CONTACTS_SUCCESSFUL = 516;
  static const int NO_CONTACT_FOUND_FOR_YOUR_SEARCH_QUERY = 517;
}

class DrawerTitles {
  static const String TAPPED_ON_HEADER = "Tapped On Header";
  static const String CONTACTS = "Contacts";
  static const String CREATE_CONTACT = "Create Contact";
  static const String DELETED_CONTACTS = "Deleted Contacts";
  static const String SEARCH_CONTACTS = "Search Contacts";
  static const String GO_BACK = "Go Back";
}

class Texts {
  static const String APP_NAME = "Contacts";
  static const String DELETE_CONTACT = "Delete Contact";
  static const String EDIT_CONTACT = "Edit Contact";
  static const String CONTACT_DETAILS = "Contact Details";
  static const String CREATE_CONTACT = "Create Contact";
  static const String NO_CONTACTS = "No Contacts";
  static const String NO_DELETED_CONTACTS = "No Deleted Contacts";
  static const String ERROR_PICKING_IMAGE = "Error picking image.";
  static const String PICK_IMAGE_FROM_GALLERY = "Pick Image from gallery";
  static const String TAKE_A_PHOTO = "Take a Photo";
  static const String SAVE_CONTACT = "Save Contact";
  static const String NAME = "Name";
  static const String PRIMARY_PHONE = "Primary Phone";
  static const String PRIMARY_EMAIL = "Primary Email";
  static const String SECONARY_PHONE = "Secondary Phone";
  static const String SECONDARY_EMAIL = "Secondary Email";
  static const String ADDRESS = "Address";
  static const String TYPE_SOMETHING_HERE = "Type Something here";
  static const YOU_HAVE_NOT_YET_PICKED_AN_IMAGE =
      "You have not yet picked an image.";
}

class SnackBarText {
  static const String CONTACTS_LOADED_SUCCESSFULLY =
      "Contacts Loaded Successfully";
  static const String NO_CONTACTS_FOUND = "No Contacts Found";

  static const String CONTACTS_SEARCHED_SUCCESSFULLY =
      "Contacts Searched Successfully";
  static const String NO_CONTACT_FOUND_FOR_YOUR_SEARCH_QUERY =
      "No Contact Found for Search Query ";

  static const String CONTACT_WAS_CREATED_SUCCESSFULLY =
      "Contact was created successfully";
  static const String UNABLE_TO_CREATE_CONTACT = "Unable to create Contact";
  static const String USER_HAS_NOT_PERFORMED_ANY_ACTION =
      "User has not performed any action";

  static const String CONTACT_WAS_DELETED_SUCCESSFULLY =
      "Contact was Deleted Succesfully";
  static const String PLEASE_PROVIDE_THE_ID_OF_THE_CONTACT_TO_BE_DELETED =
      "Please provide the id of the contact to be deleted";
  static const String NO_CONTACT_WITH_PROVIDED_ID_EXIST_IN_DATABASE =
      "No contact with provided id exist in Prferences";

  static const String CONTACT_WAS_UPDATED_SUCCESSFULLY =
      "Contact was Updated Succesfully";
  static const String UNABLE_TO_UPDATE_CONTACT = "Unable to update Contact";
  static const String USER_HAS_NOT_PERFORMED_EDIT_ACTION =
      "User has not performed edit action";

  static const String PLEASE_PICK_AN_IMAGE_FROM_GALLERY =
      "Please pick an image from Gallery";

  static const String PLEASE_FILL_VALID_NAME =
      "Please fill name within range of 4 to 20 Characters";

  static const String PLEASE_FILL_PHONE_NO =
      "Please fill phone no within range of 7 to 20 digits";

  static const String PLEASE_FILL_VALID_PHONE_NO = "Please fill valid phone no";

  static const String PLEASE_FILL_VALID_EMAIL_ADDRESS =
      "Please fill valid email address";

  static const String PLEASE_FILL_ADDRESS =
      "Please fill address within range of 4 to 1000 Characters";

  static const String PLEASE_FILL_SOMETHING_IN_SEARCH_FIElD =
      "Please fill something in search field";
}

// ignore: must_be_immutable
class ProgressDialog extends StatefulWidget {
  Color backgroundColor;
  Color color;
  Color containerColor;
  double borderRadius;
  String text;
  bool opacity;
  ProgressDialogState progressDialogState;

  ProgressDialog(
      {this.backgroundColor = Colors.black54,
      this.color = Colors.white,
      this.containerColor = Colors.transparent,
      this.borderRadius = 10.0,
      this.text,
      this.opacity = false});

  @override
  createState() => progressDialogState = new ProgressDialogState(
      backgroundColor: this.backgroundColor,
      color: this.color,
      containerColor: this.containerColor,
      borderRadius: this.borderRadius,
      text: this.text,
      opacity: this.opacity);

  void hide() {
    progressDialogState.hide();
  }

  void show() {
    progressDialogState.show();
  }

  void showProgressWithText(String title) {
    progressDialogState.showProgressWithText(title);
  }

  static Widget getProgressDialog(String title, bool opacity) {
    return new ProgressDialog(
        backgroundColor: Colors.black12,
        color: Colors.white,
        containerColor: Colors.blueGrey,
        borderRadius: 5.0,
        text: title,
        opacity: opacity);
  }
}

class ProgressDialogState extends State<ProgressDialog> {
  Color backgroundColor;
  Color color;
  Color containerColor;
  double borderRadius;
  String text;
  bool opacity = true;

  ProgressDialogState(
      {this.backgroundColor = Colors.black54,
      this.color = Colors.white,
      this.containerColor = Colors.transparent,
      this.borderRadius = 10.0,
      this.text,
      this.opacity = false});

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: !opacity
            ? null
            : new Opacity(
                opacity: opacity ? 1.0 : 0.0,
                child: new Stack(
                  children: <Widget>[
                    new Center(
                      child: new Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: new BoxDecoration(
                            color: containerColor,
                            borderRadius: new BorderRadius.all(
                                new Radius.circular(borderRadius))),
                      ),
                    ),
                    new Center(
                      child: _getCenterContent(),
                    )
                  ],
                ),
              ));
  }

  Widget _getCenterContent() {
    if (text == null || text.isEmpty) {
      return _getCircularProgress();
    }

    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getCircularProgress(),
          new Container(
            margin: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
            child: new Text(
              text,
              style: new TextStyle(color: color),
            ),
          )
        ],
      ),
    );
  }

  Widget _getCircularProgress() {
    return new CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation(color));
  }

  void hide() {
    setState(() {
      opacity = false;
    });
  }

  void show() {
    setState(() {
      opacity = true;
    });
  }

  void showProgressWithText(String title) {
    setState(() {
      opacity = true;
      text = title;
    });
  }
}

class RegularExpressionsPatterns {
  static const String EMAIL_VALIDATION =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static const String PHONE_VALIDATION = r'^[0-9]+$';
}

bool isValidEmail(String email) {
  return isValid(email, RegularExpressionsPatterns.EMAIL_VALIDATION);
}

bool isValidPhone(String phone) {
  return isValid(phone, RegularExpressionsPatterns.PHONE_VALIDATION);
}

bool isValid(String thingNeedToBeValidated, String validationPattern) {
  return new RegExp(validationPattern).hasMatch(thingNeedToBeValidated);
}

class ProgressDialogTitles {
  static const String LOADING_CONTACTS = "Contacts...";
  static const String DELETING_CONTACT = "Deleting...";
  static const String SEARCHING_CONTACTS = "Searching...";
  static const String CREATING_CONTACT = "Creating...";
  static const String EDITING_CONTACT = "Editing...";
  static const String LOADING_DELETED_CONTACTS = "Contacts...";
}
const String DATABASE_NAME = "contacts.db";
class CreateTableQueries {
  static String CREATE_CONTACT_TABLE = "CREATE TABLE " +
      ContactTable.TABLE_NAME +
      "(" +
      ContactTable.ID +
      " INTEGER PRIMARY KEY AUTOINCREMENT," +
      ContactTable.NAME +
      " TEXT NOT NULL," +
      ContactTable.PRIMARY_PHONE +
      " TEXT NOT NULL," +
      ContactTable.SECONDARY_PHONE +
      " TEXT NOT NULL," +
      ContactTable.PRIMARY_EMAIL +
      " TEXT NOT NULL," +
       ContactTable.SECONDARY_EMAIL+
      " TEXT NOT NULL," +
      ContactTable.ADDRESS +
      " TEXT NOT NULL," +
      ContactTable.CONTACT_IMAGE +
      " TEXT NOT NULL);";
}
