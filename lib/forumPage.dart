import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';

import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import 'package:SeniorProject/userManager.dart';
import 'package:SeniorProject/user.dart';

import 'package:google_sign_in/google_sign_in.dart';


class ForumPage extends StatefulWidget {
  @override
  _ForumPageState createState() => new _ForumPageState();
}

class _ForumPageState extends State<ForumPage> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false; // make it true whenever the user is typing in the input field.

  String accountStatus = '******';
  FirebaseUser mCurrentUser;
  FirebaseAuth _auth;
  User updatedUser = new User();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  var userManager = new UserManager();
  String usersName = "Go to settings and update";

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _getCurrentUser();
    print('here outside async');

  }
  _getCurrentUser () async {
    mCurrentUser = await _auth.currentUser();
    print('Hello ' + mCurrentUser.uid);
    setState(() {
      mCurrentUser != null ? accountStatus = 'Signed In' : 'Not Signed In';
    });
    _getName();
  }
  _getName() async{
    await userManager.getUserName(mCurrentUser.uid).then((String res) {
      print("Name incoming: " + res);
      setState(() {
        res != null ? usersName = res.toString() : "Having trouble";
      });
    });
  }
  
  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: _handleSubmitted,
                decoration:
                new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? new CupertinoButton(
                  child: new Text("Send"),
                  onPressed: _isComposing
                      ? () => _handleSubmitted(_textController.text)
                      : null,
                )
                    : new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: _isComposing
                      ? () => _handleSubmitted(_textController.text)
                      : null,
                )),
          ]),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
              border:
              new Border(top: new BorderSide(color: Colors.grey[200])))
              : null),
    );
  }

  Future<Null> _handleSubmitted(String text) async {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    _sendMessage(text: text);
  }

  void _sendMessage({ String text }) {
    _getName();
    reference.push().set({
      'text': text,
      'senderName': usersName,
    });
    analytics.logEvent(name: 'send_message');
  }

  Widget communityPage(){
    return Column (
      children: <Widget>[
        ListTile(
          title: Text('Architecture'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(context, new MaterialPageRoute(
                builder: (context)=> new CommunityCrudPost()));
          },
        ),
        ListTile(
          title: Text('Business'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(context, new MaterialPageRoute(
                builder: (context)=> new CommunityCrudPost()));
          },
        ),
        ListTile(
          title: Text('Communications'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(context, new MaterialPageRoute(
                builder: (context)=> new CommunityCrudPost()));
          },
        ),
        ListTile(
          title: Text('Engineering'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(context, new MaterialPageRoute(
                builder: (context)=> new CommunityCrudPost()));
          },
        ),
        ListTile(
          title: Text('Science'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(context, new MaterialPageRoute(
                builder: (context)=> new CommunityCrudPost()));
          },
        ),
      ],
    );
  }
  Widget feedPage(){
    return new Scaffold(
        body: new Column(children: <Widget>[
          new Flexible(
            child: new FirebaseAnimatedList(
              query: reference,
              sort: (a, b) => b.key.compareTo(a.key),
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, DataSnapshot snapshot, Animation<double> animation, int index ) {
                return new ChatMessage(
                    snapshot: snapshot,
                    animation: animation
                );
              },
            ),
          ),
          new Divider(height: 1.0),
          new Container(
            decoration:
            new BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ]));
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: new AppBar(
          title: new Text("Forums"),
          elevation:
          Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
          bottom: TabBar(tabs: [
            Tab(text: 'Feed Chat'),
            Tab(text: 'Community',)
          ]),
        ),
        body: TabBarView(
          children: [
            feedPage(),
            communityPage(),
            //put new class stateless widget here and in the new class call pagewiselistview
          ],
        ),),
    );
  }
}


class FriendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new ForumPage(),
    );
  }
}

final googleSignIn = new GoogleSignIn();
final analytics = new FirebaseAnalytics();
final auth = FirebaseAuth.instance;
final reference = FirebaseDatabase.instance.reference().child('messages');
String _name = "Anonymous";

class ChatMessage extends StatelessWidget {
  ChatMessage({this.snapshot, this.animation});
  final DataSnapshot snapshot;
  final Animation animation;

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
        sizeFactor: new CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut
        ),
        axisAlignment: 0.0,
        child: new Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: new CircleAvatar(child: new Text(_name[0])),
              ),
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text( snapshot.value['senderName'], style: Theme.of(context).textTheme.subhead),
                    new Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: new Text( snapshot.value['text']),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
class PagewiseListViewExample extends StatelessWidget {
  static const int PAGE_SIZE = 10;

  @override
  Widget build(BuildContext context) {
    return PagewiseListView(
        pageSize: PAGE_SIZE,
        itemBuilder: this._itemBuilder,
        pageFuture: (pageIndex) =>
            BackendService.getPosts(pageIndex * PAGE_SIZE, PAGE_SIZE));
  }

  Widget _itemBuilder(context, PostModel entry, _) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.person,
            color: Colors.brown[200],
          ),
          onTap: () {
            Navigator.push(
                context, new MaterialPageRoute(
                builder: (context) => new crudPost(entry))
            );
          },
          title: Text(entry.title),
          subtitle: Text(entry.body),
        ),
        Divider(),
      ],

    );
  }
}
class CommunityCrudPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Forums Page'),
            bottom: TabBar(tabs: [
              Tab(text: 'Community',)
            ]),
          ),
          body: TabBarView(
            children: [
              PagewiseListViewExample(),
              //put new class stateless widget here and in the new class call pagewiselistview
            ],
          ),
        )
    );
  }
}
class crudPost extends StatelessWidget {
  final PostModel entry;

  crudPost(this.entry);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(entry.title),
      ),
      body: Column(
          children: <Widget>[
            new Text(
              entry.title,
              style: TextStyle(fontSize: 20.0),
            ),
            new Text(
              entry.body,
            ),
            new Padding(padding: EdgeInsets.only(top: 50.0)),
            //            //new Icon(),
            new Text('Reply Post',style: new TextStyle(fontSize: 20.0),),
            new Padding(padding: EdgeInsets.only(top: 10.0)),
            new TextFormField(
              decoration: new InputDecoration(
                  labelText: 'Comment', hintText: 'e.g asdggdf'),
            ),
            new Container(
                padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                child: new RaisedButton(
                  child: const Text('Submit'),
                )),
          ]),
    );
  }
}

class BackendService {
  static Future<List<PostModel>> getPosts(offset, limit) async {
    final responseBody = (await http.get(
        'http://jsonplaceholder.typicode.com/posts?_start=$offset&_limit=$limit'))
        .body;

    // The response body is an array of items
    return PostModel.fromJsonList(json.decode(responseBody));
  }

  static Future<List<ImageModel>> getImages(offset, limit) async {
    final responseBody = (await http.get(
        'http://jsonplaceholder.typicode.com/photos?_start=$offset&_limit=$limit'))
        .body;

    // The response body is an array of items.
    return ImageModel.fromJsonList(json.decode(responseBody));
  }
}

class PostModel {
  String title;
  String body;

  PostModel.fromJson(obj) {
    this.title = obj['title'];
    this.body = obj['body'];
  }

  static List<PostModel> fromJsonList(jsonList) {
    return jsonList.map<PostModel>((obj) => PostModel.fromJson(obj)).toList();
  }
}

class ImageModel {
  String title;
  String id;
  String thumbnailUrl;

  ImageModel.fromJson(obj) {
    this.title = obj['title'];
    this.id = obj['id'].toString();
    this.thumbnailUrl = obj['thumbnailUrl'];
  }

  static List<ImageModel> fromJsonList(jsonList) {
    return jsonList.map<ImageModel>((obj) => ImageModel.fromJson(obj)).toList();
  }
}