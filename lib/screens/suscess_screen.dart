import 'package:flutter/material.dart';
import 'dart:async';
class SuccessScreenDetails extends StatefulWidget {
  @override
  _SuccessScreenDetailsState createState() => _SuccessScreenDetailsState();
}

class _SuccessScreenDetailsState extends State<SuccessScreenDetails> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(milliseconds: 2200),
          () {
        Navigator.popUntil(
          context,
          ModalRoute.withName('/'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Container(
          child: Center(
            child: Text('You have Successfully Added Medicine',
            ),
             // "assets/animations/Success Check.flr",
            ),
          ),
        ),

    );
  }
}