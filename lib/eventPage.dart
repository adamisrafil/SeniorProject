import 'package:flutter/material.dart';
import 'package:SeniorProject/calendar.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => new _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List selectedEvents;
  DateTime selectedDate;
  final Map events = {
    DateTime(2019, 4, 29):
    [{'name': 'Avengers', 'isDone': false}]
  };
  @override
  void initstate() {
    super.initState();
    selectedEvents = events[selectedDate] ?? [];
  }

  void handleNewDate(date) {
    setState(() {
      selectedDate = date;
      selectedEvents = events[selectedDate] ?? [];
    });
    print(selectedDate);
    print(selectedEvents);
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: 'Calendar',
      theme: new ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('My Calendar'),
          leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false),
          )
        ),

        body: new Container(
          margin: new EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 10.0,

          ),
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                child: new Calendar(
                  isExpandable: false,
                  events: events,
                  onDateSelected: (date) => handleNewDate(date),
                  onRangeSelected: (range) => print("Range is ${range.from}, ${range.to}"),
                ),
              ),
              buildEventList(),
            ],
          ),


        ),
        floatingActionButton: FloatingActionButton (
          onPressed: () => {},
          tooltip: 'Increment',
          child: Icon(Icons.add),

        ),
    ),
      );
  }
  Widget buildEventList() {
    if (selectedEvents != null) {
      return Container(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.5, color: Colors.black12),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
                child: ListTile(
                  title: Text(selectedEvents[index]['name'].toString()),
                  //onTap: () {},
                ),
              ),
          itemCount: selectedEvents.length,
        ),
      );
    } else {
      return Container();
    }
  }
}



