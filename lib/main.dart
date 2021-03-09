import 'package:flutter/material.dart';

import 'common/constants/constants.dart';
import 'presentation/splash_page.dart';

void main() => runApp(new ContactsApp());

class ContactsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: DrawerTitles.CONTACTS,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new SplashPage(),
    );
  }
}