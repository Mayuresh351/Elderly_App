import 'package:elderlyapp/screens/doctornotespage.dart';
import 'package:elderlyapp/screens/medicationpage.dart';
import 'package:elderlyapp/screens/profilesettings.dart';
import 'package:elderlyapp/screens/schedulepage.dart';
import 'package:flutter/material.dart';
import 'package:elderlyapp/constants.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            navigatebutton(text: "Doctor's Notes",route: NotesPage.id,),
            navigatebutton(text: 'Medication Page',route: MedicationPage.id,),
            navigatebutton(text: 'Settings',route: ProfilePage.id,),
            navigatebutton(text: 'Schedule Page',route: SchedulePage.id,),
          ],
        ),
      ),
    );
  }
}
