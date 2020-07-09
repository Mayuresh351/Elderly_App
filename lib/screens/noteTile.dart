import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {

  String note;
  String doctor;
  NoteTile({this.note, this.doctor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text(note),
          subtitle: Text(doctor),
        ),
      ),
    );
  }
}
