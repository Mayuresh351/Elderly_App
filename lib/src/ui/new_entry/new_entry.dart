import 'dart:math';
import 'dart:typed_data';
import 'package:elderlyapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:elderlyapp/src/common/convert_time.dart';
import 'package:elderlyapp/src/global_bloc.dart';
import 'package:elderlyapp/src/models/errors.dart';
import 'package:elderlyapp/src/models/medicine.dart';
import 'package:elderlyapp/src/models/medicine_type.dart';
import 'package:elderlyapp/src/ui/homepage/homepage.dart';
import 'package:elderlyapp/src/ui/new_entry/new_entry_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:elderlyapp/components.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:elderlyapp/screens/homepage.dart';

class NewEntry extends StatefulWidget {
  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  TextEditingController nameController;
  TextEditingController dosageController;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  NewEntryBloc _newEntryBloc;
  Color kWidgetColor = Color(0xFF65376A);

  GlobalKey<ScaffoldState> _scaffoldKey;

  void dispose() {
    super.dispose();
    nameController.dispose();
    _newEntryBloc.dispose();
  }

  void initState() {
    super.initState();
    _newEntryBloc = NewEntryBloc();
    nameController = TextEditingController();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    initializeNotifications();
    initializeErrorListen();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kWidgetColor,
        iconTheme: IconThemeData(
          color: kWidgetColor,
        ),
        centerTitle: true,
        title: Text(
          "Add New Reminder",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
        child: Provider<NewEntryBloc>.value(
          value: _newEntryBloc,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            children: <Widget>[
              PanelTitle(
                title: "Medicine Name",
                isRequired: true,
              ),
              TextFormField(
                maxLength: 12,
                style: TextStyle(
                  fontSize: 16,
                ),
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),

              PanelTitle(
                title: "Medicine Type",
                isRequired: false,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: StreamBuilder<MedicineType>(
                  stream: _newEntryBloc.selectedMedicineType,
                  builder: (context, snapshot) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        MedicineTypeColumn(
                            type: MedicineType.Bottle,
                            name: "Bottle",
                            iconValue: 0xe900,
                            isSelected: snapshot.data == MedicineType.Bottle
                                ? true
                                : false),
                        MedicineTypeColumn(
                            type: MedicineType.Pill,
                            name: "Pill",
                            iconValue: 0xe901,
                            isSelected: snapshot.data == MedicineType.Pill
                                ? true
                                : false),
                        MedicineTypeColumn(
                            type: MedicineType.Syringe,
                            name: "Syringe",
                            iconValue: 0xe902,
                            isSelected: snapshot.data == MedicineType.Syringe
                                ? true
                                : false),
                        MedicineTypeColumn(
                            type: MedicineType.Tablet,
                            name: "Tablet",
                            iconValue: 0xe903,
                            isSelected: snapshot.data == MedicineType.Tablet
                                ? true
                                : false),
                      ],
                    );
                  },
                ),
              ),
              PanelTitle(
                title: "Interval Selection",
                isRequired: true,
              ),
              //ScheduleCheckBoxes(),
              IntervalSelection(),
              PanelTitle(
                title: "Starting Time",
                isRequired: true,
              ),
              SelectTime(),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.height * 0.08,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: FlatButton(
                        color: Colors.red,
                        shape: CircleBorder(),
                        child: Icon(Icons.close,size: 45,color: Colors.white,),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: Container(
                      width: 70,
                      height: 70,
                      child: FlatButton(
                        color: Colors.green,
                        shape: CircleBorder(),
                        child: Icon(Icons.check,size: 45,color: Colors.white,),
                        onPressed: () {
                          String medicineName;
                          int dosage;
                          if (nameController.text == "") {
                            _newEntryBloc.submitError(EntryError.NameNull);
                            return;
                          }
                          if (nameController.text != "") {
                            medicineName = nameController.text;
                          }
                          for (var medicine in _globalBloc.medicineList$.value) {
                            if (medicineName == medicine.medicineName) {
                              _newEntryBloc.submitError(EntryError.NameDuplicate);
                              return;
                            }
                          }
                          if (_newEntryBloc.selectedInterval$.value == 0) {
                            _newEntryBloc.submitError(EntryError.Interval);
                            return;
                          }
                          if (_newEntryBloc.selectedTimeOfDay$.value == "None") {
                            _newEntryBloc.submitError(EntryError.StartTime);
                            return;
                          }
                          String medicineType = _newEntryBloc
                              .selectedMedicineType.value
                              .toString()
                              .substring(13);
                          int interval = _newEntryBloc.selectedInterval$.value;
                          String startTime = _newEntryBloc.selectedTimeOfDay$.value;

                          List<int> intIDs =
                          makeIDs(24 / _newEntryBloc.selectedInterval$.value);
                          List<String> notificationIDs = intIDs
                              .map((i) => i.toString())
                              .toList(); //for Shared preference

                          Medicine newEntryMedicine = Medicine(
                            notificationIDs: notificationIDs,
                            medicineName: medicineName,
//                        dosage: dosage,
                            medicineType: medicineType,
                            interval: interval,
                            startTime: startTime,
                          );

                          _globalBloc.updateMedicineList(newEntryMedicine);
                          scheduleNotification(newEntryMedicine);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void initializeErrorListen() {
    _newEntryBloc.errorState$.listen(
      (EntryError error) {
        switch (error) {
          case EntryError.NameNull:
            displayError("Please enter the medicine's name");
            break;
          case EntryError.NameDuplicate:
            displayError("Medicine name already exists");
            break;
          case EntryError.Interval:
            displayError("Please select the reminder's interval");
            break;
          case EntryError.StartTime:
            displayError("Please select the reminder's starting time");
            break;
          default:
        }
      },
    );
  }

  void displayError(String error) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(error),
        duration: Duration(milliseconds: 2000),
      ),
    );
  }

  List<int> makeIDs(double n) {
    var rng = Random();
    List<int> ids = [];
    for (int i = 0; i < n; i++) {
      ids.add(rng.nextInt(1000000000));
    }
    return ids;
  }

  initializeNotifications() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  Future<void> scheduleNotification(Medicine medicine) async {
    var hour = int.parse(medicine.startTime[0] + medicine.startTime[1]);
    var ogValue = hour;
    var minute = int.parse(medicine.startTime[2] + medicine.startTime[3]);
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'repeatDailyAtTime channel id',
      'repeatDailyAtTime channel name',
      'repeatDailyAtTime description',
      importance: Importance.Max,
      priority: Priority.High,
      sound: RawResourceAndroidNotificationSound('bestreminder'),
      ledColor: Color(0xFF3EB16F),
      ledOffMs: 1000,
      ledOnMs: 1000,
      enableLights: true,
      vibrationPattern: vibrationPattern,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    for (int i = 0; i < (24 / medicine.interval).floor(); i++) {
      if ((hour + (medicine.interval * i) > 23)) {
        hour = hour + (medicine.interval * i) - 24;
      } else {
        hour = hour + (medicine.interval * i);
      }
      print(hour);
      print(minute);
      await flutterLocalNotificationsPlugin.showDailyAtTime(
          int.parse(medicine.notificationIDs[i]),
          'Elderly: ${medicine.medicineName}',
          medicine.medicineType.toString() != MedicineType.None.toString()
              ? 'It is time to take your ${medicine.medicineType.toLowerCase()}, according to schedule'
              : 'It is time to take your medicine, according to schedule',
          Time(hour, minute, 0),
          platformChannelSpecifics,
      payload: 'Custom_Sound');
      hour = ogValue;
    }
    //await flutterLocalNotificationsPlugin.cancelAll();
  }
}

class IntervalSelection extends StatefulWidget {
  @override
  _IntervalSelectionState createState() => _IntervalSelectionState();
}

class _IntervalSelectionState extends State<IntervalSelection> {
  var _intervals = [
    6,
    8,
    12,
    24,
  ];
  var _selected = 0;

  @override
  Widget build(BuildContext context) {
    final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Remind me every  ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            DropdownButton<int>(
              iconEnabledColor: Color(0xFF3EB16F),
              hint: _selected == 0
                  ? Text(
                      "Select an Interval",
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    )
                  : null,
              elevation: 4,
              value: _selected == 0 ? null : _selected,
              items: _intervals.map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    value.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  _selected = newVal;
                  _newEntryBloc.updateInterval(newVal);
                });
              },
            ),
            Text(
              _selected == 1 ? " hour" : " hours",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
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
  Color kWidgetColor = Color(0xFF65376A);

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context,listen: false);
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;
        _newEntryBloc.updateTime("${convertTime(_time.hour.toString())}" +
            "${convertTime(_time.minute.toString())}");
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
          color: kWidgetColor,
          shape: StadiumBorder(),
          onPressed: () {
            _selectTime(context);
          },
          child: Center(
            child: Text(
              _clicked == false
                  ? "Pick Time"
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

class MedicineTypeColumn extends StatelessWidget {
  final MedicineType type;
  final String name;
  final int iconValue;
  final bool isSelected;

  MedicineTypeColumn(
      {Key key,
      @required this.type,
      @required this.name,
      @required this.iconValue,
      @required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);
    return GestureDetector(
      onTap: () {
        _newEntryBloc.updateSelectedMedicine(type);
      },
      child: Column(
        children: <Widget>[
          Container(
            width: (orientation == Orientation.landscape)?size.height*0.20:size.width*0.20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelected ? kOrangeColor : Colors.white,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 14.0),
                child: Icon(
                  IconData(iconValue, fontFamily: "Ic"),
                  size: 75,
                  color: isSelected ? Colors.white : kOrangeColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Container(
              width: (orientation == Orientation.landscape)?size.height*0.20:size.width*0.20,
              height: 30,
              decoration: BoxDecoration(
                color: isSelected ? kOrangeColor : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected ? Colors.white : kOrangeColor,
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
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
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
