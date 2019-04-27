import 'package:flutter/material.dart';
import 'package:SeniorProject/calendar.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => new _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: 'Calendar Sample',
      theme: new ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('My Calendar'),
        ),

        body: new Container(
          margin: new EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 10.0,

          ),
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              new Calendar(
                isExpandable: false
            )
            ],
          ),


        ),
    ),
      );
  }
}



