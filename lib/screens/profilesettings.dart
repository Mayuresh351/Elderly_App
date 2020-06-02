import 'package:elderlyapp/screens/accountsettings.dart';
import 'package:elderlyapp/screens/contactsettings.dart';
import 'package:flutter/material.dart';
import 'package:elderlyapp/constants.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
<<<<<<< HEAD
import 'package:auto_size_text/auto_size_text.dart';

=======
>>>>>>> 19d17d7b8e0727587797953aa966a38122764848
class ProfilePage extends StatefulWidget {
  static String id = 'ProfilePage';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: kWidgetColor,
      ),
      backgroundColor: kWidgetColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Hero(
                tag: 'Avatar',
                child: CircleAvatar(
                  radius: size.height * 0.1,
                  backgroundImage: AssetImage('images/accpro.png'),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
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
                        Options(
                          icon: Icons.person,
                          option: 'Account Settings',
                          route: AccSetting.id,
                        ),
                        Options(
                          icon: Icons.language,
                          option: 'Change Language',
                        ),
                        Options(
                          icon: Icons.contacts,
                          option: 'Contact Settings ',
                          route: ContactSettings.id,
                        ),
                        SizedBox(),
                        FlatButton(
                          onPressed: null,
                          child: Container(
                            width: size.width * 0.4,
                            height: size.height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(10.0),
                              color: Colors.red,
                            ),
                            child: Center(
                              child: Text(
                                'Log Out',
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
            )
          ],
        ),
      ),
    );
  }
}
