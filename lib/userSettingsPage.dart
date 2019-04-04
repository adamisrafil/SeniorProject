import 'package:flutter/material.dart';
import 'package:SeniorProject/userManager.dart';
import 'package:SeniorProject/authentication.dart';
import 'package:SeniorProject/root_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:SeniorProject/user.dart';
import 'package:flutter/services.dart';


class UserSettingsPage extends StatefulWidget {
  UserSettingsPage({this.userManager, this.auth, this.root, this.user});

  final RootPage root;
  final User user;
  final BaseAuth auth;
  final UserManager userManager;

  @override
  _UserSettingsPage createState() => new _UserSettingsPage();
}

class _UserSettingsPage extends State<UserSettingsPage> {
  @override

  String accountStatus = '******';
  FirebaseUser mCurrentUser;
  FirebaseAuth _auth;
  User updatedUser = new User();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _getCurrentUser();
    print('here outside async');
  }

  _getCurrentUser () async {
    mCurrentUser = await _auth.currentUser();
    print('Hello ' + mCurrentUser.uid);
    setState(() {
      mCurrentUser != null ? accountStatus = 'Signed In' : 'Not Signed In';
    });
  }

  bool isValidUserCode(String input) {
    final RegExp regex = new RegExp('123456789');
    return regex.hasMatch(input);
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;

    var userManager = new UserManager();
    userManager.updateUser(updatedUser, mCurrentUser.uid);

    if (!form.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save(); //This invokes each onSaved event

      print('Form save called, newContact is now up to date...');
      print('Email: ${updatedUser.name}');
      print('Dob: ${updatedUser.ID}');
      print('Phone: ${updatedUser.name}');
      print('========================================');
      print('Submitting to back end...');
      print('TODO - we will write the submission part next...');
    }
  }

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  Widget build(BuildContext context) {
    // TODO: implement build
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
                  decoration: new InputDecoration(
                    hintText: 'Name',
                    labelText: 'Your Name'
                  ),
                    onSaved: (val) => updatedUser.name = val
                ),
                new TextFormField(
                    decoration: new InputDecoration(
                        hintText: '1234567',
                        labelText: 'ID number'
                    ),
                  inputFormatters: [new LengthLimitingTextInputFormatter(7)],
                    onSaved: (val) => updatedUser.ID = val
                ),
                new TextFormField(
                    obscureText: true,
                    decoration: new InputDecoration(
                        hintText: 'User Role Code',
                        labelText: 'Enter code (for faculty and staff only)',
                    ),
                ),
                new Container(
                    padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                    child: new RaisedButton(
                      child: const Text('Submit'),
                      onPressed: _submitForm,
                    )
                ),
              ],
            )
        ),
      ),
    );
  }
}