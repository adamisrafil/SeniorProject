import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      title: Row(
        children: [
            Text(
              document['UserInfo'],
            ),
            Text(
              document['timestamp'].toString(), //change to time once its ready
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
        stream: Firestore.instance.collection('scannedUsers').snapshots(),
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

