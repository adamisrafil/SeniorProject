import 'survey_1.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class ThankYouPage extends StatefulWidget {
  @override
  _ThankYouPageState createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Card(
        margin: EdgeInsets.all(25.0),
        shape: BeveledRectangleBorder(),
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                title: Text('Evaluation Complete',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    )),
                subtitle: Text('Thank You For your Feedback.',
                    style: TextStyle(
                      height: 2.5,
                      fontSize: 16,
                    )),
              ),


new Divider(
                                            height: 5.0,
                                            color: Colors.black,
                                          ),
                                          new Padding(
                                            padding: new EdgeInsets.all(8.0),
                                          ),
                                          new RaisedButton(
                                            onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ClassSurvey()),
            );
          },
                                            child: new Text(
                                              'Evaluate Another Class',

                                              style: new TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white),
                                            ),
                                            color: Theme.of(context).accentColor,
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        20.0)),
                                          ),
                                          new Padding(
                                            padding: EdgeInsets.all(4.0),
                                          ),
                                          new RaisedButton(
                                                onPressed: () {
                        Navigator.push(
              context,
                       MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                                            child: new Text(
                                              'Return to HomePage',
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16.0,
                                                  color: Colors.white),
                                            ),
                                            color: Theme.of(context).accentColor,
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        20.0)),
                                          ),

            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    ));
  }
}
