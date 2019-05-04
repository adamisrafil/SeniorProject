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
    DateTime(2019, 5, 1):
      [{'name': 'May Day', 'isDone': true}],
    DateTime(2019, 5, 27):
      [{'name': 'Memorial Day', 'isDone': true}]
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
        primarySwatch: Colors.green,
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
      return Row(
        children: <Widget>[
            Expanded(
              child: Center (
              child: Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                  ),
                  height: 100,
                  child: ListView.builder(
                            itemCount: selectedEvents.length,
                            itemBuilder: (context, index) {
                              return new Center(
                                  child: Text(selectedEvents[index]['name'])
                              );
                            },
                        ),
                  ),
                ),
            ),
            ],
      );
    } else {
      return Row(
        children: <Widget>[
          Expanded(
            child: Center(
              child: SizedBox(
                height: 100,
                child: Container(
                 child: Text("No Events Today"),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}


