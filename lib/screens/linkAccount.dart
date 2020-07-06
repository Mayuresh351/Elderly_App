import 'package:flutter/material.dart';
import 'package:elderlyapp/constants.dart';

String alpha;

class LinkAccount extends StatefulWidget {
  @override
  _LinkAccountState createState() => _LinkAccountState();
}

class _LinkAccountState extends State<LinkAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Link your account', style: TextStyle(color: Colors.white)),
        backgroundColor: kWidgetColor,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Text('Add uid of the account to be linked', style: TextStyle(fontWeight: FontWeight.bold)),
            TextFormField(
              validator: (val) => val.isEmpty ? 'Please enter the uid' : null,
              onChanged: (val) => setState(() => alpha = val),
            ),

            SizedBox(height: 20.0),
            Container(
              height: 40.0,
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.deepPurple,
                color: kWidgetColorlite,
                elevation: 7.0,
                child: FlatButton(
                  child: Center(
                    child: Text(
                      'Link Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/accountsLinked');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
