import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:SeniorProject/courseManagement.dart';
import 'package:SeniorProject/user.dart';

class CourseSelector extends StatefulWidget {

  final CourseManagement courseManagement;

  CourseSelector([this.courseManagement, ]);

  @override
  _CourseSelectorState createState() => _CourseSelectorState();
}

class _CourseSelectorState extends State<CourseSelector> {

  var courseManager = new CourseManagement();

  List <String> _classes = [];

  bool coursesFlag = false;


  @override
  void initState() {
    super.initState();
    _getCourses();
    courseManager.updateCourseStudent('CSCI 355 - M01');
  }



  //queries for current Courses
  _getCourses() async{
    await courseManager.getCoursesList().then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {
        print('docs currently not empty');
        print(docs.documents[0]['Name']);
        coursesFlag = true;
        for (int i = 0; i < docs.documents.length; i++){
          _classes.add(docs.documents[i]['Name']);
          print(_classes);
        }
      }else print('fuuuuckkkkkk');
    });
  }




  bool visibility = false;

  List <String> _hardClasses = ['CSCI 1', 'CSCI 1', 'CSCI 1', ];
  List <String> _selectedClasses  = [];
  List <Widget> _selectedClassWidget = [];
  int classCounter = 1;





//select a class and spits out a widget
  void showClasses(String pick, [List<Widget> out]){
    out.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10, 0.0, 20.0),
          child: Text('${classCounter}. ${pick}' , style: TextStyle(fontSize: 30.0 , fontFamily: 'PoiretOne', fontWeight: FontWeight.w700, color: Colors.black54)),
        )
    );
  }
  notRepeated(List<String> vals, String newVal) {
    bool x = true;
    for (int i = 0; i < vals.length; i ++ ){
      if(vals[i] == newVal){
        x = false;
        break;
      }
    }


    return x;
  }
  Widget getImageAsset(){
    AssetImage assetImage = AssetImage('assets/selector.png');
    Image image = Image(image: assetImage, width: 125.0, height: 125.0,);
    return Container(child: image, margin: EdgeInsets.all(35.0),);
  }

  Widet getSaveButton(){
    FloatingActionButton button = FloatingActionButton(onPressed: (){

    });
  }
 
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(

      backgroundColor: Colors.white12,
      appBar: new AppBar(
        backgroundColor: Colors.teal[800],
        title: new Text('class Selector'),
      ),
      body: Builder(
        builder: (BuildContext context){
    return SingleChildScrollView(
    child: Column(
    children: <Widget>[
    Center(child: getImageAsset(),),

    DropdownButton<String>(
    //key: ,
    items:
        _classes.isNotEmpty?
            _classes.map((String dropDownStringItem){
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Container(width: 350, decoration: BoxDecoration( color: Colors.green[300], borderRadius: BorderRadius.circular(10.0)),child: Text(dropDownStringItem, style: TextStyle(fontSize: 30.0 , fontFamily: 'PoiretOne', fontWeight: FontWeight.w400, color: Colors.white), textAlign: TextAlign.center,)),
              );
            }).toList()
            :
            _hardClasses.map((String dropDownStringItem){
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Container(width: 350, decoration: BoxDecoration( color: Colors.green[300], borderRadius: BorderRadius.circular(10.0)),child: Text(dropDownStringItem, style: TextStyle(fontSize: 30.0 , fontFamily: 'PoiretOne', fontWeight: FontWeight.w400, color: Colors.white), textAlign: TextAlign.center,)),
              );
            }).toList() ,


    onChanged: (String classPick) {
    setState(() {
    if (_selectedClasses.length < 5) {

      if(notRepeated(_selectedClasses, classPick)) {
        //TODO: get classes to show on bottom of screen. Use scroll View
        this._selectedClasses.add(classPick);
        showClasses(classPick, _selectedClassWidget );
        classCounter +=1;
        Scaffold.of(context).showSnackBar(SnackBar(content:
            Text('${classPick} has been added to your course list)', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'PoiretOne', fontWeight: FontWeight.bold,color: Colors.white),), backgroundColor: Colors.teal, duration: Duration(milliseconds: 1400),));
        visibility = true;
        print(_selectedClasses); //TODO delete print statement
        print(_classes[0]);
      }else{
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Cannot Add Repeated Classes! ', textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'PoiretOne', fontWeight: FontWeight.bold, color: Colors.white),), backgroundColor: Colors.redAccent, duration: Duration(milliseconds: 2000),));
      }
    }
    else{
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Speak to your advisor before adding more than five classes! ', textAlign: TextAlign.center,
    style: TextStyle(fontFamily: 'PoiretOne', fontWeight: FontWeight.bold, color: Colors.white),), backgroundColor: Colors.redAccent, duration: Duration(milliseconds: 2000),));
    }
    });},
    hint: Text('Select Classes' , style: TextStyle(fontSize: 40.0 , fontFamily: 'PoiretOne', fontWeight: FontWeight.w700, color: Colors.teal)),
    style: TextStyle(fontSize: 15.0 , fontFamily: 'PoiretOne', fontWeight: FontWeight.w400, color: Colors.white), iconSize: 55.0,
    ),
    Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
      child: AnimatedOpacity(
        opacity: visibility ? 1.0 : 0.0 ,
        duration: Duration(milliseconds: 3000),
        child: Container(
          decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0)),
              boxShadow: [ BoxShadow(color: Colors.tealAccent,
                blurRadius: 3.0,
                // has the effect of softening the shadow
                spreadRadius: 1.0,
                // has the effect of extending the shadow
                offset: Offset(3.0, 2.0,),)
              ]),
          width: 400,
//        TODO: add function here to append to courses
        child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[Center(
                child: Padding(padding: const EdgeInsets.fromLTRB(10.0, 10, 0.0, 10.0),
                                        child: Text('Courses' ,
                                          style: TextStyle(fontSize: 60.0 , fontFamily: 'PoiretOne', fontWeight: FontWeight.w900, color: Colors.teal)),
                                  ),
              )] + _selectedClassWidget,
        ),
//          child: widget(child: Text('Courses \n course' , style: TextStyle(fontSize: 40.0 , fontFamily: 'PoiretOne', fontWeight: FontWeight.w700, color: Colors.teal))),

        ),
      ),
    ),


    ],
    ),
    );
    },
    )

    );
  }
}

