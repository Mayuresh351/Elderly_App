import 'package:elderlyapp/screens/schedulepage.dart';
import 'package:flutter/material.dart';
import 'package:elderlyapp/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  static String id = 'LoginPage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0, 0),
                  child: Text('Hello',
                    style: TextStyle(
                      fontSize: 70.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(18.0, 165.0, 0, 0),
                  child: Text('There',
                    style: TextStyle(
                      fontSize: 70.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(200.0, 165.0, 0, 0),
                  child: Text('.....',
                    style: TextStyle(
                        fontSize: 70.0,
                        fontWeight: FontWeight.bold,
                        color: kWidgetColor
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 300.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'EMAIL or USER ID:',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kWidgetColor,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepOrange)
                          ),
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'PASSWORD:',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kWidgetColor,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepOrange)
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        alignment: Alignment(1.0, 0.0),
                        padding: EdgeInsets.only(top:5.0, right:0.0),
                        child: InkWell(
                          child: Text('Forgot Password',
                            style: TextStyle(
                              color: Colors.purpleAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.deepPurple,
                          color: kWidgetColor,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: (){},
                            child: Center(
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'New to Elderly_App ?',
                          ),
                          SizedBox(width: 5.0),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/SignUpPage');
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


