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
  String newUserRole;

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
    RegExp regex = new RegExp('');
    switch(input){
      case '123456789': {
        newUserRole = "professor";
        regex = new RegExp('123456789');
      }
      break;
      case '987654321': {
        newUserRole = "security";
        regex = new RegExp('987654321');
      }
      break;
      case '666': {
        newUserRole = "student";
        regex = new RegExp('666');
      }
      break;
      case '': {
         regex = new RegExp('');

      }
    }
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
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                    },
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
                new Text("Changes will take effect next time you close and reopen page.", textAlign: TextAlign.center,),
              ],
            )
        ),
      ),
    );
  }
}