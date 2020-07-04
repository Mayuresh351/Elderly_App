import 'package:elderlyapp/screens/reminderpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MedicineReminder());
}

class MedicineReminder extends StatefulWidget {
  @override
  _MedicineReminderState createState() => _MedicineReminderState();
}

class _MedicineReminderState extends State<MedicineReminder> {


  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
          brightness: Brightness.light,
        ),
        home: MedicineReminder(),
        debugShowCheckedModeBanner: false,
      );

  }
}