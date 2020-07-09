import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'noteTile.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:elderlyapp/data/userdata.dart';



class NotesList extends StatefulWidget {
  @override
  _NotesListState createState() => _NotesListState();
}

List<String> notes= ['Hello', 'Take care', 'Be healthy', 'Stay happy', 'Excercise Regularly', 'Always smile', 'Ignore Stress', 'Maintain discipline'];
List<String> Doctors= ['Person 1', 'Person 2', 'Person 3', 'Person 4', 'Person 5', 'Person 6', 'Person 7', 'Person 8'];

class _NotesListState extends State<NotesList> {


  @override
  Widget build(BuildContext context) {
    //final FirebaseAuth _auth = FirebaseAuth.instance;
    if(Doctors == null){
      return Text('No data');
    } else {
      return ListView.builder(
        itemCount: Doctors.length,
        itemBuilder: (context, index){
          return NoteTile(note: notes[index], doctor: Doctors[index]);
        },
      );
    }

  }
}
