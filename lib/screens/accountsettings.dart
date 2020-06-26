import 'package:elderlyapp/constants.dart';
import 'package:elderlyapp/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/painting.dart';
import 'package:elderlyapp/data/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';



class AccSetting extends StatefulWidget {
  static String id = 'AccSettings';

  @override
  _AccSettingState createState() => _AccSettingState();
}

class _AccSettingState extends State<AccSetting> {

  var user = UserData();
  String email = '';
  String username = '';
  String password1 = '*******';
  String password;
  DateTime birthday;
  bool autherror = false;
  bool showSpinner = false;
  bool invalid = null;
  int call = 0;
  Timestamp birth;


  Future<void> showMyDialog() async {
    String Newpass1;
    String Newpass2;
    print(autherror);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState){
            return AlertDialog(
              title: Text('Change Password'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Enter New Password :'),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        decoration: kTextFieldDecoration,
                        onChanged: (value){
                          Newpass1 = value;
                        },
                      ),
                    ),
                    Text('Confirm Password :'),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        decoration: kTextFieldDecoration,
                        onChanged: (value){
                          Newpass2 = value;
                        },
                      ),
                    ),
                    Text(
                      autherror == false ? '':'Password Do not match',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),

              actions: <Widget>[
                FlatButton(
                  child: Container(
                    child: Text('Change Password',style: TextStyle(fontSize: 20),),
                  ),
                  onPressed: () {
                    if(Newpass1 != Newpass2){
                      setState(() {
                        autherror = true;
                        print('setstate');
                        print(autherror);
                      });
                      print('password not matching');
                    }
                    else {
                      Navigator.of(context).pop();
                      password = Newpass2;
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
//  Future showAlert(){
//    return showDialog<void>(
//      context: context,
//      barrierDismissible: false, // user must tap button!
//      builder: (BuildContext context) {
//        return StatefulBuilder(
//          builder: (context, setState){
//            return AlertDialog(
//              title: Text('Change Password'),
//              content: SingleChildScrollView(
//                child: ListBody(
//                  children: <Widget>[
//                    Text('Enter New Password :'),
//                    Padding(
//                      padding: EdgeInsets.all(10.0),
//                      child: TextField(
//                        decoration: kTextFieldDecoration,
//                        onChanged: (value){
//                          Newpass1 = value;
//                        },
//                      ),
//                    ),
//                    Text('Confirm Password :'),
//                    Padding(
//                      padding: EdgeInsets.all(10.0),
//                      child: TextField(
//                        decoration: kTextFieldDecoration,
//                        onChanged: (value){
//                          Newpass2 = value;
//                        },
//                      ),
//                    ),
//                    Text(
//                      autherror == false ? '':'Password Do not match',
//                      textAlign: TextAlign.center,
//                      style: TextStyle(
//                        fontSize: 18.0,
//                        color: Colors.red,
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//
//              actions: <Widget>[
//                FlatButton(
//                  child: Container(
//                    child: Text('Change Password',style: TextStyle(fontSize: 20),),
//                  ),
//                  onPressed: () {
//                    if(Newpass1 != Newpass2){
//                      setState(() {
//                        autherror = true;
//                        print('setstate');
//                        print(autherror);
//                      });
//                      print('password not matching');
//                    }
//                    else {
//                      Navigator.of(context).pop();
//                      password = Newpass2;
//                    }
//                  },
//                ),
//              ],
//            );
//          },
//        );
//      },
//    );
//  }
  void yoyo()async{
    if(call == 0){
      await user.currentUser().then((value){
        email = value.email;
      });
      await user.getData().then((value){
        username = value.data['Name'];
        Timestamp date = value.data['Birthday'];
        birthday = date.toDate();
      });
      setState(() {});
      call++;
    }
  }
  @override

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    yoyo();
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: kWidgetColor,
        appBar: AppBar(
          backgroundColor: kWidgetColor,
          title: Text('Account Settings'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Hero(
                      tag: 'Avatar',
                      child: CircleAvatar(
                        radius: (MediaQuery.of(context).orientation ==
                                Orientation.portrait)
                            ? size.height * 0.06
                            : size.width * 0.05,
                        backgroundImage: AssetImage('images/accpro.png'),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Hero(
                  tag: 'Drawer',
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25.0),
                        topLeft: Radius.circular(25.0)),
                    child: Container(
                      height: size.height * 0.60,
                      child: ListView(
                        children: <Widget>[
                          Changedetails(
                            icon: Icons.supervised_user_circle,
                            option: 'User Name',
                            type: username,
                            datatype: TextInputType.text,
                            onChanged: (value){
                              username = value;
                            },
                          ),
                          Changedetails(
                            icon: Icons.email,
                            option: 'Email- ID',
                            type: email,
                            datatype: TextInputType.emailAddress,
                          ),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Press Enter to save your Birthday',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          Changedetails1(
                            icon: Icons.cake,
                            option: 'Birth Date',
                            type: birthday,
                            onChanged: (value){
                              print(value);
                              birthday = value;
                              print(birthday);
                            },
                          ),
                          Row(
                            children: [
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'To Change password first enter the current one',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  (invalid==null || invalid==false)?'':'Invalid Credentials',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Changedetails(
                            icon: Icons.security,
                            option: 'Password',
                            type: password,
                            datatype: TextInputType.text,
                            onChanged: (value){
                              password = value;
                            },
                            onsubmitted: (value)async{
//                              showMyDialog();
                                setState(() {
                                  showSpinner = true;
                                });
                                try{
                                  final user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                                  if(user!= null){
                                    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                                    setState(() {
                                      invalid = false;
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
                          ),
                          Container(
                            height: (orientation == Orientation.landscape)?size.width*0.04:size.height*0.04,
                            child: Center(
                              child: Text(
                                (invalid == true || invalid == null )?'':'Reset link sent to your mail',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed:()async{
                              setState(() {
                                showSpinner = true;
                              });
                              final status = await user.updateAccSettings(username,birthday);
                              if(status != null){
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            },
                            child: Container(
                              width: size.width * 0.7,
                              height: size.height * 0.06,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.circular(10.0),
                                color: Colors.blueAccent,
                              ),
                              child: Center(
                                child: Text(
                                  'Save Details',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,),
                                ),
                              ),
                            ),
                          ),
                        ],
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

