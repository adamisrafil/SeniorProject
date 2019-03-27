import 'package:flutter/material.dart';

class UserSettingsPage extends StatefulWidget {
  @override
  _UserSettingsPage createState() => new _UserSettingsPage();
}

class _UserSettingsPage extends State<UserSettingsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Settings'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Form(
            child: new ListView(
              children: <Widget>[
                new TextFormField(
                  decoration: new InputDecoration(
                    hintText: 'Name',
                    labelText: 'Your Name'
                  )
                ),
                new TextFormField(
                    decoration: new InputDecoration(
                        hintText: '1234567',
                        labelText: 'ID number'
                    )
                ),
                new TextFormField(
                    obscureText: true,
                    decoration: new InputDecoration(
                        hintText: 'User Role Code',
                        labelText: 'Enter code (for faculty and staff only)',
                    )
                ),
              ],
            )
        ),
      ),
    );
  }
}