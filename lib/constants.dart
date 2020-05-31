import 'package:flutter/material.dart';

const Color kWidgetColor = Color(0xFF65376A);
const Color kOrangeColor = Color(0xFFFF7C49);
const Color kTextColor = Color(0xFF220C26);
const Color kLightTextColor = Color(0xFFBCAEA8);

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
