import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elderlyapp/constants.dart';
import 'package:elderlyapp/screens/prescriptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
//import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'noteTile.dart';
import 'package:elderlyapp/constants.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:elderlyapp/data/userdata.dart';

class NotesList extends StatefulWidget {

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  bool showSpinner =false;
  UserData user = UserData();

  openAlertBox(BuildContext context,int index) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
            ),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
//              width: MediaQuery.of(context).size.width*0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(18),
                    child: Center(
                      child: Text(
                        "Delete this Note?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async{
                          Doctor.removeAt(index);
                          Note.removeAt(index);
                          await user.updateNoteData();
                          Navigator.pop(context);
                        },
                        child: InkWell(
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width*0.34,
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            decoration: BoxDecoration(
                              color: Color(0xFF3EB16F),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30.0),
                              ),
                            ),
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: InkWell(
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width*0.34,
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            decoration: BoxDecoration(
                              color: Colors.red[700],
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30.0)),
                            ),
                            child: Text(
                              "No",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
  Stream<DocumentSnapshot> getNoteStatus() async* {
    String uid;
    print('stream');
    await user.currentUser().then((value) {
      uid = value.uid;
    });
    yield* Firestore.instance.collection('Doctor\'sNote').document(uid).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    //final FirebaseAuth _auth = FirebaseAuth.instance;
    print(Doctor);
    if (Doctor == null) {
      return Center(child: CircularProgressIndicator(),);
    } else {
      return StreamBuilder(stream:getNoteStatus(),builder: (context,snapshot){
        return ListView.builder(
          itemCount: Doctor.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: (){
                openAlertBox(context,index);
              },
              child: NoteTile(note: Note[index], doctor: Doctor[index]),);
          },
        );
      });
    }
  }
}
