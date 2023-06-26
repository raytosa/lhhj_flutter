import 'package:flutter/material.dart';

class webPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _webPageState();
}

class _webPageState extends State<webPage> {
  int _pt=0;
  List<String> xz_lab=['安卓客户端下载','iOS客户端下载',];
  List<String> xz_lab1=['点击切换iOS客户端下载','点击切换安卓客户端下载',];
  List<String> xz_lab2=['点击切换iOS客户端下载','点击切换安卓客户端下载',];
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar:  AppBar(
        title:  Text('客户端下载'),
        actions: <Widget>[
          Container()
        ],
      ),
      body: Center(
        child: Column(

          children: [
            Container(
              margin: const EdgeInsets.only(top: 50.0, left: 15, right: 15),
              width: 200,
              child:ElevatedButton(

                style: ElevatedButton.styleFrom(

                  primary: Colors.redAccent, // background_ onPrimary: Colors._white_,
                ),
                onPressed: ()  {
                  print(_pt);
                  setState(() {
                    if (_pt==0) {    _pt=1;  }
                    else{ _pt=0;  }
                    print(_pt);
                  });
                },
                child: Text(xz_lab[_pt],
                  style: const TextStyle(  color: Colors.black,   fontSize: 20.0,   fontWeight: FontWeight.bold,  ),
                ),
              ),
            ),

            Text(xz_lab1[_pt],
              style: const TextStyle(  color: Colors.black,   fontSize: 14.0,   fontWeight: FontWeight.bold,  ),
            ),
            Container(

            ),
          ],

        ),
      ),
    );

  }
}