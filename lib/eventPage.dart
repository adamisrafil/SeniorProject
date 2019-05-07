import 'package:flutter/material.dart';
import 'package:SeniorProject/calendar.dart';


class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => new _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List selectedEvents;
  DateTime selectedDate;

  @override
  void initstate() {
    super.initState();
    selectedEvents = events[selectedDate];
  }

  final Map events = {
    DateTime(2019, 1, 1):
    [{'name': 'New Years Day 2019', 'isDone': true}],

    DateTime(2019, 1, 21):
    [{'name': 'Dr. Martin Luther King Day', 'isDone': true}],

    DateTime(2019, 2, 2):
    [{'name': 'Groundhog Day', 'isDone': true}],

    DateTime(2019, 2, 12):
    [{'name': 'President Lincoln Birthday', 'isDone': true}],

    DateTime(2019, 2, 14):
    [{'name': 'Valentines Day', 'isDone': true}],

    DateTime(2019, 2, 18):
    [{'name': 'Presidents Day', 'isDone': true}],

    DateTime(2019, 3, 10):
    [{'name': 'Daylight Savings', 'isDone': true}],

    DateTime(2019, 3, 17):
    [{'name': 'St. Patricks Day', 'isDone': true}],

    DateTime(2019, 4, 1):
    [{'name': 'April Fools Day', 'isDone': true}],

    DateTime(2019, 4, 19):
    [{'name': 'Good Friday', 'isDone': true}],

    DateTime(2019, 4, 21):
    [{'name': 'Easter Sunday', 'isDone': true}],

    DateTime(2019, 5, 5):
    [{'name': 'Cinco de Mayo', 'isDone': true}],

    DateTime(2019, 5, 5):
    [{'name': 'Cinco de Mayo', 'isDone': true}],

    DateTime(2019, 5, 12):
    [{'name': 'Mothers Day', 'isDone': true}],

    DateTime(2019, 5, 27):
    [{'name': 'Memorial Day', 'isDone': true}],

    DateTime(2019, 6, 16):
    [{'name': 'Fathers Day', 'isDone': true}],

    DateTime(2019, 7, 4):
    [{'name': 'Independence Day', 'isDone': true}],

    DateTime(2019, 9, 2):
    [{'name': 'Labor Day', 'isDone': true}],

    DateTime(2019, 10, 14):
    [{'name': 'Columbus Day', 'isDone': true}],

    DateTime(2019, 10, 31):
    [{'name': 'Halloween', 'isDone': true}],

    DateTime(2019, 11, 3):
    [{'name': 'Daylight Savings', 'isDone': true}],

    DateTime(2019, 11, 11):
    [{'name': 'Veterans Day', 'isDone': true}],

    DateTime(2019, 11, 28):
    [{'name': 'Thanksgiving Day', 'isDone': true}],

    DateTime(2019, 11, 29):
    [{'name': 'Black Friday', 'isDone': true}],

    DateTime(2019, 12, 25):
    [{'name': 'Christmas Day', 'isDone': true}],

    DateTime(2019, 12, 31):
    [{'name': 'New Years Eve', 'isDone': true}],

    DateTime(2020, 11, 1):
    [{'name': 'New Years Day 2020', 'isDone': true}],

  };

  final nameController = TextEditingController();

  void handleNewDate(date) {
    setState(() {
      selectedDate = date;
      selectedEvents = events[selectedDate] ?? [];
    });
    print(selectedDate);
    print(selectedEvents);
  }

  @override
  void dispose(){
    nameController.dispose();
    super.dispose();
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
      debugShowCheckedModeBanner: false,
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
          onPressed: (){
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Event Details"),
                  content: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(hintText: "Enter Name of Event"),
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                      new FlatButton(
                        onPressed: (){
                          events[selectedDate] = [{'name': nameController.text, 'isDone': true}];
                          Navigator.of(context).pop();
                        },
                        child: new Text("Done")
                      )
                    ]
                );
              },
            );
          },
          child: Icon(Icons.add)
        ),
      ),
    );
  }

  Widget buildEventList() {
    if (selectedEvents != null) {
      return Row(
        children: <Widget>[
            Expanded(
              child: Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
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
            ],
      );
    } else {
      return Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        height: 100,
        child: new Center(
          child: Text("No Events Today"),
        ),
      );
    }
  }


}


