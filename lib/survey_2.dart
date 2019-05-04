import 'package:flutter/material.dart';
import 'evalPage.dart';
import 'survey_1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Classes extends StatefulWidget 
{
 @override
 _ClassesState createState() {
   return _ClassesState();
 }
}


class _ClassesState extends State<Classes> {
  // state variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: Text('Courses')),
     body: _buildBody(context),
   );

  }

Widget _buildBody(BuildContext context) {
 return StreamBuilder<QuerySnapshot>(
   stream: Firestore.instance.collection('courses').snapshots(),
   builder: (context, snapshot) {
     if (!snapshot.hasData) return LinearProgressIndicator();

     return _buildList(context, snapshot.data.documents);
   },
 );
}

 Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
   return ListView(
     padding: const EdgeInsets.only(top: 20.0),
     children: snapshot.map((data) => _buildListItem(context, data)).toList(),
   );
 }

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
 final record = Record.fromSnapshot(data);

   return Padding(
     key: ValueKey(record.Name),
     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
     child: Container(
       decoration: BoxDecoration(
         border: Border.all(color: Colors.grey),
         borderRadius: BorderRadius.circular(5.0),
       ),
       child: ListTile(
  title: Text(record.Name),
         trailing: Text(record.Professor.toString()),
  
  onTap: () {
    Firestore.instance.collection('courses').snapshots();
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ClassSurvey()),



  );
}

)
           
       ),
     );
 }
}

class Record {
 final String Name;
 final String Professor;
 final DocumentReference reference;

 Record.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['Name'] != null),
       assert(map['Professor'] != null),
       Name = map['Name'],
       Professor = map['Professor'];

 Record.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 String toString() => "Record<$Name:$Professor>";
}
