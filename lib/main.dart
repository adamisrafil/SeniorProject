import 'package:flutter/material.dart';
import 'package:SeniorProject/authentication.dart';
import 'package:SeniorProject/root_page.dart';
import 'package:SeniorProject/qrPage.dart';
import 'package:SeniorProject/evalPage.dart';
import 'package:SeniorProject/forumPage.dart';
import 'package:SeniorProject/eventPage.dart';
import 'package:SeniorProject/userSettingsPage.dart';
import 'package:SeniorProject/studentnavdrawer.dart';
import 'eval_response.dart';
import 'package:SeniorProject/qrScanner.dart';
import 'package:SeniorProject/securityLog.dart';
import 'package:SeniorProject/userLogPage.dart';


void main() {
  runApp(new MyApp());
}


class MyApp extends StatelessWidget {
  @override


  Widget build(BuildContext context) {
    ThemeData(
      fontFamily: 'PoiretOne',
      canvasColor: Colors.teal,
      backgroundColor: Colors.white12,
    );
    return new MaterialApp(
        title: 'GenZ ID',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new RootPage(auth: new Auth()),
        routes: <String, WidgetBuilder> {
          '/qrPage' : (BuildContext context) => new NavQrPage(),
          '/evalPage' : (BuildContext context) => new EvalPage(),
          '/evalResponsePage' : (BuildContext context) => new EvalResponse(),
          '/forumPage' : (BuildContext context) => new ForumPage(),
          '/eventPage' : (BuildContext context) => new EventPage(),
          '/userSettingsPage' : (BuildContext context) => new UserSettingsPage(),
          '/qrScanner' : (BuildContext context) => new ScanScreen(),
          '/securityLog' : (BuildContext context) => new SecurityLog(),
          '/userLog' : (BuildContext context) => new userLog(),
    },
    );
  }
}