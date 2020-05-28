import 'package:elderlyapp/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:elderlyapp/constants.dart';

class WelcomePage extends StatefulWidget {
  static String id = 'WelcomePage';
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: navigatebutton(text: 'HomePage',route: HomePage.id,),
      ),
    );
  }
}
