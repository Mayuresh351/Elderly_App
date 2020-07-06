import 'package:elderlyapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:elderlyapp/data/userdata.dart';
import 'package:elderlyapp/components.dart';

class DoctorApptPage extends StatefulWidget {
  static String id = 'DoctorApptPage';
  UserData user = UserData();
  @override
  _DoctorApptPageState createState() => _DoctorApptPageState();
}

class _DoctorApptPageState extends State<DoctorApptPage> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;

  @override
  void initState() {
    super.initState();
    _events = {};
    _selectedEvents = [];
    widget.user.getAppointments().then((appts){
      if(appts != null){
        List<DateTime> Dates = [];
        List<List<dynamic>> Event = [];
        Iterable<String> KeyList = appts.data['Events'].keys;
        print(appts.data['Events'].values.runtimeType);
        Iterable<dynamic> ValList = appts.data['Events'].values;
        for(var i in KeyList){
          Dates.add(DateTime.parse(i));
        }
        for(var i in ValList){
          Event.add(i);
        }
        Map<DateTime,List<dynamic>> NewEvents = Map.fromIterables(Dates, Event);
//        for(int i=0;i<KeyList.length;i++){
//          DateTime Date1 = Dates[i];
//          List<dynamic> Ev = Event[i];
//          print(Date1);
//          print(Ev);
//          NewEvents.addAll({Date1:Ev});
//        }
        setState(() {
          _events = NewEvents;
        });
      }
    });
    _controller = CalendarController();
    _eventController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    {
      return Scaffold(
        appBar: AppBar(
          title: Text('Appointment Settings'),
          centerTitle: true,
          backgroundColor: Color(0xFF65376A),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TableCalendar(
                  events: _events,
                  initialCalendarFormat: CalendarFormat.month,
                  calendarStyle: CalendarStyle(
                      canEventMarkersOverflow: true,
                      todayColor: Color(0xFFCBB6AF),
                      selectedColor: Colors.deepOrange,
                      todayStyle: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      )),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  onDaySelected: (day, events) {
                    setState(() {
                      _selectedEvents = events;
                    });
                  },
                  calendarController: _controller,
                ),
                ..._selectedEvents.map(
                      (event) => ListTile(
                    title: Text(
                      event,
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 20,
                      ),
                    ),
                    onLongPress: (){
                      _selectedEvents.remove(event);
                      widget.user.updateAppointments(_events);
                    },
                  ),
                ),
                Container(
                  child: Text(
                    'Long Press Appointment Text to DELETE',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: kLightTextColor
                    ),
                  ),
                ),
              ],
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print(_events);
            _showAddDialog();
          },
          child: Icon(Icons.add),
          tooltip: 'Add Other Appointments',
        ),
        bottomNavigationBar: BottomBar(),
      );
    }
  }

  _showAddDialog() {
    String time;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          style: TextStyle(
            fontSize: 20.0,
          ),
          controller: _eventController,
        ),
        actions: <Widget>[
          FlatButton(
              child: Text('Time'),
              onPressed: () async {
                TimeOfDay timeclock = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());
                if (timeclock.hour.toInt() > 11) {
                  if(timeclock.minute.toInt() < 10){
                    time = (timeclock.hour.toInt() - 12).toString() +
                        ':' + ' 0' +
                        timeclock.minute.toString() +
                        ' pm';
                  }else{
                    time = (timeclock.hour.toInt() - 12).toString() +
                        ':' +
                        timeclock.minute.toString() +
                        ' pm';
                  }
                } else {
                  if(timeclock.minute.toInt() < 10){
                    time = timeclock.hour.toString() +
                        ':' +' 0' +
                    timeclock.minute.toString() +
                        ' pm';
                  }else{
                    time = timeclock.hour.toString() +
                        ':' +
                        timeclock.minute.toString() +
                        ' pm';
                  }
                }
              }),
          FlatButton(
            child: Text('Save'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            onPressed: () {
              if (_eventController.text.isEmpty) return;
              setState(() {
                if (_events[_controller.selectedDay] != null) {
                  _eventController.text = _eventController.text + ' At ' + time;
                  _events[_controller.selectedDay].add(_eventController.text);
                } else {
                  _eventController.text = _eventController.text + ' At ' + time;
                  _events[_controller.selectedDay] = [_eventController.text];
                }
                _eventController.clear();
                print(_events);
                widget.user.updateAppointments(_events);
                Navigator.pop(context);
                setState(() {

                });
              });
            },
          )
        ],
      ),
    );
  }
}
