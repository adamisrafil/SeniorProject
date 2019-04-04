import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:SeniorProject/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:SeniorProject/todo.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SeniorProject/userManager.dart';
import 'package:SeniorProject/user.dart';

import 'package:SeniorProject/root_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.onSignedOut, this.userManager, this.user, this.root})
      : super(key: key);

  final BaseAuth auth;
  final RootPage root;
  final VoidCallback onSignedOut;
  final String userId;
  final UserManager userManager;
  final User user;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //List<Todo> _todoList;

  String accountStatus = '******';
  FirebaseUser mCurrentUser;
  FirebaseAuth _auth;
  User updatedUser = new User();
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _textEditingController = TextEditingController();
  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;

  //Query _todoQuery;

  bool _isEmailVerified = false;
  var userManager = new UserManager();
  String usersEmail;


  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _getCurrentUser();
    print('here outside async');

    _checkEmailVerification();
  }

  _getEmail() async{
    await userManager.getUserEmail(mCurrentUser.uid).then((String res) {
      print("Email incoming: " + res);
      setState(() {
        res != null ? usersEmail = res.toString() : "Having trouble";
      });
    });
  }

  _getCurrentUser () async {
    mCurrentUser = await _auth.currentUser();
    print('Hello ' + mCurrentUser.uid);
    setState(() {
      mCurrentUser != null ? accountStatus = 'Signed In' : 'Not Signed In';
    });
    _getEmail();
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
          content:
          new Text("Link to verify account has been sent to your email"),
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

  Widget _showClassDashboard(widthcard, lengthcard) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
        child: Center(
            child: Container(
              width: widthcard,
              height: lengthcard,
              decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87,
                      blurRadius: 10.0,
                      // has the effect of softening the shadow
                      spreadRadius: 10.0,
                      // has the effect of extending the shadow
                      offset: Offset(
                        1.0,
                        1.0,
                      ),
                    )
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      width: widthcard,
                      height: lengthcard * 0.12,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(35.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white30,
                              blurRadius: 5.0,
                              // has the effect of softening the shadow
                              spreadRadius: 1.0,
                              // has the effect of extending the shadow
                              offset: Offset(
                                0.0,
                                2.0,
                              ),
                            )
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Monday' /*TODO: It would be nice for the day to be pulled automatically*/,
                          style: TextStyle(fontSize: widthcard * 0.09
//                            fontFamily:
                          ),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                    child: Container(
                        width: widthcard * 0.9,
                        height: lengthcard * 0.12,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(25.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white30,
                                blurRadius: 5.0,
                                // has the effect of softening the shadow
                                spreadRadius: 1.0,
                                // has the effect of extending the shadow
                                offset: Offset(
                                  0.0,
                                  2.0,
                                ),
                              )
                            ]),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'CSCI 355 M01' /*TODO: It would be nice for the day to be pulled automatically*/,
                                  style: TextStyle(fontSize: widthcard * 0.055

//                            fontFamily:
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                                  child: Icon(
                                    Icons
                                        .border_color /*TODO: On tap, change current icon to indicate selection, change action button color/icon to indicate that an action can be madey*/,
                                  ),
                                )
                              ]),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                    child: Container(
                        width: widthcard * 0.9,
                        height: lengthcard * 0.12,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(25.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white30,
                                blurRadius: 5.0,
                                // has the effect of softening the shadow
                                spreadRadius: 1.0,
                                // has the effect of extending the shadow
                                offset: Offset(
                                  0.0,
                                  2.0,
                                ),
                              )
                            ]),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'CSCI 355 M01' /*TODO: It would be nice for the day to be pulled automatically*/,
                                  style: TextStyle(fontSize: widthcard * 0.055

//                            fontFamily:
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                                  child: Icon(
                                    Icons
                                        .border_color /*TODO: On tap, change current icon to indicate selection, change action button color/icon to indicate that an action can be madey*/,
                                  ),
                                )
                              ]),
                        )),
                  ),
                  Padding(
                    //TODO: Make these views into a function.
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                    child: Container(
                        width: widthcard * 0.9,
                        height: lengthcard * 0.12,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(25.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white30,
                                blurRadius: 5.0,
                                // has the effect of softening the shadow
                                spreadRadius: 1.0,
                                // has the effect of extending the shadow
                                offset: Offset(
                                  0.0,
                                  2.0,
                                ),
                              )
                            ]),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'CSCI 355 M01' /*TODO: It would be nice for the day to be pulled automatically*/,
                                  style: TextStyle(fontSize: widthcard * 0.055

//                            fontFamily:
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                                  child: Icon(
                                    Icons
                                        .border_color /*TODO: On tap, change current icon to indicate selection, change action button color/icon to indicate that an action can be madey*/,
                                  ),
                                )
                              ]),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                    child: Container(
                        width: widthcard * 0.9,
                        height: lengthcard * 0.12,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(25.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white30,
                                blurRadius: 5.0,
                                // has the effect of softening the shadow
                                spreadRadius: 1.0,
                                // has the effect of extending the shadow
                                offset: Offset(
                                  0.0,
                                  2.0,
                                ),
                              )
                            ]),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'CSCI 355 M01' /*TODO: It would be nice for the day to be pulled automatically*/,
                                  style: TextStyle(fontSize: widthcard * 0.055

//                            fontFamily:
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                                  child: Icon(
                                    Icons
                                        .border_color /*TODO: On tap, change current icon to indicate selection, change action button color/icon to indicate that an action can be madey*/,
                                  ),
                                )
                              ]),
                        )),
                  ),
                ],
              ),
            )));
  }

  @override
  Widget build(BuildContext context){

    MediaQueryData queryData =
    MediaQuery.of(context); //get aspect ratio of screen
    final double widthcard = queryData.size.width * 0.85;
    final double lengthcard = queryData.size.height * 0.75;
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
      body: _showClassDashboard(widthcard, lengthcard),
      floatingActionButton: Container(
        height: 100.0,
        width: 100.0,
        child: FittedBox(
          child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.amberAccent,
              child: Icon(
                Icons.add,
                color: Colors.black,
              )),
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: Container(
            color: Colors.white10,
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text("Moe"),
                  accountEmail: Text(usersEmail),
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
