import 'package:elderlyapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/painting.dart';

class AccSetting extends StatefulWidget {
  static String id = 'AccSettings';

  @override
  _AccSettingState createState() => _AccSettingState();
}

class _AccSettingState extends State<AccSetting> {
  String email = 'abc@gmail.com';
  String username = 'User name';
  String password1 = '*******';
  String password;
  String birthday = '21/01/52';
  bool autherror = false;


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
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                          option: 'Username',
                          type: username,
                          datatype: TextInputType.text,
                        ),
                        Changedetails(
                          icon: Icons.email,
                          option: 'Email- ID',
                          type: email,
                          datatype: TextInputType.emailAddress,
                        ),
                        Changedetails(
                          icon: Icons.cake,
                          option: 'Birth Date',
                          type: birthday,
                          datatype: TextInputType.text,
                        ),
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
                        Changedetails(
                          icon: Icons.security,
                          option: 'Password',
                          type: password,
                          datatype: TextInputType.text,
                          onsubmitted: (value){
                            showMyDialog();
                          },
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
    );
  }
}

