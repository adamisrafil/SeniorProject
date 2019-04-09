import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:SeniorProject/user.dart';

class UserManager {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final Firestore _firestoreDB = Firestore.instance;


    Future<void> updateUser(User user, String uid) async {
      Map<String, dynamic> userData = Map();
      userData["name"] = user.name;
      userData["ID"] = user.ID;
//      userData["Role"] = user.role;
      Firestore.instance.collection("users").document(uid).setData(userData, merge: true);
    }

    Future<String> getUserEmail(String userID) async {
      print("we called the getUserEmail function");
      DocumentSnapshot snapshot = await Firestore.instance.collection("users").document(userID).get();
      var userEmail = snapshot['email'];
      if (userEmail is String){
        print("we got the email captain");
        return userEmail;
      }
      else{
        return "Error getting email";
      }
    }

    Future<String> getUserName(String userID) async {
      print("we called the getUserName function");
      DocumentSnapshot snapshot = await Firestore.instance.collection("users").document(userID).get();
      var userName = snapshot['name'];
      if (userName is String){
        print("we got the name captain");
        return userName;
      }
      else{
        return "Error getting name";
      }
    }

    Future<String> getUserNYITIDNumber(String userID) async {
      print("we called the getUserIDNumber function");
      DocumentSnapshot snapshot = await Firestore.instance.collection("users").document(userID).get();
      var userNYITID = snapshot['ID'];
      if (userNYITID is String){
        print("we got the NYIT ID captain");
        return userNYITID;
      }
      else{
        return "Error getting NYIT ID";
      }
    }
}
