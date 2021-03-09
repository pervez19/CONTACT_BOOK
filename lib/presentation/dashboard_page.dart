import 'package:contact_book/common/constants/constants.dart';
import 'package:contact_book/data/models/base/event_object.dart';
import 'package:contact_book/presentation/blocs/contact_blocs.dart';
import 'package:contact_book/presentation/contacts_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'create_contact_page.dart';
import 'search_contacts_page.dart';
class DashBoardPage extends StatefulWidget {
  @override
  createState() => new DashBoardPageState();
}

class DashBoardPageState extends State<DashBoardPage> {
  static final globalKey = new GlobalKey<ScaffoldState>();
  ProgressDialog progressDialog = ProgressDialog.getProgressDialog(
      ProgressDialogTitles.LOADING_CONTACTS, true);
  Widget dashBoardWidget = new Container();
  String title = DrawerTitles.CONTACTS;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    await initContacts();
  }

  Future<void> initContacts() async {
    EventObject eventObjectInitContacts = await loadContactList();
    eventsCapturing(eventObjectInitContacts);
  }

  @override
  Widget build(BuildContext context) {
    print("Build-----------------------------------");
    timeDilation = 1.0;
    return new Scaffold(
      key: globalKey,
      appBar: new AppBar(
        centerTitle: true,
        textTheme: new TextTheme(
            title: new TextStyle(
          color: Colors.white,
          fontSize: 22.0,
        )),
        title: new Text(title),
      ),
      body: _homePage(),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _homePage() {
    print("HomePage");
      return new Stack(
        children: <Widget>[dashBoardWidget, progressDialog],
      );
  }

  Widget _floatingActionButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: new FloatingActionButton(
            onPressed: () {
              navigateToPage(new SearchContactsPage());
            },
            heroTag: DrawerTitles.SEARCH_CONTACTS,
            tooltip: DrawerTitles.SEARCH_CONTACTS,
            child: new Icon(
              Icons.search,
            ),
          ),
        ),
        new FloatingActionButton(
          onPressed: () {
            _navigateToCreateContactPage(context);
          },
          child: new Icon(
            Icons.add,
          ),
          heroTag: DrawerTitles.CREATE_CONTACT,
          tooltip: DrawerTitles.CREATE_CONTACT,
        ),
      ],
    );
  }

  void _navigateToCreateContactPage(BuildContext context) async {
    int contactCreationStatus = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new CreateContactPage()),
    );
    setState(() {
      switch (contactCreationStatus) {
        case Events.CONTACT_WAS_CREATED_SUCCESSFULLY:
          handleNavigationClicks(DrawerTitles.CONTACTS, false);
          showSnackBar(SnackBarText.CONTACT_WAS_CREATED_SUCCESSFULLY);
          break;
        case Events.UNABLE_TO_CREATE_CONTACT:
          showSnackBar(SnackBarText.UNABLE_TO_CREATE_CONTACT);
          break;
        case Events.USER_HAS_NOT_CREATED_ANY_CONTACT:
          showSnackBar(SnackBarText.USER_HAS_NOT_PERFORMED_ANY_ACTION);
          break;
      }
    });
  }

  void handleNavigationClicks(String whatToDo, bool close) {
    setState(() {
      if (close) {
        Navigator.pop(context);
      }
      Type type = dashBoardWidget.runtimeType;
      if (title == whatToDo) {
        if (type == ContactPage) {
          ContactPage contactPage = dashBoardWidget as ContactPage;
          contactPage.reloadContactList();
        }
      }
    });
  }

  void loadContacts() async {
    EventObject eventObjectContacts = await loadContactList();
    eventsCapturing(eventObjectContacts);
  }

  void eventsCapturing(EventObject eventObject) {
    print("call EventCapturing-----------------------------------");
    if (this.mounted) {
      setState(() {
        progressDialog.hide();
        switch (eventObject.id) {
          case Events.READ_CONTACTS_SUCCESSFUL:
            dashBoardWidget = new ContactPage(contactList: eventObject.object);
            showSnackBar(SnackBarText.CONTACTS_LOADED_SUCCESSFULLY);
            break;
          case Events.NO_CONTACTS_FOUND:
            dashBoardWidget = new ContactPage();
            showSnackBar(SnackBarText.NO_CONTACTS_FOUND);
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

  void navigateToPage(StatefulWidget statefulWidget) {
    if (this.mounted) {
      setState(() {
        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => statefulWidget),
        );
      });
    }
  }
}
