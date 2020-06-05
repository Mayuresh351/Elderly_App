import 'package:elderlyapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/painting.dart';


class AccSetting extends StatefulWidget {
  static String id  = 'AccSettings';

  @override
  _AccSettingState createState() => _AccSettingState();

}

class _AccSettingState extends State<AccSetting> {
  String email = 'abc@gmail.com';
  String username = 'User name';
  String password = '*******';
  String birthday = '21/01/52';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kWidgetColor,
      appBar: AppBar(
        backgroundColor: kWidgetColor,
        title: Text(
          'Account Settings'
        ),
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
                      radius: (MediaQuery.of(context).orientation == Orientation.portrait)?size.height*0.06:size.width*0.05,
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
                    height: size.height *0.60,
                    child: ListView(
                      children: <Widget>[

                        Changedetails(icon: Icons.supervised_user_circle,option: 'Username',type: username,datatype: TextInputType.text,),
                        Changedetails(icon: Icons.email,option: 'Email- ID',type: email,datatype: TextInputType.emailAddress,),
                        Changedetails(icon: Icons.cake,option: 'Birth Date',type: birthday,datatype: TextInputType.text,),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'To Change password first enter the current one',style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                            ),
                          ),
                        ),
                        Changedetails(icon: Icons.security,option: 'Password',type: password,datatype: TextInputType.text,),
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

