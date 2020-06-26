
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserData{

  static bool signout = false;
//  String uid;
//  String Id;
//  String Name = '';
//  String email = '';
//  String Password = '';
//  String language = '';
//  String type = '';
  List<String> languagelist = ['English','Hindi','Telugu'];
  List<String> typelist = ['Guardian','Elder'];
  var data;
//  String Contact = '';
//  String Emergency = '';
//  String Pharmacy = '';

  Future<FirebaseUser> Login(String email, String Password)async{
    try{
      final newUser = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: Password);
      return newUser.user;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<FirebaseUser> currentUser()async{
  try{
    final User = await FirebaseAuth.instance.currentUser();
    return User;
  }
  catch(e){
    print(e);
    return null;
  }
  }
  void Signout()async{
    await FirebaseAuth.instance.signOut();
  }
  Future updateData(String Name, String language,String type,DateTime birthday)async{
    final user = await FirebaseAuth.instance.currentUser();
    print(user.uid);
    Timestamp birth = Timestamp.fromDate(birthday);
    print(birth);
    final CollectionReference Collection = Firestore.instance.collection('Userdata');
    return await Collection.document(user.uid).setData({
      'Name' : Name,
      'Language' : language,
      'type' : type,
      'Contact' : '',
      'Emergency' : '',
      'Pharmacy' : '',
      'Birthday' : birth,
    });

//  return Firestore.instance.collection('Userdata').add({
//      'Name' : Name,
//      'Language' : language,
//      'type' : type,
//      'Contact' : Contact,
//      'Emergency' : Emergency,
//      'Pharmacy' : Pharmacy,
//  });
  }
  Future<FirebaseUser> SignUp(String email, String Password,String Name, String language,String type,DateTime birthday)async{
    try{
      Timestamp birth = Timestamp.fromDate(birthday);
      final newUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: Password);
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: Password);
      await updateData(Name,language,type,birthday);
      return newUser.user;
    }catch(e){
      print(e);
      return null;
    }
  }
  Future<DocumentSnapshot> getData()async{
    try{
      final user = await FirebaseAuth.instance.currentUser();
      print(user.uid);
      final CollectionReference Collection = await Firestore.instance.collection('Userdata');
      var userdata = Collection.document(user.uid).get();
        print(userdata);
        return userdata;
    }catch(e){
      print(e);
      return null;
    }
  }
   Future updateAccSettings(String Name,DateTime birthday)async{
    try{
      print(birthday);
      print('yo');
      Timestamp birth = Timestamp.fromDate(birthday);
      print(birth);
      var user = await FirebaseAuth.instance.currentUser();
      final CollectionReference Collection = await Firestore.instance.collection('Userdata');
      await Collection.document(user.uid).updateData({'Name': Name,'Birthday':birthday});
      return 1;
    }catch(e){
      print(e);
      return null ;
    }
  }
  Future updateContactSettings(String Contact,String Emergcency,String Pharmacy)async {
    try {
      var user = await FirebaseAuth.instance.currentUser();
      final CollectionReference Collection = await Firestore.instance
          .collection('Userdata');
      await Collection.document(user.uid).updateData(
          {'Contact': Contact, 'Emergency': Emergcency, 'Pharmacy': Pharmacy});
      return 1;
    } catch (e) {
      print(e);
      return null;
    }
  }
}