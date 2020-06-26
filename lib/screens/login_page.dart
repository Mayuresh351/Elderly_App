import 'package:elderlyapp/screens/SignUp_Page.dart';
import 'package:elderlyapp/screens/homepage.dart';
import 'package:elderlyapp/screens/schedulepage.dart';
import 'package:flutter/material.dart';
import 'package:elderlyapp/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginPage extends StatefulWidget {

  LoginPage({this.onSignedIn});
  final VoidCallback onSignedIn;
  static String id = 'LoginPage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;
  bool invalid = false;
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Visibility(
          visible: visible,
          child: Column(
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
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value){
                              email = value;
                            },
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
                            onChanged: (value){
                              password = value;
                            },
                          ),
                          SizedBox(height: 30.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  (invalid == false)?'':'Invalid Credentials',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment(1.0, 0.0),
                                padding: EdgeInsets.only(top:5.0, right:0.0),
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      visible = false;
                                    });
                                  },
                                  child: Text('Forgot Password',
                                    style: TextStyle(
                                      color: Colors.purpleAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30.0),
                          Container(
                            height: 40.0,
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.deepPurple,
                              color: kWidgetColor,
                              elevation: 7.0,
                              child: FlatButton(
                                onPressed: ()async{
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  try{
                                    final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                                    if(user!= null){
                                      invalid = false;
                                      widget.onSignedIn();
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    }
                                  }
                                  catch(e){
                                    print(e);
                                    setState(() {
                                      showSpinner = false;
                                      invalid = true;
                                    });
                                  }
                                },
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
                                  Navigator.pushNamed(context, SignUpPage.id);
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
          replacement: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20.0, 110.0, 0.0, 0.0),
                child: Text('Hello',
                  style: TextStyle(
                    fontSize: 70.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0 , 0.0, 0.0, 10.0),
                    child: Text('There',
                      style: TextStyle(
                        fontSize: 70.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    child: Text('.....',
                      style: TextStyle(
                          fontSize: 70.0,
                          fontWeight: FontWeight.bold,
                          color: kWidgetColor
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
                child: TextField(
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
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value){
                    email = value;
                    setState(() {
                      visible = false;
                    });
                  },
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                height: 40.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  shadowColor: Colors.deepPurple,
                  color: kWidgetColor,
                  elevation: 7.0,
                  child: FlatButton(
                    onPressed: ()async{
                      setState(() {
                        showSpinner = true;
                      });
                      try{
                        final user = await _auth.sendPasswordResetEmail(email: email);
                        setState(() {
                          showSpinner = false;
                          visible = true;
                        });
                      }
                      catch(e){
                        print(e);
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    },
                    child: Center(
                      child: Text(
                        'RESET PASSWORD',
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
    );
  }
}


