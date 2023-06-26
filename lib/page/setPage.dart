import 'package:flutter/material.dart';

class setPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _setPageState();
}
class _setPageState extends State<setPage> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('setting'),
          actions: <Widget>[
            new Container()
          ],
        ),
        body: new Center(
          child: null,
        ),
      ),
    );
  }
}