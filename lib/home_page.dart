import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:SeniorProject/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:SeniorProject/userManager.dart';
import 'package:SeniorProject/user.dart';
import 'package:SeniorProject/studentnavdrawer.dart';
import 'package:SeniorProject/teachernavdrawer.dart';
import 'package:SeniorProject/securitynavdrawer.dart';

import 'package:SeniorProject/class_widget.dart';


import 'package:SeniorProject/root_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.onSignedOut, this.userManager, this.user, this.root, String title})
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
  String usersEmail = "Searching...";
  String usersName = "Go to settings and update";
  String usersRole = "****";


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

  _getName() async{
    await userManager.getUserName(mCurrentUser.uid).then((String res) {
      print("Name incoming: " + res);
      setState(() {
        res != null ? usersName = res.toString() : "Having trouble";
      });
    });
  }

  _getRole() async {
    await userManager.getUserRole(mCurrentUser.uid).then((String res) {
      print("Role incoming: " + res);
      setState(() {
        res != null ? usersRole = res.toString() : "Having trouble";
      });
      _NavDrawerUsed();
    });
  }

  _getCurrentUser () async {
    mCurrentUser = await _auth.currentUser();
    print('Hello ' + mCurrentUser.uid);
    setState(() {
      mCurrentUser != null ? accountStatus = 'Signed In' : 'Not Signed In';
    });
    _getEmail();
    _getName();
    _getRole();
  }

   _NavDrawerUsed() {
    switch(usersRole) {
      case "student": { return StudNavDrawer(); }
      break;
      case "professor": { return ProfNavDrawer(); }
      break;
      case "security": { return SecNavDrawer(); }
      break;
    }
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

  //  _pageListCreator(List<>)
  Widget _showClassDashboard(widthcard, lengthcard) {


    //initialize classlist list of dictionay classes = [{'monday':[], 'tuesday': [],
    //TODO: would be nice if pulled through firebase

    var classesSchedule = {
      'monday': [ClassWidget(widthcard, lengthcard, 'CSCI 255 M01'),ClassWidget(widthcard, lengthcard, 'CSCI 255 M01'),ClassWidget(widthcard, lengthcard, 'CSCI 255 M01'),ClassWidget(widthcard, lengthcard, 'CSCI 255 M01') ],
      'tuesday': [ClassWidget(widthcard, lengthcard, 'CSCI 255 M01'),ClassWidget(widthcard, lengthcard, 'CSCI 255 M01'),ClassWidget(widthcard, lengthcard, 'CSCI 255 M01'),ClassWidget(widthcard, lengthcard, 'CSCI 255 M01') ],
      'wednesday': [ClassWidget(widthcard, lengthcard, 'CSCI 255 M01'),ClassWidget(widthcard, lengthcard, 'CSCI 255 M01'),ClassWidget(widthcard, lengthcard, 'CSCI 255 M01'),ClassWidget(widthcard, lengthcard, 'CSCI 255 M01') ],
      'thursday': [ClassWidget(widthcard, lengthcard, 'CSCI 255 M01'),ClassWidget(widthcard, lengthcard, 'CSCI 255 M01'),ClassWidget(widthcard, lengthcard, 'CSCI 255 M01'),ClassWidget(widthcard, lengthcard, 'CSCI 255 M01') ],
      'friday': [ClassWidget(widthcard, lengthcard, 'CSCI 255 M01'),ClassWidget(widthcard, lengthcard, 'CSCI 255 M01'),ClassWidget(widthcard, lengthcard, 'CSCI 255 M01'),ClassWidget(widthcard, lengthcard, 'CSCI 255 M01') ],
    };
    //initialize each page (one through five): this is a data structure that will go into the pageListCreator function to generate a list of pages for the PageView class to scroll through
    // TODO: ideally these initializations happen through firebase

    var pageOne = {'header': DayPageHeader(widthcard,lengthcard, one, 'Monday'), 'classes': classesSchedule['monday'], 'background': monday};
    var pageTwo = {'header': DayPageHeader(widthcard,lengthcard, two, 'Tuesday'), 'classes': classesSchedule['tuesday'], 'background': tuesday};
    var pageThree = {'header': DayPageHeader(widthcard,lengthcard, three, 'Wednesday'), 'classes': classesSchedule['wednesday'], 'background': wednesday};
    var pageFour = {'header': DayPageHeader(widthcard,lengthcard, four, 'Thursday'), 'classes': classesSchedule['thursday'], 'background': thursday};
    var pageFive = {'header': DayPageHeader(widthcard,lengthcard, five, 'Friday'), 'classes': classesSchedule['friday'], 'background': friday};

    var pageListInput = [pageOne,pageTwo,pageThree, pageFour, pageFive];

    var pages = pageListCreator(pageListInput, widthcard, lengthcard);

    return PageView.builder(itemBuilder: (context, position) => pages[position], itemCount: pages.length, controller: PageController(viewportFraction: 1.0, initialPage: 0));
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
      drawer: _NavDrawerUsed(),
    );
  }
}
