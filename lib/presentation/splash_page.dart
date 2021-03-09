
import 'dart:async';

import 'package:contact_book/common/constants/constants.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'dashboard_page.dart';

class SplashPage extends StatefulWidget {
  @override
  createState() => new SplashPageState();
}

class SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  Animation<double> logoAnimation, appNameAnimation;
  AnimationController logoAnimationController, appNameAnimationController;

  static final tweenLogo = new Tween(begin: 0.0, end: 200.0);
  static final tweenAppName = new Tween(begin: 0.0, end: 50.0);

  @override
  initState() {
    super.initState();
    logoAnimationController = new AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    appNameAnimationController = logoAnimationController;
    logoAnimation = tweenLogo.animate(logoAnimationController)
      ..addListener(() {
        setState(() {
        });
      });
    appNameAnimation = tweenAppName.animate(logoAnimationController)
      ..addListener(() {
        setState(() {
        });
      });
    logoAnimationController.forward();
    appNameAnimationController.forward();
  }

  final globalKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    new Future.delayed(const Duration(seconds: 3), _handleTapEvent);
    return new Scaffold(
      key: globalKey,
      body: _splashContainer(),
    );
  }

  Widget _splashContainer() {
    return GestureDetector(
        onTap: _handleTapEvent,
        child: Container(
            height: double.infinity,
            width: double.infinity,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Container(
                    child: new Icon(
                  Icons.contacts,
                  size: logoAnimation.value,
                  color: Colors.blue[900],
                )),
                new Container(
                  margin: EdgeInsets.only(top: 40.0),
                  child: new Text(
                    Texts.APP_NAME,
                    style: new TextStyle(
                        color: Colors. blueGrey[800],
                        fontSize: appNameAnimation.value),
                  ),
                ),
              ],
            )));
  }

  void _handleTapEvent() async {
    if (this.mounted) {
      setState(() {
        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => new DashBoardPage()),
        );
      });
    }
  }

  @override
  dispose() {
    logoAnimationController.dispose();
    super.dispose();
  }
}