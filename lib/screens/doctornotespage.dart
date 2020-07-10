import 'package:flutter/material.dart';
import 'package:elderlyapp/components.dart';
import 'package:elderlyapp/constants.dart';
import 'package:elderlyapp/data/userdata.dart';
import 'notesList.dart';

class NotesPage extends StatefulWidget {
  static String id = 'NotesPage';
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  UserData user = UserData();
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
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.8,
            child: NotesList(),
          ),
          Container(
            child: Text(
              'Long Press to Delete Note',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: kLightTextColor
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/addDoctorNote');
          }
      ),
    );
  }
}