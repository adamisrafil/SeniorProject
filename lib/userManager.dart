import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserManager {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final Firestore _firestoreDB = Firestore.instance;

    Future<FirebaseUser> getCurrentUser() async {
      FirebaseUser user = await _firebaseAuth.currentUser();
      return user;
    }

    Future<String> getUserID() async {
      FirebaseUser user = await _firebaseAuth.currentUser();
      return user.uid;
    }

    Future<String> getUserEmail() async {
      FirebaseUser user = await _firebaseAuth.currentUser();
      return user.email;
    }

    Future<String> getUserName() async {
      FirebaseUser user = await _firebaseAuth.currentUser();
    }
}
