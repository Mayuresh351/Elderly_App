import 'package:cloud_firestore/cloud_firestore.dart';

class MedreminderData{
  String uid;
  MedreminderData({this.uid});

  final CollectionReference medreminderCollection = Firestore.instance.collection('Medreminder');

  Future addMedreminder(String medicineName, int type, int day) async{
    return await medreminderCollection.document(uid).setData({
      'Medicine Name': medicineName,
      'Medicine Type': type,
      'Days': day,
    });
  }
}