import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForumPage extends StatefulWidget {
  @override
  _ForumPageState createState() => new _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  // PageController _pageController;
  //int _page = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Forums Page'),
              actions: <Widget>[
                IconButton(
                    tooltip: 'Search',
                    icon: const Icon(Icons.search),
                    onPressed: (){},
                )],
            bottom: TabBar(tabs: [
              Tab(text: 'Feed'),
              Tab(text: 'Community',)
            ]),
          ),
          body: TabBarView(
            children: [
              FeedPage(),
              CommunityPage(),
              //put new class stateless widget here and in the new class call pagewiselistview
            ],
          ),
      ),
    );
  }
}
class crudPost extends StatelessWidget {
//final PostModel postModel;

//crudPost(this.postModel);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Details"),
      ),
      body: Center(
        child: Text(
          "asfg",
          //postModel.title,
          style: TextStyle(fontSize: 35.0),
        ),
      ),
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
          //PagewiseListViewExample(),
          //CommunityPage(),
          //put new class stateless widget here and in the new class call pagewiselistview
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
        showDialog(
            context: context,
            builder: (_) => new AlertDialog(
              title: new Text("Dialog Title"),
              content: new Row(
                children: <Widget> [
                  new Expanded (
                      child: new TextField(
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Title', hintText: 'e.g asdggdf'),
                      )
                  ),
                  new Expanded (
                      child: new TextField(
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Question', hintText: 'e.g asdggdf?'),
                      )
                  )
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
        )},
        child: new Icon(Icons.add),
      ),
    )
    );
  }
}

class CommunityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Architecture'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(
                context, new MaterialPageRoute(
                builder: (context) => new CommunityCrudPost())
            );
          },
        ),
        ListTile(
          title: Text('Business'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(
                context, new MaterialPageRoute(
                builder: (context) => new CommunityCrudPost())
            );
          },
        ),
        ListTile(
          title: Text('Communications'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(
                context, new MaterialPageRoute(
                builder: (context) => new CommunityCrudPost())
            );
          },
        ),
        ListTile(
          title: Text('Engineering'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(
                context, new MaterialPageRoute(
                builder: (context) => new CommunityCrudPost())
            );
          },
        ),
        ListTile(
          title: Text('Science'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(
                context, new MaterialPageRoute(
                builder: (context) => new CommunityCrudPost())
            );
          },
        ),

      ],
    );
  }
}

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
      child: Scaffold(
      body: TabBarView(
        children: [
          PagewiseListViewExample(),
          //PagewiseListViewExample(),
          //CommunityPage(),
          //put new class stateless widget here and in the new class call pagewiselistview
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
        showDialog(
            context: context,
            builder: (_) => new AlertDialog(
              title: new Text("Dialog Title"),
              content: new Row(
                children: <Widget> [
                  new Expanded (
                      child: new TextField(
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Title', hintText: 'e.g asdggdf'),
                      )
                  ),
                  new Expanded (
                      child: new TextField(
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Question', hintText: 'e.g asdggdf?'),
                      )
                  )
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
        )},
        child: new Icon(Icons.add),
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
              builder: (context) => new crudPost())
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

