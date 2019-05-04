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

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile (
      title: Text(
        "ID: " + document['ID'].toString() + " ",
        style: TextStyle(fontSize: 11),
      ),
      subtitle: Row(
        children: [
            Text(
              "ID: " + document['NYITID'] + " ",
              style: TextStyle(fontSize: 11),
            ),
            Text(
              "NAME: " + document['name'].toString() + " ",
              style: TextStyle(fontSize: 11),
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
               itemExtent: 50.0,
               itemCount: snapshot.data.documents.length,
               itemBuilder: (context, index) => _buildListItem(context, snapshot.data.documents[index]),
           );
          }
      )
    );
  }
}

