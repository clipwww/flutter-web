import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'config/index.dart';
import 'bangumi.dart';

class Anime {
  String id;
  String name;
  String description;

  Anime(this.id, this.name, this.description);

  Anime.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'description': description};
}

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  List<dynamic> _items = [];

  Future<void> fetchData() async {
    http.Response response = await http.get("$BASE_URL/anime1");
    var ret = jsonDecode(response.body);

    setState(() {
      _items = ret['items'].map((item) {
        return Anime.fromJSON(item);
      }).toList();
    });
  }

  @override
  void initState() {
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anime1 新番列表"),
      ),
      body: ListView(
        children: _items.map((item) {
          return ListTile(
            title: Text(item.name),
            subtitle: Text(item.description),
            onTap: () {
              // Navigator.pushNamed(context, '/bangumi',
              //     arguments: {'id': item.id});
              Navigator.push(context, MaterialPageRoute(builder: (context) => BangumiPage(id: item.id)));
            },
          );
        }).toList(),
      ),
    );
  }
}
