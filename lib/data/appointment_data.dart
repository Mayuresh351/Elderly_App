import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentData{
  String uid;
  AppointmentData({this.uid});

  final CollectionReference appointmentDataCollection = Firestore.instance.collection('Appointments');

  Future addAppointment(String appointmentName) async{
    return await appointmentDataCollection.document(uid).setData({
      'Appoinment Name': appointmentName,
    });
  }
}