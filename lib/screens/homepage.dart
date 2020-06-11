import 'package:elderlyapp/screens/accountsettings.dart';
import 'package:elderlyapp/screens/doctornotespage.dart';
import 'package:elderlyapp/screens/medicationpage.dart';
import 'package:elderlyapp/screens/profilesettings.dart';
import 'package:elderlyapp/screens/reminderpage.dart';
import 'package:elderlyapp/screens/schedulepage.dart';
import 'package:flutter/material.dart';
import 'package:elderlyapp/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:elderlyapp/components.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int Emergency = 0;
  Future<void> showMyDialog()async{
    return showDialog<void>(
      context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context){
        return AlertDialog(
          title: Text('Emergency!!!'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Do you Want to Call the Emergency Number??'),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        child: Container(
                          width: 120,
                          height: 50,
                          color: Colors.green,
                          child: Center(
                            child: Text('Yes'),
                          ),
                        ),
                        onPressed: (){
                          print('EMERGENCY');
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: Container(
                          width: 120,
                          height: 50,
                          color: Colors.red,
                          child: Center(
                            child: Text('No'),
                          ),
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: (orientation == Orientation.landscape)
                      ? size.width * 0.07
                      : size.height * 0.07,
                  width: (orientation == Orientation.landscape)
                      ? size.height * 0.4
                      : size.width * 0.55,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 15.0),
                    child: AutoSizeText(
                      'Hey Mayuresh ,',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Ubuntu',
                          color: kTextColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                      maxFontSize: 30,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                FlatButton(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child: Material(
                      elevation: 10.0,
                      borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                      color: Colors.red,
                      child: Container(
                        height: size.height*0.05,
                        width: size.width*0.25,
                        child: Center(
                          child: Text(
                              'Emergency',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Emergency++;
                    if(Emergency > 5){
                      Emergency = 0;
                      showMyDialog();
                    }
                  },
                ),
                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
                    child: Icon(
                      Icons.settings,
                      size: size.height * 0.05,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, ProfilePage.id);
                  },
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        height: (orientation == Orientation.landscape)
                            ? size.width * 0.35
                            : size.height * 0.35,
                        width: size.width * 0.9,
                        child: Material(
                          elevation: 5.0,
                          color: kOrangeColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25.0),
                            topLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0),
                            bottomLeft: Radius.circular(25.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(30.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Doctor's Notes",
                                  style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      color: Colors.white,
                                      fontSize: size.height * 0.02,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, NotesPage.id);
                    },
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        height: (orientation == Orientation.landscape)
                            ? size.width * 0.20
                            : size.height * 0.20,
                        width: size.width * 0.9,
                        child: Material(
                          elevation: 5.0,
                          color: kWidgetColor3,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25.0),
                            topLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0),
                            bottomLeft: Radius.circular(25.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Next Medications",
                                  style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      color: Colors.white,
                                      fontSize: size.height * 0.02,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, MedicationPage.id);
                    },
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        height: (orientation == Orientation.landscape)
                            ? size.width * 0.15
                            : size.height * 0.15,
                        width: size.width * 0.9,
                        child: Material(
                          elevation: 5.0,
                          color: kWidgetColor2,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25.0),
                            topLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0),
                            bottomLeft: Radius.circular(25.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Next Appointment ",
                                  style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      color: Colors.white,
                                      fontSize: size.height * 0.02,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, SchedulePage.id);
                    },
                  ),
                ],
              ),
            ),
            BottomTabBar(),
          ],
        ),
      ),
    );
  }
}

