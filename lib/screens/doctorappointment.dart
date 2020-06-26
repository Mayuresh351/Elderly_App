import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DoctorApptPage extends StatefulWidget {
  static String id = 'DoctorApptPage';
  @override
  _DoctorApptPageState createState() => _DoctorApptPageState();
}

class _DoctorApptPageState extends State<DoctorApptPage> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>>_events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
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
            child:Column(
              children: <Widget>[
                TableCalendar(
                  events: _events,
                  initialCalendarFormat: CalendarFormat.month,
                  calendarStyle: CalendarStyle(
                      canEventMarkersOverflow: true,
                      todayColor:  Color(0xFFCBB6AF),
                      selectedColor: Colors.deepOrange,
                      todayStyle: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      )
                  ),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  onDaySelected: (day,events) {
                    setState(() {
                      _selectedEvents = events;
                    });
                  },
                  calendarController: _controller,
                ),
                ... _selectedEvents.map((event) => ListTile(
                  title: Text(event),
                )),
              ],
            )
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddDialog();
          },
          child: Icon(Icons.add),
          tooltip: 'Add Other Appointments',
        ),
      );
    }
  }
  _showAddDialog() {
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
            onPressed: () {
              showTimePicker(context: context, initialTime: TimeOfDay.now(),
              );
            },
          ),
          FlatButton(
            child: Text('Save'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            onPressed: () {
              if(_eventController.text.isEmpty) return;
              setState(() {


                if(_events[_controller.selectedDay]!= null) {
                  _events[_controller.selectedDay].add
                    (_eventController.text);
                }else{
                  _events[_controller.selectedDay] = [_eventController.text];
                }
                _eventController.clear();
                Navigator.pop(context);
              });
            },
          )
        ],
      ),
    );
  }
}
