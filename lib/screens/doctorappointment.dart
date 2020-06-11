import 'package:flutter/material.dart';

class DoctorApptPage extends StatefulWidget {
  static String id = 'DoctorApptPage';
  @override
  _DoctorApptPageState createState() => _DoctorApptPageState();
}

class _DoctorApptPageState extends State<DoctorApptPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset('images/ComingSoon.jpg'),
      ),
    );
  }
}
