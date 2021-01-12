import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';

import 'video.dart';
import 'config/index.dart';

class Bangumi {
  String id;
  String name;
  String type;
  String iframeSrc;
  String datePublished;

  Bangumi(this.id, this.name, this.type, this.iframeSrc, this.datePublished);

  Bangumi.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        type = json['type'],
        iframeSrc = json['iframeSrc'],
        datePublished = json['datePublished'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'iframeSrc': iframeSrc,
        'datePublished': datePublished
      };
}

class BangumiPage extends StatefulWidget {
  static const routeName = '/bangumi';
  String id;

  BangumiPage({Key key, this.id}) : super(key: key);

  @override
  _BangumiState createState() => _BangumiState();
}

class _BangumiState extends State<BangumiPage> {
  String title = '';
  List<dynamic> _items = [];

  Future<void> fetchData() async {
    String id = widget.id;
    http.Response response = await http.get("$BASE_URL/anime1/$id");
    var ret = jsonDecode(response.body);

    setState(() {
      title = ret["item"]["title"];
      _items = ret["items"].map((item) {
        return Bangumi.fromJSON(item);
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
        title: Text(title),
      ),
      body: ListView(
        children: _items.map((item) {
          int index = _items.length - _items.indexOf(item);

          // DateTime date = DateTime.parse(item.datePublished);
          // String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(date);

          return ListTile(
            title: Text(item.name),
            subtitle: Text(item.type),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                "$index",
                style: TextStyle(color: Colors.white),
              ),
            ),
            onTap: () {
              String id = item.id;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VideoPage(
                          videoSrc: "$BASE_URL/anime1/video/$id/download",
                          title: title
                      )
                    )
                  );
            },
          );
        }).toList(),
      ),
    );
  }
}
