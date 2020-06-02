import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

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

class Options extends StatelessWidget {

  Options({this.icon,this.option,this.route});

  IconData icon;
  String option;
  String route;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FlatButton(
      child: Container(
        child: Column(
          children: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
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
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: Container(
                              height: size.height*0.04,
                              width:  size.width* 0.5,
                              child: AutoSizeText(
                                option,
                                style:TextStyle(
                                    fontFamily: 'Ubuntu',
                                    color: kTextColor,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500),
                                maxFontSize: 30,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                  ),
                ],
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
        ),
      ),
      onPressed: (){
        Navigator.pushNamed(context, route);
      },
    );
  }
}

