import 'package:flutter/material.dart';
import 'package:elderlyapp/components.dart';
import 'package:elderlyapp/constants.dart';
import 'new_entry.dart';

class ReminderPage extends StatefulWidget {

  static String id = 'ReminderPage';
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mediminder'),
        centerTitle: true,
        backgroundColor: Color(0xFF65376A),
        elevation: 0.0,
      ),
      body: Container(

        child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Center(
                  child: Text(
                    "Number of Mediminders",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 200.0),

              Container(
                color: Color(0xFFF6F8FC),
                child: Center(
                  child: Text(
                    "Press + to add a Mediminder",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFFC9C9C9),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ]
        ),
      ),


      floatingActionButton: FloatingActionButton(

          backgroundColor: Color(0xFF3EB16F),
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            Navigator.push(
              context,MaterialPageRoute(
              builder: (context) => NewEntry(),
            ),
            );
          }
      ),

     // floatingActionButton: FloatingActionButton(


    );
  }
}


