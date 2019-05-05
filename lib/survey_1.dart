import 'dart:async';
import 'package:flutter/material.dart';
import 'evalPage.dart';
import 'thank_you.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class ClassSurvey extends StatefulWidget {

  @override
  _ClassSurveyState createState() => new _ClassSurveyState();
}

 class _ClassSurveyState extends State<ClassSurvey> {
@override 
Widget build(BuildContext context){
return new Scaffold(
  appBar: new AppBar(
  title: new Text('Courses'),
),
body: ListPage(),
);

}

 }


class ListPage extends StatefulWidget{
@override

_ListPageState createState() => _ListPageState();

}
class _ListPageState extends State<ListPage>{
  Future _data;

  Future getCourses() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("courses").getDocuments();
    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot course){
Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(course: course,)));
  }

void initState(){
  super.initState();
  _data = getCourses();
}

@override
Widget build (BuildContext context){
  return Container(
    
  
  child: FutureBuilder(
    future: _data,
    builder:(_, snapshot){
if(snapshot.connectionState == ConnectionState.waiting){
return Center(
  child: Text("Loading ..."),
);
} else {
return ListView.builder(
  itemCount: snapshot.data.length,
  itemBuilder: (_, index){
return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
     child: Container(
       decoration: BoxDecoration(
         border: Border.all(color: Colors.grey),
         borderRadius: BorderRadius.circular(5.0),
       ),
    child: ListTile(
      
       title: Text(snapshot.data[index].data["Name"]),
       subtitle: Text(snapshot.data[index].data["Professor"]),
      onTap:() => navigateToDetail(snapshot.data[index]),
     
    ),
    
     )
     );
});
}


  }),
  );
}

}

class DetailPage extends StatefulWidget{
  final DocumentSnapshot course;
  DetailPage({this.course});

@override

_DetailPageState createState() => _DetailPageState();

}
class _DetailPageState extends State<DetailPage>{
@override

Widget build (BuildContext context){
  return Scaffold(
    appBar: AppBar(
title: Text(widget.course.data["Name"]),
    ),
    body: _buildBody(context),
    
    
  );

}
Widget _buildBody(BuildContext context) {
 return Container(
      child: Center(
        child: StreamBuilder(
   stream: Firestore.instance
   .collection('courses')
   .document('Ds4nSVofYhYzTTvZLMBs')
   .collection('evaluations')
   .snapshots(),
   builder: (context, snapshot) {
     if (!snapshot.hasData) return LinearProgressIndicator();

     return _buildList(context, snapshot.data.documents);

   },
        ),),
 );
 

}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
return Column(
children:[
Expanded(
child:ListView(
     padding: const EdgeInsets.only(top: 20.0),
     children: snapshot.map((data) => _buildListItem(context, data)).toList(),
   ),),
   RaisedButton (
  
               onPressed: () {
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThankYouPage()),
            );
               },
              child: new Text(
                                              'Done',
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16.0,
                                                  color: Colors.white),
                                            ),
                                            color: Theme.of(context).accentColor,
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        20.0)),
                                          ),
 ],);

 }

 Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
 final record = Record.fromSnapshot(data);

   return Padding(
     key: ValueKey(record.question),
     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
     child: Container(
       decoration: BoxDecoration(
         border: Border.all(color: Colors.grey),
         borderRadius: BorderRadius.circular(5.0),
       ),
       child:
ListTile(
        title: Text(record.question),
        trailing: Text(record.votes.toString()),

         
     onTap: () => record.reference.updateData({
          'votes': record.votes +1,
  

      }),
  onLongPress: () => record.reference.updateData({
          'votes': record.votes - 1,
           }),
)

       
       ),
     );
 }
}

class Record {
 final String question;
 final int votes;
 final DocumentReference reference;

 Record.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['question'] != null),
       assert(map['votes'] != null),
       question = map['question'],
       votes = map['votes'];

 Record.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 String toString() => "Record<$question:$votes>";
}
