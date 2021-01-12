import 'package:flutter/material.dart';

import 'home.dart';
import 'bangumi.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime1',
      theme: ThemeData(
        primaryColor: Colors.red[900],
      ),
      home: HomePage(),
      // routes: { 
      //   BangumiPage.routeName: (context) {
      //     dynamic obj = ModalRoute.of(context).settings.arguments;
      //     return new BangumiPage(id: obj["id"] );
      //   }
      // },
    );
  }
}
