import 'package:SeniorProject/coure_selector.dart';
import 'package:SeniorProject/home_page.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';



class ClassWidget extends StatefulWidget {
  final String text;
  final double width;
  final double height;
  final String time ;
  final GlobalKey<ScaffoldState> scaffoldKey;

  ClassWidget(this.width, this.height, this.text, this.time,{ Key key, this.scaffoldKey}) :super(key: key );


  @override
  State createState() => ClassWidgetState(width, height, text, time);
}

class ClassWidgetState extends State<ClassWidget> {
  bool _enabledAbsent = true;
  final String text;
  final double width;
  final String time;
  double height;
  bool isExpanded = false;
  String snackMessage;
  String barcode = "";
  DateTime now = new DateTime.now();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  ClassWidgetState(this.width, this.height, this.text, this.time);



  Future<void> _uploadUser(barcode) async{
    Map<String, dynamic> scannedUser = Map();
    scannedUser["UserInfo"] = barcode;
    scannedUser["timestamp"] = now;
//    TODO: upate this moe
    Firestore.instance.collection("course").add(scannedUser);
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
      _enabledAbsent = false;
      _uploadUser(barcode);
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




  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
          child: Container(width: this.width * 0.9,
//              height: this.height * 0.12,
              decoration: BoxDecoration(color: Colors.teal[95],
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: [ BoxShadow(color: Colors.white30,
                    blurRadius: 5.0,
                    // has the effect of softening the shadow
                    spreadRadius: 1.0,
                    // has the effect of extending the shadow
                    offset: Offset(0.0, 2.0,),)
                  ]),
              child: Padding(padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                  child: ExpansionTile(
                    title: Container(child: Text(this.text,
                          style: TextStyle(fontSize: isExpanded ? width * 0.075 : width * 0.09, fontFamily: 'PoiretOne', fontWeight: isExpanded? FontWeight.w600: FontWeight.w700, color: isExpanded ? Colors.teal[500] : Colors.black54),
                          textAlign: TextAlign.left,)
                    // Change header (which is a Container widget in this case) background colour here.
                  ),
                    trailing: isExpanded ? Icon(Icons.keyboard_arrow_up, size: 36.0, color: Colors.teal[500],) : Icon(Icons.keyboard_arrow_down, size: 36.0, color: Colors.black54),
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          alignment: Alignment(-1, -1),
                          width: this.width*0.9,
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 1.0, color: Colors.black38),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Padding(
                                padding:  EdgeInsets.fromLTRB(0.0, 30.0, this.width* 0.35, 0.0),
                                child: Text(this.time,
                                  style: TextStyle(fontSize: width * 0.06, fontFamily: 'PoiretOne', fontWeight: FontWeight.w700, color: Colors.black54),
                                  textAlign: TextAlign.left,),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end ,
                                  children: <Widget>[
                                    Text('Sign in',
                                      style: TextStyle(fontSize: width * 0.07, fontFamily: 'PoiretOne', fontWeight: FontWeight.bold, color: Colors.black54),
                                      textAlign: TextAlign.left,),

                                    Padding(
                                      padding: EdgeInsets.fromLTRB(width *0.15 , 0.0, 0.0, 0.0),
                                      child: RaisedButton(

                                        color: Colors.teal,
                                        shape: CircleBorder(),
                                        elevation: 15.0,
                                        child: Icon(Icons.check, size: 23.0, color: Colors.white),
                                        onPressed:(){
                                          scan();


                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                      child: RaisedButton(

                                        color: Colors.redAccent,
                                        shape: CircleBorder() ,
                                        elevation: 15.0,
                                        disabledColor: Colors.deepOrange,
                                        disabledElevation: 5.0,
                                        child: Icon(Icons.close, size: 23.0, color: Colors.white),
                                        onPressed: () {
                                          print(global_course);
                                          if (_enabledAbsent){
                                            widget.scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('you wil be marked as absent from ${this.text})', textAlign: TextAlign.center, style: TextStyle( fontFamily: 'PoiretOne', fontWeight: FontWeight.bold, color: Colors.white),),backgroundColor: Colors.redAccent, duration: Duration(milliseconds: 1400), ));
                                          }
                                        } ,
                                      ),
                                    ),

                                  ],

                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                    onExpansionChanged: (bool expanding) => setState(()
                    {
                      print(isExpanded);
                      this.isExpanded = expanding;
                    }),)
              ))),
    );
  }
}


class DayPage extends StatefulWidget {
  final double width;
  final double height;
  final AssetImage background;
  final List <Widget> widgets;


  DayPage(this.width, this.height, this.background, this.widgets);

  @override
  DayPageState createState() =>
      DayPageState(this.width, this.height, this.background, this.widgets);
}

class DayPageState extends State<DayPage> {
  final double width;
  final double height;
  final AssetImage background;
  List <Widget> widgets;


  DayPageState(this.width, this.height, this.background, this.widgets);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
        child: Center(child: Container(width: this.width,
          height: this.height,
          decoration: BoxDecoration(
              image: DecorationImage(image: this.background, fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [ BoxShadow(color: Colors.black38,
                blurRadius: 5.0,
                // has the effect of softening the shadow
                spreadRadius: 8.0,
                // has the effect of extending the shadow
                offset: Offset(0.0, 10.0,),)
              ]),
          child: ListView.builder(itemCount: this.widgets.length ,itemBuilder: (context, position) => widgets[position])))) ;
  }
}


class DayPageHeader extends StatelessWidget {

  final double width;
  final double height;
  final AssetImage background;
  final String text;

  //constructor
  DayPageHeader(this.width, this.height, this.background, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(width: this.width,
        height: this.height * 0.16,
        decoration: BoxDecoration(
            image: DecorationImage(image: this.background, fit: BoxFit.fill),
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(35.0)),
            boxShadow: [
              BoxShadow(color: Colors.white30,
              blurRadius: .5,
              // has the effect of softening the shadow
              spreadRadius: 1.0,
              // has the effect of extending the shadow
              offset: Offset(0.0, 2.0,),)
            ]),
        child: Stack(children: <Widget>[ Padding(
          padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 100.0),
          child: Text(this.text, style: TextStyle(fontFamily: 'PoiretOne',
              fontSize: this.width * 0.15,
              color: Colors.white),),),
        ]));
  }
}


//initialize image backgrounds
var monday = new AssetImage('assets/cal_Backgrounds/monday.jpg');
var tuesday = new AssetImage('assets/cal_Backgrounds/tuesday.jpg');
var wednesday = new AssetImage('assets/cal_Backgrounds/wednesday.jpg');
var thursday = new AssetImage('assets/cal_Backgrounds/thursday.jpg');
var friday = new AssetImage('assets/cal_Backgrounds/friday.png');

var one = new AssetImage('assets/headerbackgrounds/one.jpeg');
var two = new AssetImage('assets/headerbackgrounds/two.png');
var three = new AssetImage('assets/headerbackgrounds/three.png');
var four = new AssetImage('assets/headerbackgrounds/four.jpg');
var five = new AssetImage('assets/headerbackgrounds/five.png');


// takes in a dictionary list that contains all pages to be created along with their inputs {see var pageListInput in _showClassDashboard Widget located at home_page.dart} and returns an output list if one isn't given
// if an output list is given. then it appends to that list
List <DayPage> pageListCreator(var pages, width, height, [List <DayPage> output]) {
  if (output == null) {
    output = new List <DayPage> ();
  }
  for (var i = 0; i < pages.length; i++) {
    List <Widget> temp = []..add(pages[i]['header'])..addAll(pages[i]['classes']);

    output.add(DayPage(width, height, pages[i]['background'], temp));
  }

  return output;
}

dynamicPageListCreator(var pages, width, height){
  List <DayPage> out = [];
  for (int i =0; i<pages.length; i++){
    if (pages[i]['classes'].length == 0){
      out.add(DayPage(width, height, pages[i]['background'], [Container()]));
    }else{

      out.add(DayPage(width, height, pages[i]['background'], pages[i]['classes']));
    }
  }

  print(out);

  return out;

}


