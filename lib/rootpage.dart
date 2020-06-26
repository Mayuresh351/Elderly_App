import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/homepage.dart';
import 'data/userdata.dart';

enum AuthStatus {notSignedIn,SignedIn}

class RootPage extends StatefulWidget {
  static String id = 'RootPage';
  bool auth = false;
  final UserData user = UserData();
  AuthStatus authStatus;
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  void onSignedin(){
    setState(() {
      widget.authStatus = AuthStatus.SignedIn;
    });
  }
  void onSignedOut(){
    setState(() {
      widget.authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  void initstate(){
    super.initState();
    print('asss');

  }

  Widget build(BuildContext context) {
    widget.user.currentUser().then((value){
      setState(() {
        widget.authStatus = (value == null)?AuthStatus.notSignedIn:AuthStatus.SignedIn;
      });
    });
    if(widget.authStatus == AuthStatus.SignedIn){
      return HomePage(onSignedOut1: onSignedOut);
    }
    else{
      return LoginPage(
        onSignedIn: onSignedin,
      );
    }
  }
}
