import 'package:elderlyapp/data/userdata.dart';
import 'package:flutter/material.dart';
import 'package:elderlyapp/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'notesList.dart';
import 'package:provider/provider.dart';
import 'doctornotespage.dart';

class AddDoctorsNotes extends StatefulWidget {
  @override
  _AddDoctorsNotesState createState() => _AddDoctorsNotesState();
}

class _AddDoctorsNotesState extends State<AddDoctorsNotes> {


  String _note;
  String _doctorName;
  UserData user = UserData();
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add Doctor\'s Note'),
          backgroundColor: kWidgetColor,
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 30.0),
                Text('Note: ', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 20.0),
                TextFormField(
                  onChanged: (val) => setState(() => _note = val),
                ),
                SizedBox(height: 20.0),
                Text('Name of Doctor: ', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 20.0),
                TextFormField(
                  onChanged: (val) => setState(() => _doctorName = val),
                ),
                SizedBox(height: 20),
                Container(
                  height: 40.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.deepPurple,
                    color: kWidgetColorlite,
                    elevation: 7.0,
                    child: FlatButton(
                      onPressed: ()async
                      {
                        setState(() {
                          showSpinner = true;
                        });
                        print(Doctor);
                        if(Doctor != null){
                          Note.add(_note);
                          Doctor.add(_doctorName);
                        }
                        else{
                          Note = [_note];
                          Doctor = [_doctorName];
                        }
                        await user.updateNoteData();
                        await user.getNoteData();
                        Navigator.pop(context);
                        setState((){
                          showSpinner = false;
                        });
                      },
                      child: Center(
                        child: Text(
                          'Add',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
