import 'package:flutter/material.dart';
import 'medicine_type.dart';
import 'suscess_screen.dart';
import 'error.dart';
import'new_entry_bloc.dart';
import 'medicine.dart';
//import 'daily_medication_schedule.dart';
class NewEntry extends StatefulWidget {
  @override
  _NewEntryState createState() => _NewEntryState();
}
class _NewEntryState extends State<NewEntry> {
  var _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
    'Everyday'
  ];
  var _currentdaySelected;
  TextEditingController nameController;
  GlobalKey<ScaffoldState> _scaffoldKey;
  NewEntryBloc _newEntryBloc;
  void dispose() {
    super.dispose();
    nameController.dispose();
    _newEntryBloc.dispose();
  }
  void initState() {
    super.initState();
    _newEntryBloc = NewEntryBloc();
    nameController = TextEditingController();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    // initializeErrorListen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Add New Mediminder'),
        centerTitle: true,
        backgroundColor: Color(0xFF65376A),
        elevation: 0.0,
      ),
      body: Container(
        child:ListView(
            children: <Widget>[
              PanelTitle(
                title: "Medicine Name",
                isRequired: true,
              ),
              TextFormField(
             //   maxLength: 25,
                style: TextStyle(
                  fontSize: 20,
                ),
                controller: nameController,
                // textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              Container(
                  child: Text(
                    "Medicine Type",
                    style: TextStyle(
                      fontSize: 20,
                        color: Colors.black, fontWeight: FontWeight.w500
                    ),
                  ),
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: StreamBuilder<MedicineType>(
                    stream: _newEntryBloc.selectedMedicineType,
                    builder: (context, snapshot) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                           Container(
                           //  type: MedicineType.Pill,
                           //  name: "Pill",
                          //   isSelected: snapshot.data == MedicineType.Pill
                             //    ? true
                             //    : false,
                             width: 50.0,
                             height: 70.0,
                             decoration: BoxDecoration(
                               image: DecorationImage(
                                 image: AssetImage('images/pills.png')
                               ),
                             ),
                           ),

                          Container(
                          //  type: MedicineType.Bottle,
                         //   name: "Bottle",
                          //  isSelected: snapshot.data == MedicineType.Bottle
                           //     ? true
                          //      : false,
                            width: 50.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/medicine.png'),

                              ),
                            ),
                          ),
                          Container(
                         //   type: MedicineType.Tablet,
                         //   name: "Tablet",
                         //   isSelected: snapshot.data == MedicineType.Tablet
                         //       ? true
                         //       : false,
                            width: 50.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/capsule.png')
                              ),
                            ),
                          ),
                          Container(
                        //    type: MedicineType.Syringe,
                        //    name: "Syringe",
                         //   isSelected: snapshot.data == MedicineType.Syringe
                          //      ? true
                          //      : false,
                            width: 50.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/injection.png')
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                ),
              ),
             // SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: StreamBuilder<MedicineType>(
                    stream: _newEntryBloc.selectedMedicineType,
                    builder: (context, snapshot) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          MedicineTypeColumn(
                              type: MedicineType.Pill,
                              name: "Pill",

                              isSelected: snapshot.data == MedicineType.Pill
                                  ? true
                                  : false
                          ),
                          MedicineTypeColumn(
                              type: MedicineType.Bottle,
                              name: "Bottle",

                              isSelected: snapshot.data == MedicineType.Tablet
                                  ? true
                                  : false
                          ),
                          MedicineTypeColumn(
                              type: MedicineType.Tablet,
                              name: "Tablet",

                              isSelected: snapshot.data == MedicineType.Bottle
                                  ? true
                                  : false
                          ),
                          MedicineTypeColumn(
                              type: MedicineType.Syringe,
                              name: "Syringe",

                              isSelected: snapshot.data == MedicineType.Syringe
                                  ? true
                                  : false
                          ),
                        ],
                      );
                    }
                ),
              ),
              SizedBox(height: 15.0),
              DropdownButton(
                items: _days.map((value)=>DropdownMenuItem(
                  child: Text(
                    value,
                  ),
                  value:value,
                )).toList(),
                onChanged:(newValueSelected) {
                  setState(() {
                    _currentdaySelected = newValueSelected;
                  });
                },
                value:_currentdaySelected,
                hint: Text("Day",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w500,color: Colors.black)),
                dropdownColor: Colors.cyanAccent,
              ),
              SizedBox(height: 15.0),
              SelectTime(),
              SizedBox(height: 170.0),
              FlatButton(
                  color: Colors.purple,
                  shape: StadiumBorder(),
                  child: Center(
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  onPressed: () {
                    String medicineName;
                    if (nameController.text == "") {
                      _newEntryBloc.submitError(EntryError.NameNull);
                      return;
                    }
                    if (nameController.text != "") {
                      medicineName = nameController.text;
                    }
                    if (_newEntryBloc.selectedTimeOfDay$.value == "None") {
                      _newEntryBloc.submitError(EntryError.SelectTime);
                      return;
                    }
                    String medicineType = _newEntryBloc
                        .selectedMedicineType.value
                        .toString()
                        .substring(13);
                    String selectTime = _newEntryBloc.selectedTimeOfDay$.value;
                    Medicine newEntryMedicine = Medicine(
                      medicineName: medicineName,
                      medicineType: medicineType,
                      selectTime: selectTime,
                    );
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: ((context) => SuccessScreenDetails()),
                    ));
                  }
              ),]
        ),
      ),
    );
  }
}
//void initializeErrorListen() {
//   _newEntryBloc.errorState$.listen(
//       (EntryError error) {
//   switch (error) {
//   case EntryError.NameNull:
//   displayError("Please enter the medicine's name");
// break;
//  case EntryError.NameDuplicate:
//   displayError("Medicine name already exists");
//   break;
//   case EntryError.SelectTime:
//   displayError("Please select the reminder's selecting time");
//   break;
//  default:
// }
//   },
//  );
//  }
//  void displayError(String error) {
//    _scaffoldKey.currentState.showSnackBar(
//     SnackBar(
//      backgroundColor: Colors.red,
//     content: Text(error),
//     duration: Duration(milliseconds: 2000),
//     ),
//    );
//   }
class MedicineTypeColumn extends StatelessWidget {
  final MedicineType type;
  final String name;
  final bool isSelected;



  MedicineTypeColumn(
      {Key key,
        @required this.type,
        @required this.name,
       @required this.isSelected,

       })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Column(
        children: <Widget>[
          Container(
            width: 85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            //  color: isSelected ? Color(0xFF3EB16F) : Colors.white,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 14.0),
              //  child: Icon(
                //  IconData(decoration),
               //   size: 75,
             //   ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF3EB16F) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected ? Colors.white : Color(0xFF3EB16F),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
class PanelTitle extends StatelessWidget {
  final String title;
  final bool isRequired;
  PanelTitle({
    Key key,
    @required this.title,
    @required this.isRequired,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, bottom: 4),
      child: Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(
            text: title,
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: isRequired ? " *" : "",
            style: TextStyle(fontSize: 14, color: Colors.red),
          ),
        ]),
      ),
    );
  }
}
class SelectTime extends StatefulWidget {
  @override
  _SelectTimeState createState() => _SelectTimeState();
}
class _SelectTimeState extends State<SelectTime> {
  TimeOfDay _time = TimeOfDay(hour: 0, minute: 00);
  bool _clicked = false;
  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;
      });
    }
    return picked;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0, bottom: 4),
        child: FlatButton(
          color: Colors.purple,
          shape: StadiumBorder(),
          onPressed: () {
            _selectTime(context);
          },
          child: Center(
            child: Text(
              _clicked == false
                  ? "Select Time"
                  : "${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
String convertTime(String minutes) {
  if (minutes.length == 1) {
    return "0" + minutes;
  } else {
    return minutes;
  }
}
