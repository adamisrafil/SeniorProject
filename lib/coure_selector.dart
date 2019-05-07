import 'package:SeniorProject/class_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:SeniorProject/courseManagement.dart';



List global_course = [];
var currentUser;



setCurrentUser(var input ){
  currentUser = input;
}
updateStudent(List courseList){

  for(int i = 0; i<courseList.length; i++){
    for(int j = 0; i<global_course.length; j++){
      if (global_course[j]['Name'] == courseList[i] && notRepeated(global_course[j]['students'], currentUser)){
      var newList = global_course[j]['students'] + [currentUser];
        print('Not Fuckked \n${courseList[i]}\n ${currentUser}\n$newList\n${global_course[i]['iD']}');
        CourseManagement().updateCourseStudent(global_course[i]['iD'], newList);
        break;
      }else{

        print('Fucccckkk\n${courseList[i]}\n${global_course[0]}\n$currentUser');}

    }
  }
}
notRepeated(List vals, String newVal) {
  bool x = true;

  if (vals.length != 0){
    for (int i = 0; i < vals.length; i ++ ){
      if(vals[i] == newVal){
        x = false;
        break;
      }
    }
  }

  return x;
}

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

  }




  //queries for current Courses
  _getCourses() {
     courseManager.getCoursesList().then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {
        print('docs currently not empty');
        coursesFlag = true;
        for (int i = 0; i < docs.documents.length; i++){
          global_course.add({'iD':docs.documents[i].documentID, 'Name':docs.documents[i]['Name'], 'students': docs.documents[i]['students'], 'time': docs.documents[i]['Time'], 'day': docs.documents[i]['DayOfWeek']});
          _classes.add(docs.documents[i]['Name']);
          print(_classes);
          print(docs.documents[i]['students'][0]);
        }

      }else print('fuuuuckkkkkk');
    });
  }





  bool visibility = false;

  List <String> _hardClasses = ['Click to refresh state', ];
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

  Widget getImageAsset(){
    AssetImage assetImage = AssetImage('assets/selector.png');
    Image image = Image(image: assetImage, width: 125.0, height: 125.0,);
    return Container(child: image, margin: EdgeInsets.all(35.0),);
  }

// // Widget getSaveButton(){
//    FloatingActionButton button = FloatingActionButton(onPressed: (){
//
//    });
//  }
 
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
              print('class List ${_classes}');
              return DropdownMenuItem<String>(
                value: '',
                child: Container(width: 350, decoration: BoxDecoration( color: Colors.green[300], borderRadius: BorderRadius.circular(10.0)),child: Text(dropDownStringItem, style: TextStyle(fontSize: 30.0 , fontFamily: 'PoiretOne', fontWeight: FontWeight.w400, color: Colors.white), textAlign: TextAlign.center,)),
              );
            }).toList() ,


    onChanged: (String classPick) {
    setState(() {
    if (_selectedClasses.length < 5 ) {
      if (classPick != ''){

        if(notRepeated(_selectedClasses, classPick)) {
          //TODO: get classes to show on bottom of screen. Use scroll View
          this._selectedClasses.add(classPick);
          showClasses(classPick, _selectedClassWidget );
          classCounter +=1;
          Scaffold.of(context).showSnackBar(SnackBar(content:
          Text('${classPick} has been added to your course list)', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'PoiretOne', fontWeight: FontWeight.bold,color: Colors.white),), backgroundColor: Colors.teal, duration: Duration(milliseconds: 1400),));
          visibility = true;
        }else{
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Cannot Add Repeated Classes! ', textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'PoiretOne', fontWeight: FontWeight.bold, color: Colors.white),), backgroundColor: Colors.redAccent, duration: Duration(milliseconds: 2000),));
        }
      }else{
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Click Again to refresh ', textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'PoiretOne', fontWeight: FontWeight.bold, color: Colors.black54),), backgroundColor: Colors.yellow[700], duration: Duration(milliseconds: 1000),));
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
              children: <Widget>[
                Center(child: Padding(padding: const EdgeInsets.fromLTRB(10.0, 10, 0.0, 10.0),
                                        child: Text('Courses' ,
                                          style: TextStyle(fontSize: 60.0 , fontFamily: 'PoiretOne', fontWeight: FontWeight.w900, color: Colors.teal)),
                                  ),
              )]
                  + _selectedClassWidget+ [Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end ,
                children: <Widget>[
                  Text('Save',
                    style: TextStyle(fontSize: 30.0, fontFamily: 'PoiretOne', fontWeight: FontWeight.bold, color: Colors.black54),
                    textAlign: TextAlign.left,),

                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0 , 0.0, 0.0, 0.0),
                    child: RaisedButton(

                      color: Colors.teal,
                      shape: CircleBorder(),
                      elevation: 15.0,
                      child: Icon(Icons.check, size: 23.0, color: Colors.white),
                      onPressed:(){
                        updateStudent(_selectedClasses);
                        Scaffold.of(context).showSnackBar(SnackBar(content:
                        Text('Courses Updated', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'PoiretOne', fontWeight: FontWeight.bold,color: Colors.white),), backgroundColor: Colors.teal, duration: Duration(milliseconds: 1400),));

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
                        setState(() {
                          _selectedClasses = [];
                          _selectedClassWidget = [];
                          classCounter = 1;
                          visibility = false;
                          Scaffold.of(context).showSnackBar(SnackBar(content:
                          Text('Not Saved', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'PoiretOne', fontWeight: FontWeight.bold,color: Colors.white),), backgroundColor: Colors.redAccent, duration: Duration(milliseconds: 1400),));
                        });

                      } ,
                    ),
                  ),

                ],

              )],
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

