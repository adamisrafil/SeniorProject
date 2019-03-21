import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class NavQrPage extends StatefulWidget {
  @override
  _NavQrPageState createState() => new _NavQrPageState();
}

class _NavQrPageState extends State<NavQrPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('QR ID'),
      ),
      body: new Center(
        child: Container(
          padding: EdgeInsets.all(100),
        child: Column(
          children: <Widget>[
            new QrImage(
              data: "1234567890",
              size: 200.0, /*new Text('QR CODE GOES HERE', style: new TextStyle(fontSize: 20),),*/
            ),
            new Text("Name: Angela Tong", style: TextStyle(fontSize: 20),),
            new Text("ID: 1067231",style: TextStyle(fontSize: 20),),
         ],
        ),
        ),
        ),
      );
  }
}