import 'package:flutter/material.dart';
import 'survey_1.dart';
import 'slide_right_transition.dart';
import 'thank_you.dart';



class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fise',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EvalPage(title: 'Fise Survey'),

    );
  }
}

class EvalPage extends StatefulWidget {
 EvalPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _EvalPageState createState() => _EvalPageState();
}

class _EvalPageState extends State<EvalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Evaluation Form'),
      ),
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
                    title: Text('Class Evaluation',
                        style: TextStyle(
                          fontSize: 19,
                        )),
                    subtitle: Text(
                        'Click Start to begin Evaluation',
                        style: TextStyle(
                          height: 2.5,
                          fontSize: 16,
                        )),
                  ),
                  ButtonTheme.bar(
                    // make buttons use the appropriate styles for cards
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text(
                            'Start',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ClassSurvey()),
            );
          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          ),
        ));
  }
}
