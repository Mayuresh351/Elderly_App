import 'package:flutter/material.dart';

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
    );
  }
}
