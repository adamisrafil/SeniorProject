import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import 'package:SeniorProject/userManager.dart';
import 'package:SeniorProject/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class userLog extends StatefulWidget {
  @override
  _userLogState createState() => new _userLogState();
}

class _userLogState extends State<userLog> {
  String accountStatus = '******';
  FirebaseUser mCurrentUser;
  FirebaseAuth _auth;
  User updatedUser = new User();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  var userManager = new UserManager();
  String usersName = "Go to settings and update";

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _getCurrentUser();
    print('here outside async');

  }
  _getCurrentUser () async {
    mCurrentUser = await _auth.currentUser();
    print('Hello ' + mCurrentUser.uid);
    setState(() {
      mCurrentUser != null ? accountStatus = 'Signed In' : 'Not Signed In';
    });
    _getName();
  }
  _getName() async{
    await userManager.getUserName(mCurrentUser.uid).then((String res) {
      print("Name incoming: " + res);
      setState(() {
        res != null ? usersName = res.toString() : "Having trouble";
      });
    });
  }

  Widget allUsers() {
    Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
      return ListTile (
        title: Row(
          children: [
            Text(
              "ID: " + document['ID'].toString() + " ",
              style: TextStyle(fontSize: 11),
            ),
            Text(
              "NAME: " + document['name'].toString() + " ",
              style: TextStyle(fontSize: 11),
            ),
            Text(
              "ROLE: " + document['role'].toString() + " ",
              style: TextStyle(fontSize: 11),
            ),
          ],
        ),
      );
    }

    Widget build(BuildContext context) {
      return new Scaffold(
          appBar: new AppBar(
            title: new Text('Scanner'),
          ),
          body: StreamBuilder(
              stream: Firestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Loading...');
                return ListView.builder(
                  itemExtent: 100.0,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) => _buildListItem(context, snapshot.data.documents[index]),
                );
              }
          )
      );
    }
  }

  Widget students() {
    Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
      return ListTile (
        title: Row(
          children: [
            Text(
              "ID: " + document['ID'].toString() + " ",
              style: TextStyle(fontSize: 11),
            ),
            Text(
              "NAME: " + document['name'].toString() + " ",
              style: TextStyle(fontSize: 11),
            ),
            Text(
              "EMAIL: " + document['email'].toString() + " ",
              style: TextStyle(fontSize: 11),
            ),
          ],
        ),
      );
    }

    Widget build(BuildContext context) {
      return new Scaffold(
          appBar: new AppBar(
            title: new Text('Scanner'),
          ),
          body: StreamBuilder(
              stream: Firestore.instance.collection('users').where("role", isEqualTo: "student").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Loading...');
                return ListView.builder(
                  itemExtent: 100.0,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) => _buildListItem(context, snapshot.data.documents[index]),
                );
              }
          )
      );
    }
  }

  Widget professors() {
    Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
      return ListTile (
        title: Row(
          children: [
            Text(
              "ID: " + document['ID'].toString() + " ",
              style: TextStyle(fontSize: 11),
            ),
            Text(
              "NAME: " + document['name'].toString() + " ",
              style: TextStyle(fontSize: 11),
            ),
            Text(
              "EMAIL: " + document['email'].toString() + " ",
              style: TextStyle(fontSize: 11),
            ),
          ],
        ),
      );
    }

    Widget build(BuildContext context) {
      return new Scaffold(
          appBar: new AppBar(
            title: new Text('Scanner'),
          ),
          body: StreamBuilder(
              stream: Firestore.instance.collection('users').where("role", isEqualTo: "professor").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Loading...');
                return ListView.builder(
                  itemExtent: 100.0,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) => _buildListItem(context, snapshot.data.documents[index]),
                );
              }
          )
      );
    }
  }
  Widget security() {
    Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
      return ListTile (
        title: Row(
          children: [
            Text(
              "ID: " + document['ID'].toString() + " ",
              style: TextStyle(fontSize: 11),
            ),
            Text(
              "NAME: " + document['name'].toString() + " ",
              style: TextStyle(fontSize: 11),
            ),
            Text(
              "EMAIL: " + document['email'].toString() + " ",
              style: TextStyle(fontSize: 11),
            ),
          ],
        ),
      );
    }

    Widget build(BuildContext context) {
      return new Scaffold(
          appBar: new AppBar(
            title: new Text('Scanner'),
          ),
          body: StreamBuilder(
              stream: Firestore.instance.collection('users').where("role", isEqualTo: "security").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Loading...');
                return ListView.builder(
                  itemExtent: 100.0,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) => _buildListItem(context, snapshot.data.documents[index]),
                );
              }
          )
      );
    }
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: new AppBar(
          title: new Text("User Log"),
          elevation:
          Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
          bottom: TabBar(tabs: [
            Tab(text: 'All Users'),
            Tab(text: 'Students'),
            Tab(text: 'Professors'),
            Tab(text: 'Security'),
          ]),
        ),
        body: TabBarView(
          children: [
            allUsers(),
            students(),
            professors(),
            security(),
            //put new class stateless widget here and in the new class call pagewiselistview
          ],
        ),),
    );
  }
}
