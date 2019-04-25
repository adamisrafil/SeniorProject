import 'package:flutter/material.dart';
import 'package:SeniorProject/home_page.dart';
var controlBox = {'CSCI 255 M01': false, 'tuesday': false, 'wednesday': false, 'thursday': false, 'Friday': false};

class ClassWidget extends StatefulWidget {
  final String text;
  final double width;
  final double height;
  final String time ;
  final GlobalKey<ScaffoldState> scaffoldKey;

  ClassWidget(this.width, this.height, this.text, [this.time, Key key, this.scaffoldKey]) :super(key: key );


  @override
  State createState() => ClassWidgetState(width, height, text, time);
}

class ClassWidgetState extends State<ClassWidget> {
  bool _enabledAbsent = false;
  bool _enabledAttend = false;
  final String text;
  final double width;
  final String time;
  double height;
  bool isExpanded = false;
  String snackMessage;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  ClassWidgetState(this.width, this.height, this.text, this.time);



  void _showSnackBar(bool value){
    print (value);

  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
          child: Container(width: this.width * 0.9,
//              height: this.height * 0.12,
              decoration: BoxDecoration(color: Colors.white70,
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
                          style: TextStyle(fontSize: isExpanded ? width * 0.07 : width * 0.09, fontFamily: 'PoiretOne', fontWeight: FontWeight.w700, color: isExpanded ? Colors.teal : Colors.black54),
                          textAlign: TextAlign.left,)
                    // Change header (which is a Container widget in this case) background colour here.
                  ),
                    leading:  Icon(Icons.developer_mode, size: 26.0) ,
                    trailing: isExpanded ? Icon(Icons.keyboard_arrow_up, size: 36.0, color: Colors.blue,) : Icon(Icons.keyboard_arrow_down, size: 36.0, color: Colors.black54),
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
                                      padding: EdgeInsets.fromLTRB(width *0.19 , 0.0, 0.0, 0.0),
                                      child: RaisedButton(

                                        color: Colors.teal,
                                        shape: CircleBorder(),
                                        elevation: 15.0,
                                        child: Icon(Icons.check, size: 23.0, color: Colors.white),
                                        onPressed: (){
                                          //TODO: need help getting this to open camera API. Ran into problem with Global Keys
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
//                                        onPressed: () {
//                                          _enabledAbsent = !_enabledAbsent;
//                                          if (_enabledAbsent){
//                                            scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('you wil be marked as absent from ${this.text})', textAlign: TextAlign.center, style: TextStyle( fontFamily: 'PoiretOne', fontWeight: FontWeight.bold, color: Colors.white),),backgroundColor: Colors.redAccent, ));
//                                          }
//                                        } ,
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


  //find if a class object has changed state

//  bool getState(List <Widget> w) {
//    var temp = false;
//    for (var i = 1; i < w.length; i++) {
//      if (controlBox[w[i].text] == true) {
//        temp = true;
//        return temp;
//      }
//    }
//  }

  // change said class object
//bool changeState(List <Widget> w) {
//    var temp = false;
//    var tempIndex = null;
//    for (var i = 1; i < w.length; i++) {
//      print(w[i]);
//
//    }
//    return true;
//  }

//
////    for (var i = 1; i < w.length; i++) {
////      if (i != tempIndex) {
////        w[i].setHeight(this.height * 0.2)
////      }
////    }
//
//    return w;
//  }

  DayPageState(this.width, this.height, this.background, this.widgets);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
        child: Center(child: Container(width: this.width,
          height: this.height,
          decoration: BoxDecoration(
              image: DecorationImage(image: this.background, fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [ BoxShadow(color: Colors.black87,
                blurRadius: 10.0,
                // has the effect of softening the shadow
                spreadRadius: 10.0,
                // has the effect of extending the shadow
                offset: Offset(1.0, 1.0,),)
              ]),
          child: ListView.builder(itemCount: this.widgets.length ,itemBuilder: (context, position) => widgets[position])))) ;
  }
}


class ClassWidget1 extends StatelessWidget {
  @override
  final double width;
  final double height;
  final String text;

  //constructor
  ClassWidget1(this.width, this.height, this.text);


  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
        child: Container(width: this.width * 0.9,
            height: this.height * 0.12,
            decoration: BoxDecoration(color: Colors.white70,
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: [ BoxShadow(color: Colors.white30,
                  blurRadius: 5.0,
                  // has the effect of softening the shadow
                  spreadRadius: 1.0,
                  // has the effect of extending the shadow
                  offset: Offset(0.0, 2.0,),)
                ]),
            child: Padding(padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                child: Text(text)
//            child: ExpansionTile(
//                title: Text(this.text, style: TextStyle(fontSize: width * 0.06, fontFamily: 'PoiretOne', fontWeight: FontWeight.w700), textAlign: TextAlign.left,),
//          )),
            )));
  }
}


class DayPage1 extends StatelessWidget {

  final double width;
  final double height;
  final AssetImage background;
  final List <Widget> widgets;

// constructor
  DayPage1(this.width, this.height, this.background, this.widgets);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
        child: Center(child: Container(width: this.width,
          height: this.height,
          decoration: BoxDecoration(
              image: DecorationImage(image: this.background, fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [ BoxShadow(color: Colors.black87,
                blurRadius: 10.0,
                // has the effect of softening the shadow
                spreadRadius: 10.0,
                // has the effect of extending the shadow
                offset: Offset(1.0, 1.0,),)
              ]),
          child: Stack( //TODO: may need alignment attributes
              children: <Widget>[ Column(
                mainAxisAlignment: MainAxisAlignment.start, children: widgets,)
              ]),)));
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
            boxShadow: [ BoxShadow(color: Colors.white30,
              blurRadius: 5.0,
              // has the effect of softening the shadow
              spreadRadius: 1.0,
              // has the effect of extending the shadow
              offset: Offset(0.0, 2.0,),)
            ]),
        child: Stack(children: <Widget>[ Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 100.0),
          child: Text(this.text, style: TextStyle(fontFamily: 'Galada',
              fontSize: this.width * 0.2,
              color: Colors.white),),),
        ]));
  }
}


//initialize image backgrounds
var monday = new AssetImage('assets/cal_Backgrounds/monday.jpg');
var tuesday = new AssetImage('assets/cal_Backgrounds/tuesday.jpg');
var wednesday = new AssetImage('assets/cal_Backgrounds/wednesday.jpg');
var thursday = new AssetImage('assets/cal_Backgrounds/monday.jpg');
var friday = new AssetImage('assets/cal_Backgrounds/friday.png');

var one = new AssetImage('assets/headerbackgrounds/one.jpeg');
var two = new AssetImage('assets/headerbackgrounds/two.png');
var three = new AssetImage('assets/headerbackgrounds/three.png');
var four = new AssetImage('assets/headerbackgrounds/four.jpg');
var five = new AssetImage('assets/headerbackgrounds/five.png');


// takes in a dictionary list that contains all pages to be created along with their inputs {see var pageListInput in _showClassDashboard Widget located at home_page.dart} and returns an output list if one isn't given
// if an output list is given. then it appends to that list
List <DayPage> pageListCreator(List pages, width, height, [List <DayPage> output]) {
  if (output == null) {
    output = new List <DayPage> ();
  }
  for (var i = 0; i < pages.length; i++) {
    List <Widget> temp = []..add(pages[i]['header'])..addAll(pages[i]['classes']);

    output.add(DayPage(width, height, pages[i]['background'], temp));
  }

  return output;
}

