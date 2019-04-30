import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SeniorProject/user.dart';
import 'package:SeniorProject/userManager.dart';

class SecurityLog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SecurityLogState();
}

class _SecurityLogState extends State<SecurityLog> {
  @override
  initState() {
    super.initState();
  }

  User updatedUser = new User();
  var userManager = new UserManager();

  String usersName;
  String usersNYITID;

  _getName(String ID) async{
    await userManager.getUserName(ID).then((String res) {
      print("Name incoming: " + res);
      setState(() {
        res != null ? usersName = res.toString() : "Having trouble";
      });
    });
  }

  _getNYITID(String ID) async{
    await userManager.getUserNYITIDNumber(ID).then((String res) {
      print("ID incoming: " + res);
      setState(() {
        res != null ? usersNYITID = res.toString() : "Having trouble";
      });
    });
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    _getNYITID(document['ID'].toString());
    _getName(document['ID'].toString());
    if (usersName == null) _getName(document['ID'].toString());
    if (usersNYITID == null) _getName(document['ID'].toString());

    return ListTile (
      title: Row(
        children: [
            Text(
              "ID: " + usersNYITID + " ",
              style: TextStyle(fontSize: 10),
            ),
            Text(
              "NAME: " + usersName + " ",
              style: TextStyle(fontSize: 10),
            ),
            Text(
              "ENTERED: " + document['time'].toString() + " ",
              style: TextStyle(fontSize: 10),
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
        stream: Firestore.instance.collection('scannedUsers').where("day", isEqualTo: new DateTime.now().day).where("month", isEqualTo: new DateTime.now().month).where("year", isEqualTo: new DateTime.now().year).snapshots(),
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

