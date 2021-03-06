import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elderlyapp/data/userdata.dart';
import 'package:elderlyapp/screens/accountsettings.dart';
import 'package:elderlyapp/screens/doctorappointment.dart';
import 'package:elderlyapp/screens/doctornotespage.dart';
import 'package:elderlyapp/screens/medicationpage.dart';
import 'package:elderlyapp/screens/profilesettings.dart';
import'package:cloud_firestore/cloud_firestore.dart';
import 'package:elderlyapp/screens/reminderpage.dart';
import 'package:flutter/material.dart';
import 'package:elderlyapp/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'screens/homepage.dart';
import 'screens/prescriptions.dart';
import 'package:auto_size_text/auto_size_text.dart';

class BottomTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Container(
      height: (orientation == Orientation.landscape)
          ? size.width * 0.08
          : size.height * 0.08,
      width: size.width,
      child: Hero(
        tag: 'Drawer',
        child: Material(
          color: kWidgetColor,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TabWidget(
                    tabIcon: Icons.home,
                    tabContent: 'Home',
                    ontap: () {
                      Navigator.pushNamed(context, HomePage.id);
                      kChosenTab = 0;
                    },
                    color: (kChosenTab == 0)?kWidgetColorlite:kWidgetColor,
                  ),
                  SizedBox(
                    height: (orientation == Orientation.landscape)
                        ? size.width * 0.02
                        : size.height * 0.02,
                    width: 10.0,
                  ),
                  TabWidget(
                    tabIcon: Icons.alarm,
                    tabContent: 'Alarm',
                    ontap: () {
                      Navigator.pushNamed(context, MedicineReminder.id);
                      kChosenTab = 1;
                    },
                    color: (kChosenTab == 1)?kWidgetColorlite:kWidgetColor,
                  ),
                  SizedBox(
                    height: (orientation == Orientation.landscape)
                        ? size.width * 0.02
                        : size.height * 0.02,
                    width: 10.0,
                  ),
                  TabWidget(
                    tabIcon: Icons.local_pharmacy,
                    tabContent: 'Pharmacy',
                    ontap: () {
                        kChosenTab = 2;
                    },
                    color: (kChosenTab == 2)?kWidgetColorlite:kWidgetColor,
                  ),
                  SizedBox(
                    height: (orientation == Orientation.landscape)
                        ? size.width * 0.02
                        : size.height * 0.02,
                    width: 10.0,
                  ),
                  TabWidget(
                    tabIcon: Icons.calendar_today,
                    tabContent: 'Schedule',
                    ontap: () {
                      Navigator.pushNamed(context, MedicineReminder.id);
                      kChosenTab = 3;
                    },
                    color: (kChosenTab == 3)?kWidgetColorlite:kWidgetColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Colors.transparent,
        elevation: 9.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
            height: 70.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0)
                ),
                color: Colors.white
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: (orientation == Orientation.landscape)
                          ? size.width * 0.08
                          : size.height * 0.08,
                      width: MediaQuery.of(context).size.width /2 - 40.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TabWidget(
                            tabIcon: Icons.home,
                            tabContent: 'Home',
                            ontap: () {
                              Navigator.pushNamed(context, HomePage.id);
                              kChosenTab = 0;
                            },
                            color: (kChosenTab == 0)?kWidgetColor:kTabColorLite,
                          ),
                          TabWidget(
                            tabIcon: Icons.local_pharmacy,
                            tabContent: 'Pharmacy',
                            ontap: () {
                              Navigator.pushNamed(context,ImageScreen.id);
                              kChosenTab = 1;
                            },
                            color: (kChosenTab == 1)?kWidgetColor:kTabColorLite,
                          ),
                        ],
                      )
                  ),
                  Container(
                      height: 70.0,
                      width: MediaQuery.of(context).size.width /2 - 40.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TabWidget(
                            tabIcon: Icons.alarm,
                            tabContent: 'Alarm',
                            ontap: () {
                              Navigator.pushNamed(context, MedicineReminder.id);
                              kChosenTab = 2;
                            },
                            color: (kChosenTab == 2)?kWidgetColor:kTabColorLite,
                          ),
                          TabWidget(
                            tabIcon: Icons.calendar_today,
                            tabContent: 'Schedule',
                            ontap: () {
                              Navigator.pushNamed(context, DoctorApptPage.id);
                              kChosenTab = 3;
                            },
                            color: (kChosenTab == 3)?kWidgetColor:kTabColorLite,
                          ),
                        ],
                      )
                  ),
                ]
            )
        )
    );
  }
}
class HomeNotes extends StatefulWidget {
  @override
  _HomeNotesState createState() => _HomeNotesState();
}

class _HomeNotesState extends State<HomeNotes> {

  Stream<DocumentSnapshot> getNoteStatus() async* {
    String uid;
    UserData user = UserData();
    print('stream');
    await user.currentUser().then((value) {
      uid = value.uid;
    });
    yield* Firestore.instance.collection('Doctor\'sNote')
        .document(uid)
        .snapshots();
  }


  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery
        .of(context)
        .orientation;
    final size = MediaQuery
        .of(context)
        .size;
    if (Doctor == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return StreamBuilder(
          stream: getNoteStatus(), builder: (context, snapshot) {
        return ListView.builder(
            itemCount: Doctor.length,
            itemBuilder: (context, index) {
              return Container(
                child: Noteit(note :Note[index],index: index,),
              );
            });
      });
    }
  }
}
class Noteit extends StatelessWidget {
  Noteit({this.note,this.index});
  String note;
  int index;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Container(
        width: size.width*0.1,
        child: Row(
          children: [
            Text('${index+1}.',style: TextStyle(
              fontFamily: 'Ubuntu',
              fontSize: (orientation == Orientation.landscape)?size.height*0.04:size.width*0.04,
            ),),
            SizedBox(
              width: 10,
            ),
            Container(
              width: size.width*0.7,
//            child: Text(
//              '$note',style: TextStyle(
//              fontFamily: 'Ubuntu',
//              fontSize: (orientation == Orientation.landscape)?size.height*0.04:size.width*0.04,
//            ),
//            ),
              child:AutoSizeText(
                '$note',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: 'Ubuntu',
                    color: kTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
                maxFontSize: 18,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
