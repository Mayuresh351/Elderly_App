import 'package:flutter/material.dart';
import 'package:elderlyapp/constants.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
class ProfilePage extends StatefulWidget {
  static String id = 'ProfilePage';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWidgetColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 100.0,
            ),
            CircleAvatar(
              radius: 75.0,
              backgroundImage: AssetImage('images/accpro.png'),
            ),
            SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    topLeft: Radius.circular(25.0)),
                child: Column(
                  children: <Widget>[
                    Options(icon: Icons.person,option: 'Account Settings'),
                    Options(icon: Icons.language,option: 'Language ',),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Options extends StatelessWidget {

  Options({this.icon,this.option});

  IconData icon;
  String option;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FlatButton(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    icon,
                    color: kLightTextColor,
                    size: 50,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Container(
                    child: Text(
                      option,
                      style: TextStyle(
                          fontFamily: 'Ubuntu', color: kTextColor,fontSize: 25.0,fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(
              color: kLightTextColor,
            ),
          ),
        )
      ],
    );
  }
}
