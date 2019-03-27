import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:SeniorProject/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:SeniorProject/todo.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SeniorProject/userManager.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.onSignedOut, this.email})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;
  final UserManager email;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //List<Todo> _todoList;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _textEditingController = TextEditingController();
  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;

  //Query _todoQuery;

  bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();

    _checkEmailVerification();
  }

  void _checkEmailVerification() async {
    _isEmailVerified = await widget.auth.isEmailVerified();
    if (!_isEmailVerified) {
      _showVerifyEmailDialog();
    }
  }

  void _resentVerifyEmail() {
    widget.auth.sendEmailVerification();
    _showVerifyEmailSentDialog();
  }

  void _showVerifyEmailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text("Please verify account in the link sent to email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Resent link"),
              onPressed: () {
                Navigator.of(context).pop();
                _resentVerifyEmail();
              },
            ),
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text(
              "Link to verify account has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _onTodoAddedSubscription.cancel();
    _onTodoChangedSubscription.cancel();
    super.dispose();
  }

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  Widget _showClassDashboard() {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Courses here',
                textDirection: TextDirection.ltr,
                style: TextStyle(color: Colors.tealAccent, fontSize: 32.9)),
            InkWell(
              child: Text('Button'),
//            backgroundColor: Colors.red,
              highlightColor: Colors.amberAccent,
              onTap: () => debugPrint('button tapped!'),

            )
          ],
        ),
      ),


    );
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Welcome'),
        actions: <Widget>[
          new FlatButton(
              child: new Text('Logout',
                  style: new TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: _signOut)
        ],
      ),
      //body: _showClassDashboard(),
      /*floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showDialog(context);
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        )*/
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: Container(color: Colors.white10, child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(

              accountName: Text("Moe"),
              accountEmail: Text("msultan@nyit.edu"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.teal,

                child: Text(
                  "M",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
              decoration: BoxDecoration(color: Colors.black87),
            ),
            ListTile(
              title: Text("ID"),
              leading: Icon(Icons.home),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/qrPage');
              },
            ),
            ListTile(
              title: Text('Evalutation Forms'),
              leading: Icon(Icons.account_box),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/evalPage');
              },
            ),
            ListTile(
              title: Text('NYIT Forums'),
              leading: Icon(Icons.account_box),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/forumPage');
              },
            ),
            ListTile(
              title: Text('Event Calendar'),
              leading: Icon(Icons.account_box),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/eventPage');
              },
            ),
            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.account_box),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/userSettingsPage');
              },
            ),
          ],
        )),
      ),
    );
  }
}


