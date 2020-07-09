import 'package:flutter/material.dart';
import 'package:elderlyapp/components.dart';
import 'package:elderlyapp/constants.dart';
import 'notesList.dart';

class NotesPage extends StatefulWidget {
  static String id = 'NotesPage';
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kWidgetColor,
        title: Text(
          'Doctor\'s Notes',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: NotesList(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/addDoctorNote');
          }
      ),
    );
  }
}