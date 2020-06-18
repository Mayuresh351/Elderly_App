import 'package:flutter/material.dart';
import 'package:elderlyapp/components.dart';
import 'package:elderlyapp/constants.dart';

class MedicationPage extends StatefulWidget {
  static String id = 'MedicationPage';
  @override
  _MedicationPageState createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('images/ComingSoon.jpg'),
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
