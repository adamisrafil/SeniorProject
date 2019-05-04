import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:SeniorProject/user.dart';

class CourseManagement {

  //list of Courses
  Future <QuerySnapshot> getCoursesList () async{

    return Firestore.instance.collection('courses').orderBy('Name').getDocuments();

  }

  updateCourseStudent (String courseName) async{

    String ref = await Firestore.instance.collection('courses').where('Name', isEqualTo: courseName ).reference().id;
    print(ref);
    return ref;
  }
  
  

  Future<void> updateCourse(Course course, String uid) async {
    Map<String, dynamic> courseData = Map();
    courseData["name"] = course.name;
    courseData["dayOfWeek"] = course.dayOfWeek;
    courseData["professor"] = course.professor;
    courseData["time"] = course.time;
    courseData["attendanceId"] = course.attendanceId;
    courseData["students"] = course.students;


    Firestore.instance.collection("courses").document(uid).setData(courseData, merge: true);
  }


  //returns course days
  Future<List> getCourseDays(String courseID) async {
    print("we called the getCourseDays function");
    DocumentSnapshot snapshot = await Firestore.instance.collection("courses").document(courseID).get();
    var schedule = snapshot['DayOfWeek'];
    if (schedule is List){
      print("we got the course schedule captain");
      return schedule;
    }
    else{
      return [];
    }
  }

//
//// get a list of available course
//  Future<List> getCourseList(List emptyList) async {
//    print("we called the getcourseList function");
//    QuerySnapshot querySnapshot = await Firestore.instance.collection("courses").getDocuments();
//
//    var list = querySnapshot.documents;
//    if(!list.isEmpty)  print('loading class data... Hollupaminute');
//    for (int i =0 ; i < list.length; i++) {
//      emptyList.add(list[i]['Name']);
//    }
//
//    return emptyList;
//  }

  //get course Time
  Future<String> getCourseTime(String courseID) async {
    print("we called the getUserRole function");
    DocumentSnapshot snapshot = await Firestore.instance.collection("courses").document(courseID).get();
    var time = snapshot['time'];
    if (time is String){
      print("we got the time captain");
      return time;
    }
    else{
      return "null";
    }
  }
}