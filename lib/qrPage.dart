import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:SeniorProject/userManager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:SeniorProject/user.dart';

import 'package:SeniorProject/authentication.dart';

class NavQrPage extends StatefulWidget {
  NavQrPage({this.userManager, this.auth, this.user});

  final User user;
  final BaseAuth auth;
  final UserManager userManager;
  @override
  _NavQrPageState createState() => new _NavQrPageState();
}

class _NavQrPageState extends State<NavQrPage> {
  FirebaseUser mCurrentUser;
  FirebaseAuth _auth;
  String UserID = "****";
  User updatedUser = new User();
  var userManager = new UserManager();

  String usersName = "Not on record";
  String usersNYITID = "Not on record";

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
      mCurrentUser != null ? UserID = mCurrentUser.uid : "Having trouble retriving UID";
    });

    _getName();
    _getNYITID();
  }

  _getName() async{
    await userManager.getUserName(UserID).then((String res) {
      print("Name incoming: " + res);
      setState(() {
        res != null ? usersName = res.toString() : "Having trouble";
      });
    });
  }

  _getNYITID() async{
    await userManager.getUserNYITIDNumber(UserID).then((String res) {
      print("ID incoming: " + res);
      setState(() {
        res != null ? usersNYITID = res.toString() : "Having trouble";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('QR ID'),
      ),
      body: new Center(
        child: Container(
          padding: EdgeInsets.all(100),
        child: Column(
          children: <Widget>[
            new QrImage(
              data: usersNYITID,
              size: 200.0, /*new Text('QR CODE GOES HERE', style: new TextStyle(fontSize: 20),),*/
            ),
            new Text("Name: " + usersName, style: TextStyle(fontSize: 20),),
            new Text("NYIT ID: " + usersNYITID,style: TextStyle(fontSize: 20),),
         ],
        ),
        ),
        ),
      );
  }
}