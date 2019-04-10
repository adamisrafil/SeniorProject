
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EvalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
 return Scaffold(
      appBar: AppBar(
        title: Text('Evaluation Form'),
      ),
      
      body: Center(
        child: RaisedButton(
          child: Text('Start Evaluation'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
        ),
      ),
    );
  }
}
class MyApp extends StatefulWidget {
  @override

  _MyAppState createState() => new _MyAppState();
}
class _MyAppState extends State<MyApp> {
  int _radioValue1 = -1;
  int correctScore = 0;
  int _radioValue2 = -1;
  int _radioValue3 = -1;
  int _radioValue4 = -1;
  int _radioValue5 = -1;
  int _radioValue6 = -1;
  int _radioValue7 = -1;
  int _radioValue8 = -1;
  int _radioValue9 = -1;
  int _radioValue10 = -1;

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;

    });
  }

  void _handleRadioValueChange2(int value) {
    setState(() {
      _radioValue2 = value;

    });
  }

  void _handleRadioValueChange3(int value) {
    setState(() {
      _radioValue3 = value;

    });
  }

  void _handleRadioValueChange4(int value) {
    setState(() {
      _radioValue4 = value;
    });
  }

  void _handleRadioValueChange5(int value) {
    setState(() {
      _radioValue5 = value;

    });
  }
    void _handleRadioValueChange6(int value) {
    setState(() {
      _radioValue6 = value;

    });
  }
    void _handleRadioValueChange7(int value) {
    setState(() {
      _radioValue7 = value;

    });
  }
    void _handleRadioValueChange8(int value) {
    setState(() {
      _radioValue8 = value;

    });
  }
    void _handleRadioValueChange9(int value) {
    setState(() {
      _radioValue9 = value;

    });
  }
    void _handleRadioValueChange10(int value) {
    setState(() {
      _radioValue10 = value;

    });
  }



  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            appBar: AppBar(
              title: new Text('Evaluation Form'),
              centerTitle: true,
              backgroundColor: Colors.blue,
            ),
            body: SingleChildScrollView(
            child: new Container(
                padding: EdgeInsets.all(8.0),
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        'Note to students: Results will not be given to faculty until after grades are finalized. Except for comments, faculty will see aggregated (combined) data for students in the class, not students’ individual responses.',
                        style: new TextStyle(
                            fontSize: 10.0, fontWeight: FontWeight.bold),
                      ),
                      new Padding(
                        padding: new EdgeInsets.all(8.0),
                      ),
                      new Divider(height: 5.0, color: Colors.black),
                      new Padding(
                        padding: new EdgeInsets.all(8.0),
                      ),
                      new Text(
                        'Classes met for the entire scheduled time period.',
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            value: 0,
                            groupValue: _radioValue1,
                            onChanged: _handleRadioValueChange1,
                          ),
                          new Text(
                            'Disagree',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          new Radio(
                            value: 1,
                            groupValue: _radioValue1,
                            onChanged: _handleRadioValueChange1,
                          ),
                          new Text(
                            'Neutral',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          new Radio(
                            value: 2,
                            groupValue: _radioValue1,
                            onChanged: _handleRadioValueChange1,
                          ),
                          new Text(
                            'Agree',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      new Divider(
                        height: 5.0,
                        color: Colors.black,
                      ),
                      new Padding(
                        padding: new EdgeInsets.all(8.0),
                      ),
                      new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              'The instructor clearly stated the objectives of the course and each topic.',
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Radio(
                                  value: 0,
                                  groupValue: _radioValue2,
                                  onChanged: _handleRadioValueChange2,
                                ),
                                new Text(
                                  'Disagree',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                  value: 1,
                                  groupValue: _radioValue2,
                                  onChanged: _handleRadioValueChange2,
                                ),
                                new Text(
                                  'Neutral',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                  value: 2,
                                  groupValue: _radioValue2,
                                  onChanged: _handleRadioValueChange2,
                                ),
                                new Text(
                                  'Agree',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                            new Divider(
                              height: 5.0,
                              color: Colors.black,
                            ),
                            new Padding(
                              padding: new EdgeInsets.all(8.0),
                            ),
                            new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Text(
                                    'The content of the course and the material covered was directly related to the objectives of the course.',
                                    style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Radio(
                                        value: 0,
                                        groupValue: _radioValue3,
                                        onChanged: _handleRadioValueChange3,
                                      ),
                                      new Text(
                                        'Disagree',
                                        style: new TextStyle(fontSize: 16.0),
                                      ),
                                      new Radio(
                                        value: 1,
                                        groupValue: _radioValue3,
                                        onChanged: _handleRadioValueChange3,
                                      ),
                                      new Text(
                                        'Neutral',
                                        style: new TextStyle(fontSize: 16.0),
                                      ),
                                      new Radio(
                                        value: 2,
                                        groupValue: _radioValue3,
                                        onChanged: _handleRadioValueChange3,
                                      ),
                                      new Text(
                                        'Agree',
                                        style: new TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                  new Divider(
                                    height: 5.0,
                                    color: Colors.black,
                                  ),
                                  new Padding(
                                    padding: new EdgeInsets.all(8.0),
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        'The syllabus was clear and explained what was expected in the course.',
                                        style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Radio(
                                            value: 0,
                                            groupValue: _radioValue4,
                                            onChanged: _handleRadioValueChange4,
                                          ),
                                          new Text(
                                            'Disagree',
                                            style:
                                                new TextStyle(fontSize: 16.0),
                                          ),
                                          new Radio(
                                            value: 1,
                                            groupValue: _radioValue4,
                                            onChanged: _handleRadioValueChange4,
                                          ),
                                          new Text(
                                            'Neutral',
                                            style:
                                                new TextStyle(fontSize: 16.0),
                                          ),
                                          new Radio(
                                            value: 2,
                                            groupValue: _radioValue4,
                                            onChanged: _handleRadioValueChange4,
                                          ),
                                          new Text(
                                            'Agree',
                                            style:
                                                new TextStyle(fontSize: 16.0),
                                          ),
                                        ],
                                      ),
                                      new Divider(
                                        height: 5.0,
                                        color: Colors.black,
                                      ),
                                      new Padding(
                                        padding: new EdgeInsets.all(8.0),
                                      ),
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Text(
                                            'The instructor was responsive to student questions.',
                                            style: new TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                          new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              new Radio(
                                                value: 0,
                                                groupValue: _radioValue5,
                                                onChanged:
                                                    _handleRadioValueChange5,
                                              ),
                                              new Text(
                                                'Disagree',
                                                style: new TextStyle(
                                                    fontSize: 16.0),
                                              ),
                                              new Radio(
                                                value: 1,
                                                groupValue: _radioValue5,
                                                onChanged:
                                                    _handleRadioValueChange5,
                                              ),
                                              new Text(
                                                'Neutral',
                                                style: new TextStyle(
                                                    fontSize: 16.0),
                                              ),
                                              new Radio(
                                                value: 2,
                                                groupValue: _radioValue5,
                                                onChanged:
                                                    _handleRadioValueChange5,
                                              ),
                                              new Text(
                                                'Agree',
                                                style: new TextStyle(
                                                    fontSize: 16.0),
                                              ),
                                            ],
                                          ),

new Divider(
                                    height: 5.0,
                                    color: Colors.black,
                                  ),
                                  new Padding(
                                    padding: new EdgeInsets.all(8.0),
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        ' I would recommend this instructor.',
                                        style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Radio(
                                            value: 0,
                                            groupValue: _radioValue6,
                                            onChanged: _handleRadioValueChange6,
                                          ),
                                          new Text(
                                            'Disagree',
                                            style:
                                                new TextStyle(fontSize: 16.0),
                                          ),
                                          new Radio(
                                            value: 1,
                                            groupValue: _radioValue6,
                                            onChanged: _handleRadioValueChange6,
                                          ),
                                          new Text(
                                            'Neutral',
                                            style:
                                                new TextStyle(fontSize: 16.0),
                                          ),
                                          new Radio(
                                            value: 2,
                                            groupValue: _radioValue6,
                                            onChanged: _handleRadioValueChange6,
                                          ),
                                          new Text(
                                            'Agree',
                                            style:
                                                new TextStyle(fontSize: 16.0),
                                          ),
                                        ],
                                      ),



                                    new Divider(
                                    height: 5.0,
                                    color: Colors.black,
                                  ),
                                  new Padding(
                                    padding: new EdgeInsets.all(8.0),
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        'The amount of work in this course was appropriate.',
                                        style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Radio(
                                            value: 0,
                                            groupValue: _radioValue7,
                                            onChanged: _handleRadioValueChange7,
                                          ),
                                          new Text(
                                            'Disagree',
                                            style:
                                                new TextStyle(fontSize: 16.0),
                                          ),
                                          new Radio(
                                            value: 1,
                                            groupValue: _radioValue7,
                                            onChanged: _handleRadioValueChange7,
                                          ),
                                          new Text(
                                            'Neutral',
                                            style:
                                                new TextStyle(fontSize: 16.0),
                                          ),
                                          new Radio(
                                            value: 2,
                                            groupValue: _radioValue4,
                                            onChanged: _handleRadioValueChange7,
                                          ),
                                          new Text(
                                            'Agree',
                                            style:
                                                new TextStyle(fontSize: 16.0),
                                          ),
                                        ],
                                      ),



                        new Divider(
                        height: 5.0,
                        color: Colors.black,
                      ),
                      new Padding(
                        padding: new EdgeInsets.all(8.0),
                      ),
                      new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              'The instructor presented material clearly and logically.',
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Radio(
                                  value: 0,
                                  groupValue: _radioValue8,
                                  onChanged: _handleRadioValueChange8,
                                ),
                                new Text(
                                  'Disagree',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                  value: 1,
                                  groupValue: _radioValue8,
                                  onChanged: _handleRadioValueChange8,
                                ),
                                new Text(
                                  'Neutral',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                  value: 2,
                                  groupValue: _radioValue8,
                                  onChanged: _handleRadioValueChange8,
                                ),
                                new Text(
                                  'Agree',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),


                        new Divider(
                        height: 5.0,
                        color: Colors.black,
                      ),
                      new Padding(
                        padding: new EdgeInsets.all(8.0),
                      ),
                      new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              'The instructor provided helpful, constructive feedback on assignments and course work.',
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Radio(
                                  value: 0,
                                  groupValue: _radioValue9,
                                  onChanged: _handleRadioValueChange9,
                                ),
                                new Text(
                                  'Disagree',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                  value: 1,
                                  groupValue: _radioValue9,
                                  onChanged: _handleRadioValueChange9,
                                ),
                                new Text(
                                  'Neutral',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                  value: 2,
                                  groupValue: _radioValue9,
                                  onChanged: _handleRadioValueChange9,
                                ),
                                new Text(
                                  'Agree',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),

                        new Divider(
                        height: 5.0,
                        color: Colors.black,
                      ),
                      new Padding(
                        padding: new EdgeInsets.all(8.0),
                      ),
                      new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              'Overall, I would rate the instructor’s effectiveness in this course as:',
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Radio(
                                  value: 0,
                                  groupValue: _radioValue10,
                                  onChanged: _handleRadioValueChange10,
                                ),
                                new Text(
                                  'Poor',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                  value: 1,
                                  groupValue: _radioValue10,
                                  onChanged: _handleRadioValueChange10,
                                ),
                                new Text(
                                  'Average',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                  value: 2,
                                  groupValue: _radioValue10,
                                  onChanged: _handleRadioValueChange10,
                                ),
                                new Text(
                                  'Good',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),




                                          new Divider(
                                            height: 5.0,
                                            color: Colors.black,
                                          ),
                                          new Padding(
                                            padding: new EdgeInsets.all(8.0),
                                          ),
                                          new RaisedButton(
                                            onPressed: validateAnswers,
                                            child: new Text(
                                              'Submit',

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
                                            onPressed: resetSelection,
                                            child: new Text(
                                              'Reset Selection',
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
                                          )
                                        ],
                                      ),
                                    ],
                                      )
                                    ],
                                  )
                                    ],
                                      )
                                    ],
                                  )
                                        ],
                                      )
                                    ],
                                  )
                                  
                            
                                ])
                          ])
                    ])))));
    
  }

  void resetSelection() {
    _handleRadioValueChange1(-1);
    _handleRadioValueChange2(-1);
    _handleRadioValueChange3(-1);
    _handleRadioValueChange4(-1);
    _handleRadioValueChange5(-1);
    _handleRadioValueChange6(-1);
    _handleRadioValueChange7(-1);
    _handleRadioValueChange8(-1);
    _handleRadioValueChange9(-1);
    _handleRadioValueChange10(-1);
    correctScore = 0;
  }

  void validateAnswers() {
    if (_radioValue1 == -1 && _radioValue2 == -1 &&
        _radioValue3 == -1 && _radioValue4 == -1 &&
        _radioValue5 == -1 && _radioValue6 == -1 &&
        _radioValue7 == -1 && _radioValue8 == -1 && _radioValue9 == -1  && _radioValue10 == -1                         ){
      Fluttertoast.showToast(msg: 'Please select atleast one answer',
          toastLength: Toast.LENGTH_SHORT);
    } else {
      Fluttertoast.showToast(
          msg: 'Thank You for Your Feedback',
          toastLength: Toast.LENGTH_LONG);
    }
  }
}


