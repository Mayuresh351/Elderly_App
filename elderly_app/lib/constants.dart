import 'package:flutter/material.dart';

const Color kWidgetColor = Color(0xFF574558);
const Color kOrangeColor = Color(0xFFFE3411);

class navigatebutton extends StatelessWidget {
  navigatebutton({this.text,this.route});
  String text;
  String route;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        color: kWidgetColor,
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Title(
          child: Text(text,style: TextStyle(color: Colors.white),),
          color: Colors.white,
        ),
      ),
    );
  }
}
