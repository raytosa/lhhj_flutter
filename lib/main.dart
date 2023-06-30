import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lhhj/util/myHttp.dart';

import 'package:lhhj/util/navigation_icon_view.dart';


void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//BackgroundFetch

    return MaterialApp(
      home:
      TabNavigator(),//

      //myHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,   // 设置主题颜色
      ),
    );
  }
}