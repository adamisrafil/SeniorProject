import 'package:flutter/material.dart';
import 'evalPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'thank_you.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClassSurvey extends StatefulWidget 
{
 @override
 _ClassSurveyState createState() {
   return _ClassSurveyState();
 }
}


class _ClassSurveyState extends State<ClassSurvey> {
  // state variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: Text('Class Evaluation')),
     body: _buildBody(context),
   );

  }

Widget _buildBody(BuildContext context) {
 return StreamBuilder<QuerySnapshot>(
   stream: Firestore.instance
   .collection('courses')
   .document('Ds4nSVofYhYzTTvZLMBs')
   .collection('evaluations')
   .snapshots(),
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


