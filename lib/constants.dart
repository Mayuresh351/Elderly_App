import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

const Color kWidgetColor = Color(0xFF65376A);
const Color kOrangeColor = Color(0xFFFF7C49);
const Color kTextColor = Color(0xFF220C26);
const Color kLightTextColor = Color(0xFFBCAEA8);
const Color kWidgetColor2 = Color(0xFFCBB6AF);
const Color kWidgetColor3 = Color(0xFFB56652);
const Color kWidgetColorlite = Color(0xFF926496);
const Color kTabColorLite = Color(0xFF676E79);
int kChosenTab = 0;

const kTextFieldDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: kOrangeColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: kOrangeColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

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
                          color: kOrangeColor,
                          size: 50,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: Container(
                              height: size.height*0.04,
                              width:  size.width* 0.5,
                              child: Center(
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
                                ),
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

class Changedetails extends StatelessWidget {

  Changedetails({this.icon,this.option,this.type,this.datatype,this.onsubmitted,this.onChanged});

  IconData icon;
  String option;
  String type;
  Function onsubmitted;
  TextInputType datatype;
  Function onChanged;



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    TextEditingController controller = new TextEditingController(text :type);
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    icon,
                    color: kOrangeColor,
                    size: 50,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Container(
                        height: size.height*0.04,
                        width:  size.width* 0.3,
                        child: Center(
                          child: AutoSizeText(
                            option,
                            style:TextStyle(
                                fontFamily: 'Ubuntu',
                                color: kTextColor,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w500),
                            maxFontSize: 30,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: TextField(
                      keyboardType: datatype,
                      controller: controller,
                      decoration: kTextFieldDecoration,
                      onChanged: onChanged,
                      onSubmitted: onsubmitted,
                    ),
                  ),
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
    );
  }
}

class TabWidget extends StatelessWidget {
  TabWidget({this.tabContent, this.tabIcon, this.ontap, this.color});
  IconData tabIcon;
  String tabContent;
  Function ontap;
  Color color;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return GestureDetector(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              tabIcon,
              size: (orientation == Orientation.landscape)
                  ? size.width * 0.03
                  : size.height * 0.03,
              color: color,
            ),
            Text(
              tabContent,
              style: TextStyle(fontFamily: 'Ubuntu', color: color),
            ),
          ],
        ),
        onTap: ontap,
      );
  }
}

class Changedetails1 extends StatelessWidget {

  Changedetails1({this.icon,this.option,this.type,this.datatype,this.onsubmitted,this.onChanged});

  IconData icon;
  String option;
  DateTime type;
  Function onsubmitted;
  TextInputType datatype;
  Function onChanged;
  DateTime typedate;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    icon,
                    color: kOrangeColor,
                    size: 50,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Container(
                        height: size.height*0.04,
                        width:  size.width* 0.3,
                        child: Center(
                          child: AutoSizeText(
                            option,
                            style:TextStyle(
                                fontFamily: 'Ubuntu',
                                color: kTextColor,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w500),
                            maxFontSize: 30,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: InputDatePickerFormField(
                        fieldLabelText: '',
                        initialDate: type,
                       // labestyle:  TextStyle(
                         // fontWeight: FontWeight.bold,
                         // color: kWidgetColor,
                        //),
                        errorFormatText: 'Invalid Format Entered',
                        errorInvalidText: 'Invalid Text Entered',
                        firstDate: DateTime(1930,1,1),
                        lastDate: DateTime.now(),
                        onDateSubmitted: onChanged,
                      ),
//                    child: TextField(
//                      keyboardType: datatype,
//                      controller: controller,
//                      decoration: kTextFieldDecoration,
//                      onChanged: onChanged,
//                      onSubmitted: onsubmitted,
//                    ),
                  ),
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
    );
  }
}

