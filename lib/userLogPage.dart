import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import 'package:SeniorProject/userManager.dart';
import 'package:SeniorProject/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/services.dart';


class userLog extends StatefulWidget {
  @override
  userLogState createState() => new userLogState();
}

class userLogState extends State<userLog> {
  @override
  void initState() {
    super.initState();
  }

  Widget buildListItem(BuildContext context, DocumentSnapshot document) {
    String documentID = document.documentID;
    return ListTile (
      title: Text(
        "ID: " + document['ID'].toString() + " ",
        style: TextStyle(fontSize: 15),
      ),
      subtitle: Row(
        children: [
          Column(
            children:[
              Text(
                "NAME: " + document['name'].toString() + " ",
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
          Column(
            children:[
              Text(
                "EMAIL: " + document['email'].toString() + " ",
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
        ],
      ),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.push(context, new MaterialPageRoute(
              builder: (context) => new adminUserUpdate(documentID: documentID,)));
        }
    );
  }


  Widget allUsers() {
      return new Scaffold(
          body: StreamBuilder(
              stream: Firestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Loading...');
                return ListView.builder(
                  itemExtent: 50.0,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) => buildListItem(context, snapshot.data.documents[index]),
                );
              }
          )
      );
  }

  Widget students() {
      return new Scaffold(
          body: StreamBuilder(
              stream: Firestore.instance.collection('users').where("role", isEqualTo: "student").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Loading...');
                return ListView.builder(
                  itemExtent: 50.0,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) => buildListItem(context, snapshot.data.documents[index]),
                );
              }
          )
      );
  }

  Widget professors() {
      return new Scaffold(
          body: StreamBuilder(
              stream: Firestore.instance.collection('users').where("role", isEqualTo: "professor").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Loading...');
                return ListView.builder(
                  itemExtent: 50.0,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) => buildListItem(context, snapshot.data.documents[index]),
                );
              }
          )
      );
  }

  Widget security() {
      return new Scaffold(
          body: StreamBuilder(
              stream: Firestore.instance.collection('users').where("role", isEqualTo: "security").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Loading...');
                return ListView.builder(
                  itemExtent: 50.0,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) => buildListItem(context, snapshot.data.documents[index]),
                );
              }
          )
      );

  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: new AppBar(
          title: new Text("User Log"),
          elevation:
          Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
          bottom: TabBar(tabs: [
            Tab(text: 'All Users'),
            Tab(text: 'Students'),
            Tab(text: 'Professors'),
            Tab(text: 'Security'),
          ]),
        ),
        body: TabBarView(
          children: [
            allUsers(),
            students(),
            professors(),
            security(),
            //put new class stateless widget here and in the new class call pagewiselistview
          ],
        ),),
    );
  }
}

class adminUserUpdate extends StatefulWidget {
  final String documentID;

  const adminUserUpdate({Key key, this.documentID}) : super(key: key);
  @override
  _adminUserUpdateState createState() => new _adminUserUpdateState();
}

class _adminUserUpdateState extends State<adminUserUpdate> {

  String accountStatus = '******';
  FirebaseUser mCurrentUser;
  FirebaseAuth _auth;
  User updatedUser = new User();
  String newUserRole;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
  }

  bool isValidUserCode(String input) {
    RegExp regex = new RegExp('');
    switch(input){
      case 'professor': {
        newUserRole = "professor";
        regex = new RegExp('professor');
      }
      break;
      case 'security': {
        newUserRole = "security";
        regex = new RegExp('security');
      }
      break;
      case 'student': {
        newUserRole = "student";
        regex = new RegExp('student');
      }
      break;
      case 'admin': {
        newUserRole = "admin";
        regex = new RegExp('admin');
      }
      break;
      case '': {
        regex = new RegExp('');
      }
    }
    return regex.hasMatch(input);
  }

  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerID = TextEditingController();
  final TextEditingController controllerRole = TextEditingController();

  void _submitForm() {
    final FormState form = _formKey.currentState;

    setState(() {
      updatedUser.name = controllerName.text;
      updatedUser.ID = controllerID.text;
      updatedUser.role = newUserRole;
    });

    String studentDocumentID = widget.documentID;

    var userManager = new UserManager();
    userManager.updateUser(updatedUser, studentDocumentID);

    if (!form.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save(); //This invokes each onSaved event

      print('Form save called, newContact is now up to date...');
      print('Name: ${updatedUser.name}');
      print('ID: ${updatedUser.ID}');
      print('Role: ${updatedUser.role}');
      print('========================================');
      print('Submitting to back end...');
      print('TODO - we will write the submission part next...');
    }
  }

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('Settings'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Form(
            key: _formKey,
            autovalidate: true,
            child: new ListView(
              children: <Widget>[
                new TextFormField(
                    controller: controllerName,
                    decoration: new InputDecoration(
                        hintText: 'Name',
                        labelText: 'Your Name'
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                    },
                    onSaved: (val) => updatedUser.name = val
                ),
                new TextFormField(
                    controller: controllerID,
                    decoration: new InputDecoration(
                        hintText: '1234567',
                        labelText: 'ID number'
                    ),
                    inputFormatters: [new LengthLimitingTextInputFormatter(7)],
                    onSaved: (val) => updatedUser.ID = val
                ),
                new TextFormField(
                  controller: controllerRole,
                  obscureText: true,
                  decoration: new InputDecoration(
                    hintText: 'User Role Code',
                    labelText: 'Enter code (for faculty and staff only)',
                  ),
                  validator: (value) => isValidUserCode(value) ? null : 'Not a valid code',
                  onSaved: (value) => updatedUser.role = newUserRole,
                ),
                new Text("Bugs suck, please hit submit button twice in order to send data.", textAlign: TextAlign.center,),
                new Container(
                    padding: const EdgeInsets.only(left: 40.0, top: 20.0, right: 40.0),
                    child: new RaisedButton(
                      child: const Text('Submit'),
                      onPressed: _submitForm,
                    )
                ),
                new Text("Changes will take effect next time you close and reopen app.", textAlign: TextAlign.center,),
              ],
            )
        ),
      ),
    );
  }
}
