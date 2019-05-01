import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SeniorProject/userManager.dart';
import 'package:SeniorProject/user.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = "";
  DateTime now = new DateTime.now();

  @override
  initState() {
    super.initState();
  }


  User updatedUser = new User();
  var userManager = new UserManager();

  String usersName = "Not on record";
  String usersNYITID = "Not on record";

  _getName(String barcode) async{
    await userManager.getUserName(barcode).then((String res) {
      print("Name incoming: " + res);
      setState(() {
        res != null ? usersName = res.toString() : "Having trouble";
      });
    });
  }

  _getNYITID(String barcode) async{
    await userManager.getUserNYITIDNumber(barcode).then((String res) {
      print("ID incoming: " + res);
      setState(() {
        res != null ? usersNYITID = res.toString() : "Having trouble";
      });
    });
  }


  Future<void> _uploadUser(String barcode) async{
    await _getNYITID(barcode);
    await _getName(barcode);
    Map<String, dynamic> scannedUser = Map();
    scannedUser["ID"] = barcode;
    scannedUser["NYITID"] = usersNYITID;
    scannedUser["name"] = usersName;
    scannedUser["time"] = now;
    scannedUser["day"] = now.day;
    scannedUser["month"] = now.month;
    scannedUser["year"] = now.year;
    scannedUser["timestamp"] = new DateTime.now().millisecondsSinceEpoch;
    Firestore.instance.collection("scannedUsers").add(scannedUser);
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = new DateTime(now.year, now.month, now.day, now.hour, now.minute);
    var currentTime = now.year.toString() + "/" + now.month.toString()  + "/" + now.day.toString() + " " + now.hour.toString() + ":" + now.minute.toString();
    return Scaffold(
        appBar: new AppBar(
          title: new Text('QR Code Scanner'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: scan,
                    child: const Text('START CAMERA SCAN')
                ),
              )
              ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text('ID: ' + usersNYITID + "\n" 'Name: ' + usersName + "\n" + currentTime, textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
              )
              ,
            ],
          ),
        ));
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
//      await _getName(barcode);
//      await _getNYITID(barcode);
      await _uploadUser(barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}