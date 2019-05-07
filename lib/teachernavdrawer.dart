import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:SeniorProject/authentication.dart';
import 'package:SeniorProject/userManager.dart';
import 'package:SeniorProject/user.dart';

class ProfNavDrawer extends StatefulWidget {
  ProfNavDrawer({Key key, this.auth, this.userId, this.userManager, this.user})
      : super(key: key);

  final BaseAuth auth;
  final String userId;
  final UserManager userManager;
  final User user;

  @override  _NavDrawerState createState() => _NavDrawerState();
}


class _NavDrawerState extends State<ProfNavDrawer> {

  var userManager = new UserManager();
  FirebaseUser mCurrentUser;
  FirebaseAuth _auth;

  String usersEmail = "Searching...";
  String usersName = "Go to settings and update";
  String usersID;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _getCurrentUser();
    print('here outside async');
  }

  _getEmail() async{
    await userManager.getUserEmail(mCurrentUser.uid).then((String res) {
      print("Email incoming: " + res);
      setState(() {
        res != null ? usersEmail = res.toString() : "Having trouble";
      });
    });
  }
  _getName() async{
    await userManager.getUserName(mCurrentUser.uid).then((String res) {
      print("Name incoming: " + res);
      setState(() {
        res != null ? usersName = res.toString() : "Having trouble";
      });
    });
  }

  _getCurrentUser() async {
    mCurrentUser = await _auth.currentUser();
    print('Hello ' + mCurrentUser.uid);
    setState(() {
      mCurrentUser != null ? usersID = mCurrentUser.uid : "Having Trouble";
    });
    _getEmail();
    _getName();
  }

  @override  Widget build(BuildContext context) {
    return new Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the Drawer if there isn't enough vertical
      // space to fit everything.
      child: Container(
          color: Colors.white10,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  usersName,
                  style: TextStyle(color: Colors.black),
                ),
                accountEmail: Text(
                  usersEmail,
                  style: TextStyle(color: Colors.black),
                ),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new ExactAssetImage('assets/nyitlogo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Text(
                    usersName.substring(0,1).toUpperCase(),
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
//                  decoration: BoxDecoration(color: Colors.black87),
              ),
              ListTile(
                title: Text("ID Scanner"),
                leading: Icon(Icons.person_outline),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/qrPage');
                },
              ),
              ListTile(
                title: Text('Evalutation Responses'),
                leading: Icon(Icons.add_comment),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/evalResponsePage');
                },
              ),
              ListTile(
                title: Text('NYIT Forums'),
                leading: Icon(Icons.people_outline),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/forumPage');
                },
              ),
              ListTile(
                title: Text('Event Calendar'),
                leading: Icon(Icons.calendar_today),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/eventPage');
                },
              ),
              ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/userSettingsPage');
                },
              ),
            ],
          )),
    );
  }
}