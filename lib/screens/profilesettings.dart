import 'package:elderlyapp/screens/accountsettings.dart';
import 'package:elderlyapp/screens/contactsettings.dart';
import 'package:elderlyapp/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:elderlyapp/constants.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:elderlyapp/rootpage.dart';
import 'package:elderlyapp/data/userdata.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus {notSignedIn,SignedIn}

class ProfilePage extends StatefulWidget {
  ProfilePage({this.onSignedOut});
  final VoidCallback onSignedOut;
  static String id = 'ProfilePage';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  UserData user = UserData();
  final _auth = FirebaseAuth.instance;

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
                        SizedBox(
                          height: size.height*0.03,
                        ),
                        FlatButton(
                          onPressed:()async{
                            AuthStatus auth = AuthStatus.notSignedIn;
                            await user.Signout();
                            UserData.signout = true;
                            Navigator.popUntil(context, ModalRoute.withName(RootPage.id));
                          },
                          child: Container(
                            width: size.width * 0.7,
                            height: size.height * 0.06,
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
