import 'package:flutter/material.dart';
import 'package:SeniorProject/userManager.dart';
import 'package:SeniorProject/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SeniorProject/root_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserSettingsPage extends StatefulWidget {
  UserSettingsPage({this.userManager, this.auth, this.root});
  final RootPage root;
  final BaseAuth auth;
  final UserManager userManager;

  @override
  _UserSettingsPage createState() => new _UserSettingsPage();
}

class _UserSettingsPage extends State<UserSettingsPage> {
  @override

  String accountStatus = '******';
  FirebaseUser mCurrentUser;
  FirebaseAuth _auth;

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
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Settings'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Form(
            child: new ListView(
              children: <Widget>[
                new TextFormField(
                  decoration: new InputDecoration(
                    hintText: 'Name',
                    labelText: 'Your Name'
                  )
                ),
                new TextFormField(
                    decoration: new InputDecoration(
                        hintText: '1234567',
                        labelText: 'ID number'
                    )
                ),
                new TextFormField(
                    obscureText: true,
                    decoration: new InputDecoration(
                        hintText: 'User Role Code',
                        labelText: 'Enter code (for faculty and staff only)',
                    )
                ),
              ],
            )
        ),
      ),
    );
  }
}