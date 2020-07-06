import 'package:flutter/material.dart';
import 'package:elderlyapp/constants.dart';
import 'package:elderlyapp/data/userdata.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ContactSettings extends StatefulWidget {
  static String id = 'ContactSettings';
  @override
  _ContactSettingsState createState() => _ContactSettingsState();
}

class _ContactSettingsState extends State<ContactSettings> {
  String User_contact;
  String Emergency_Contact;
  String Pharmacy_Contact;
  bool showSpinner = false;
  int call = 0;
  bool downloaded = false;
  String downloadURL;
  var user = UserData();

  void yoyo() async {

   if(call == 0){
     final userdata = await user.getData();
     User_contact = userdata.data['Contact'];
     Emergency_Contact = userdata.data['Emergency'];
     Pharmacy_Contact = userdata.data['Pharmacy'];
     bool invalid = false;
     setState(() {});
     call++;
   }
  }
  Future downloadIt1()async {
    if (downloaded == false) {
      downloadURL = await user.downloadIt();
      setState(() {
        downloaded = true;
      });
    }
  }
  @override
  void initState(){
    super.initState();
    yoyo();
    downloadIt1().then((value) => null);
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: kWidgetColor,
        appBar: AppBar(
          backgroundColor: kWidgetColor,
          title: Text('Contact Settings'),
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
                      child: ClipOval(
                        child: (downloaded == true )?new SizedBox(
                          height: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                              ? size.height * 0.12
                              : size.width * 0.10,
                          width: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                              ? size.height * 0.12
                              : size.width * 0.10,
                          child: Image.network(downloadURL,fit: BoxFit.cover,),
                        ):new SizedBox(
                          height: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                              ? size.height * 0.12
                              : size.width * 0.10,
                          width: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                              ? size.height * 0.12
                              : size.width * 0.10,
                          child: Image.asset('images/accpro.png',fit: BoxFit.cover,),
                        ),
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
                      height: size.height * 0.60,
                      child: ListView(
                        children: <Widget>[
                          Changedetails(
                            icon: Icons.link,
                            option: 'Linked Contact',
                            type: User_contact,
                            datatype: TextInputType.phone,
                            onChanged: (value){
                              User_contact = value;
                            },
                          ),
                          Changedetails(
                            icon: Icons.error,
                            option: 'Emergency Contact',
                            type: Emergency_Contact,
                            datatype: TextInputType.phone,
                            onChanged: (value){
                              Emergency_Contact = value;
                            },
                          ),
                          Changedetails(
                            icon: Icons.local_pharmacy,
                            option: 'Pharmacy Contact',
                            type: Pharmacy_Contact,
                            datatype: TextInputType.phone,
                            onChanged: (value){
                              Pharmacy_Contact = value;
                            },
                          ),
                          FlatButton(
                            onPressed:()async{
                              setState(() {
                                showSpinner = true;
                              });
                              final status = await user.updateContactSettings(User_contact, Emergency_Contact, Pharmacy_Contact);
                              if(status != null){
                                setState(() {
//                                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('User Details Updated!!'),));
                                  showSpinner = false;
                                });
                              }
                            },
                            child: Container(
                              width: size.width * 0.7,
                              height: size.height * 0.06,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.circular(10.0),
                                color: Colors.blueAccent,
                              ),
                              child: Center(
                                child: Text(
                                  'Save Details',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
