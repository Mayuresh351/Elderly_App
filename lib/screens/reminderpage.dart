import 'package:flutter/material.dart';
import 'package:elderlyapp/src/global_bloc.dart';
import 'package:elderlyapp/src/ui/homepage/homepage.dart';
import 'package:provider/provider.dart';

class MedicineReminder extends StatefulWidget {
  static String id = 'MedicineReminder';
  @override
  _MedicineReminderState createState() => _MedicineReminderState();
}

class _MedicineReminderState extends State<MedicineReminder> {
  GlobalBloc globalBloc;

  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
          brightness: Brightness.light,
        ),
        home: HomePage2(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}