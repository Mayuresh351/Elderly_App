import 'package:flutter/material.dart';
import 'package:elderlyapp/constants.dart';

class ContactSettings extends StatefulWidget {
  static String id = 'ContactSettings';
  @override
  _ContactSettingsState createState() => _ContactSettingsState();
}

class _ContactSettingsState extends State<ContactSettings> {
  String User_contact;
  String Emergency_Contact;
  String Pharmacy_Contact;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kWidgetColor,
      appBar: AppBar(
        backgroundColor: kWidgetColor,
        title: Text(
            'Contact Settings'
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

                        Changedetails(icon: Icons.link,option: 'Linked Contact',type: User_contact,datatype: TextInputType.phone,),
                        Changedetails(icon: Icons.error,option: 'Emergency Contact',type: Emergency_Contact,datatype: TextInputType.phone,),
                        Changedetails(icon: Icons.local_pharmacy,option: 'Pharmacy Contact',type: Pharmacy_Contact,datatype: TextInputType.phone,),
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
