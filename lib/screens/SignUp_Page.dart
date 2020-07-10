import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elderlyapp/rootpage.dart';
import 'package:elderlyapp/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:elderlyapp/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:elderlyapp/data/userdata.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class SignUpPage extends StatefulWidget {
  static String id = 'SignUpPage';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _auth = FirebaseAuth.instance;
  String Id;
  String Name = '';
  String email = '';
  String Password = '';
  String language = 'English';
  String type = 'Guardian';
  DateTime birthday = DateTime(2000,1,1);

  var data = UserData();
  String _password1 = '';
  String _password2 = '';
  bool showSpinner = false;
  bool invalid = true;



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    DropdownButton<String> androidDropDown1(){
      List<DropdownMenuItem<String>> items = [];
      for (String currency in data.typelist) {
        var newitem = DropdownMenuItem(child: Text(currency), value: currency);
        items.add(newitem);
      }
      return DropdownButton<String>(
          dropdownColor: kLightTextColor,
          isExpanded: true,
          style: TextStyle(
            color: kTextColor,
            fontSize: 16,
          ),
          focusColor: kWidgetColor,
          underline: Divider(color: kWidgetColorlite,),
          elevation: 30,
          value: type ,
          items: items,
          onChanged: (value){
            setState(() {
              type = value;
            });
          });
    }
    DropdownButton<String> androidDropDown2(){
      List<DropdownMenuItem<String>> items = [];
      for (String currency in data.languagelist) {
        var newitem = DropdownMenuItem(child: Text(currency), value: currency);
        items.add(newitem);
      }
      return DropdownButton<String>(
          dropdownColor: kLightTextColor,
          focusColor: kWidgetColor,
          isExpanded: true,
          style: TextStyle(
            color: kTextColor,
            fontSize: 16,
          ),
          underline: Divider(color: kWidgetColorlite,),
          elevation: 30,
          value: language,
          items: items,
          onChanged: (value){
            setState(() {
              language = value;
            });
          });
    }

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(15.0, 110.0, 0, 0),
                          child: Text('Welcome to',
                            style: TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(15.0, 0.0, 0, 0),
                              child: Text('Elderly Help',
                                style: TextStyle(
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              child: Text('!!!',
                                style: TextStyle(
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.bold,
                                  color: kWidgetColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: <Widget>[
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Enter Your Name:',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kWidgetColor,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.deepOrange)
                                  ),
                                ),
                                onChanged: (value){
                                  Name= value;
                                },
                              ),
                              SizedBox(height: 10),
                              TextField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'E-mail Address:',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kWidgetColor,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.deepOrange)
                                  ),
                                ),
                                onChanged: (value){
                                  email= value;
                                },
                              ),
                              SizedBox(height: 10),
//                          TextField(
//                            decoration: InputDecoration(
//                              labelText: 'Language:',
//                              labelStyle: TextStyle(
//                                fontWeight: FontWeight.bold,
//                                color: kWidgetColor,
//                              ),
//                              focusedBorder: UnderlineInputBorder(
//                                  borderSide: BorderSide(color: Colors.deepOrange)
//                              ),
//                            ),
//                          ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Language',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: kWidgetColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: (orientation == Orientation.landscape)?size.width*0.05:size.height*0.05,
                                      width: size.width*0.6,
                                      child: androidDropDown2(),
                                    ),
                                  ],
                                ),
                              SizedBox(
                                height: 20.0,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2.5),
                                  child: Divider(
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      'Type',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: kWidgetColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: (orientation == Orientation.landscape)?size.width*0.05:size.height*0.05,
                                    width: size.width*0.6,
                                    child: androidDropDown1(),
                                  ),
                                ],
                              ),
                              SizedBox(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2.5),
                                  child: Divider(
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                              InputDatePickerFormField(
                                fieldLabelText: 'Enter Birthday',
                                errorFormatText: 'Invalid Format Entered',
                                errorInvalidText: 'Invalid Text Entered',
                                onDateSubmitted: (value){
                                  birthday = value;
                                },
                                firstDate: DateTime(1930,1,1),
                                lastDate: DateTime.now(),
                              ),
                              TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password:',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kWidgetColor,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.deepOrange)
                                  ),
                                ),
                                onChanged: (value){
                                  _password1 = value;
                                },
                              ),
                              SizedBox(height: 10),
                              TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Confirm Password:',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kWidgetColor,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.deepOrange)
                                  ),
                                ),
                                onChanged: (value){
                                  _password2 = value;
                                  setState(() {
                                  });
                                },
                              ),
                              SizedBox(height: 10.0,),
                              Container(
                                child: Text(
                                  (_password1 == _password2)?'':'Passwords not the same',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.red,
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
                                  child: FlatButton(
                                    onPressed: ()async{

                                      Password = _password1;
                                      if(email != '' && Name !='' && Password != '' && email !=''&&_password1 ==_password2){
                                        setState(() {
                                          showSpinner = true;
                                        });
                                        try {
                                          final newUser = await data.SignUp(email,Password,Name,language,type,birthday);
                                          if(newUser != null){
//                                        Navigator.pushNamed(context, HomePage.id);
                                              Navigator.popUntil(context, ModalRoute.withName(RootPage.id));
                                          }
                                          setState(() {
                                            showSpinner =false;
                                          });
                                        }catch(e) {
                                          print(e);
                                          setState(() {
                                            invalid = true;
                                            showSpinner = false;
                                          });
                                        }
                                      }
                                      else{
                                        setState(() {
                                          invalid = true;
                                        });
                                      }
                                    },
                                    child: Center(
                                      child: Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                child: Text(
                                  (invalid == true)?'':'Invalid Credentials',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}