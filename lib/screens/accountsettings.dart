import 'package:elderlyapp/constants.dart';
import 'package:flutter/material.dart';

class AccSetting extends StatefulWidget {
  static String id  = 'AccSettings';
  @override
  _AccSettingState createState() => _AccSettingState();
}

class _AccSettingState extends State<AccSetting> {
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
                    child: Column(
                      children: <Widget>[
                        Options(icon: Icons.supervised_user_circle,option: 'Change Username'),
                        Options(icon: Icons.security,option: 'Change Password',),
                        Options(icon: Icons.cake,option: 'Change Birth Date',),
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
