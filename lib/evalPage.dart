import 'package:flutter/material.dart';

class EvalPage extends StatefulWidget {
  @override
  _EvalPageState createState() => new _EvalPageState();
}

class _EvalPageState extends State<EvalPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Evalution Form'),
      ),
      body: new Center(
        child: new Text("Evalution Form goes here"),
      ),
    );
  }
}