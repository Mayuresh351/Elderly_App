import 'package:elderlyapp/data/userdata.dart';
import 'package:elderlyapp/screens/linkAccount.dart';
import 'package:flutter/material.dart';
import 'package:elderlyapp/constants.dart';
import 'package:provider/provider.dart';

class AccountsLinked extends StatefulWidget {
  @override
  _AccountsLinkedState createState() => _AccountsLinkedState();
}

class _AccountsLinkedState extends State<AccountsLinked> {

  var user = otherUser(otherUid: alpha);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OtherUserData>(
        stream: otherUser(otherUid: alpha).other,
        // ignore: missing_return
        builder: (context, snapshot) {
          if(snapshot.hasData){
            OtherUserData userAlpha = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('Linked Accounts'),
                backgroundColor: kWidgetColor,
              ),
              body: Container(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text('Name :'),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: userAlpha.otherUserName,
                      //validator: (val) => val.isEmpty ? 'It might no be present' : null,
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.deepPurple,
                        color: kWidgetColorlite,
                        elevation: 7.0,
                        child: FlatButton(
                          child: Center(
                            child: Text(
                              'MedReminder Details',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.deepPurple,
                        color: kWidgetColorlite,
                        elevation: 7.0,
                        child: FlatButton(
                          child: Center(
                            child: Text(
                              'Appointment Details',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.deepPurple,
                        color: kWidgetColorlite,
                        elevation: 7.0,
                        child: FlatButton(
                          child: Center(
                            child: Text(
                              'Doctor\'s Notes',
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
            );
          }else{

          }

        }
    );
  }
}
