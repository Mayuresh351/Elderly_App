import 'package:elderlyapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:elderlyapp/components.dart';
import 'package:elderlyapp/data/userdata.dart';

class NotesPage extends StatefulWidget {
  static String id = 'NotesPage';
  @override
  _NotesPageState createState() => _NotesPageState();
}



class _NotesPageState extends State<NotesPage> {


  Widget doctorNote(note){
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      color: Colors.yellow[900],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            note.Note,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.red[900],
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            note.DoctorName,
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  //Try with lists tomorrow

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
      body: SingleChildScrollView(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/addDoctorNote');
          }
      ),
    );
  }
}

//SingleChildScrollView(
//child: Column(
//mainAxisAlignment: MainAxisAlignment.center,
//children: Notes.map((note) => doctorNote(note)).toList(),
//),
//),