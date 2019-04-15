import 'package:flutter/material.dart';

class ClassWidget extends StatelessWidget {
  @override
  final double width;
  final double height;
  final String text;

  //constructor
  ClassWidget(this.width, this.height, this.text);


  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: Container(
          width: this.width * 0.9,
          height: this.height * 0.12,
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
            child: Row (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    this.text /*TODO: It would be nice for the day to be pulled automatically*/,
                    style: TextStyle(fontSize: width * 0.06, fontFamily: 'PoiretOne', fontWeight: FontWeight.w700),
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
    );
  }
}



class DayPage extends StatelessWidget {

  final double width;
  final double height;
//  final List <Image> backgrounds;//TODO: thinking about merging these into one data structure. so that classes with index[0] == "monday" etc. could this possibly be better to use with firebase? @adam
  final AssetImage background;
  final List <Widget> widgets;
// constructor
  DayPage(this.width, this.height, this.background, this.widgets);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
        child: Center(
            child: Container(
              width: this.width,
              height: this.height,
              decoration: BoxDecoration(
                  image: DecorationImage(image: this.background, fit: BoxFit.fill),
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
              child: Stack(//TODO: may need alignment attributes
                children:<Widget>[Column(mainAxisAlignment: MainAxisAlignment.start, children: widgets,)]
              ),
            )));
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
    return Container(
        width: this.width,
        height: this.height * 0.16,
        decoration: BoxDecoration(
            image: DecorationImage(image: this.background, fit: BoxFit.fill),
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(35.0)),
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
        child: Stack(
          children: <Widget> [
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 100.0) ,
              child: Text(this.text, style: TextStyle(fontFamily: 'Galada', fontSize: this.width * 0.2 , color: Colors.white),),
          ),
          ]
        ));
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
List <DayPage> pageListCreator(List pages, width, height, [List <DayPage> output]){

  if (output == null){
    output = new List <DayPage> ();
  }
  for (var i = 0; i < pages.length; i++){
    List <Widget> temp = []..add(pages[i]['header'])..addAll(pages[i]['classes']);

    output.add(DayPage(width, height, pages[i]['background'], temp));
  }

  return output;
}