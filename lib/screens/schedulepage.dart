import 'package:elderlyapp/screens/doctorappointment.dart';
import 'package:elderlyapp/screens/reminderpage.dart';
import 'package:flutter/material.dart';
import 'package:elderlyapp/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:elderlyapp/components.dart';

class SchedulePage extends StatefulWidget {
  static String id = 'SchedulePage';
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            navigatebutton(text: 'Reminders',route: ReminderPage.id,),
            navigatebutton(text: "Doctor's Appointments",route: DoctorApptPage.id,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kWidgetColor,
        child: Icon(Icons.alarm),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }
}
