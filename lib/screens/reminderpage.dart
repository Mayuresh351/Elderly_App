import 'package:flutter/material.dart';
import 'package:elderlyapp/components.dart';
import 'package:elderlyapp/constants.dart';

class ReminderPage extends StatefulWidget {

  static String id = 'ReminderPage';
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/ComingSoon.jpg')
          ],
        ),
      ),
    floatingActionButton: FloatingActionButton(
    onPressed: () {},
    backgroundColor: kWidgetColor,
    child: Icon(Icons.notifications_none),
    ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }
}


