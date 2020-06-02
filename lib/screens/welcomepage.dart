import 'package:elderlyapp/screens/homepage.dart';
import 'package:elderlyapp/screens/login_page.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            navigatebutton(text:'Home Page', route: HomePage.id),
            navigatebutton(text:'Login Page', route: LoginPage.id),
          ],
        ),
      ),
      );
  }
}
