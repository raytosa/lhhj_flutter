import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_aliplayer/flutter_aliplayer.dart';
import 'package:lhhj/page/setting_page.dart';
import 'package:lhhj/util/common_utils.dart';

import '../cfg/sysInfo.dart';
import '../util/myEncrypt.dart';
import '../util/myHttp.dart';

//class myPage extends StatefulWidget{
class myPage extends StatefulWidget {
  int pageNo = 0;
  late String title;
  late AliPlayerView waliPlayerView;

  late FlutterAliplayer wfAliplayer;
  late int wispause = 0;

  //const MyHomePage({super.key, required this.title});
  // myPage({required this.title}) ;

  myPage(
      {required super.key,
      required this.pageNo,
      required this.title,
      required this.wfAliplayer,
      required this.waliPlayerView,
      required this.wispause});

  @override
  _myPageState createState() => _myPageState(
      pageNo: 0,
      title: "11",
      wfAliplayer: this.wfAliplayer,
      waliPlayerView: this.waliPlayerView,
      wispause: this.wispause);
}

class _myPageState extends State<myPage> {
  late AliPlayerView waliPlayerView;

  late FlutterAliplayer wfAliplayer;
  late int wispause = 0;
  late String title;
  late String kj_qi = "-------期";
  late String kj_date = "0001-01-01";
  late Map jsonResult;
  late KaijiangInfo kj_hh = KaijiangInfo("1", "11", [
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
  ]);
  late KaijiangInfo kj_aa = KaijiangInfo("1", "11", [
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
  ]);
  late KaijiangInfo kj_jj = KaijiangInfo("1", "11", [
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
  ]);
  late KaijiangInfo kj_tt = KaijiangInfo("1", "11", [
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
  ]);
  late List<String> kj_b1 = [
    "00",
    "00",
    "00",
    "00",
    "00",
    "00",
    "00",
  ];
  late List<String> kj_col1 = [
    'assets/images/icon_red.png',
    'assets/images/icon_red.png',
    'assets/images/icon_red.png',
    'assets/images/icon_red.png',
    'assets/images/icon_red.png',
    'assets/images/icon_red.png',
    'assets/images/icon_red.png',
  ];
  late List<String> kj_sx1 = ["鼠", "牛", "虎", "兔", "龙", "蛇", "马"];
  final List<String> ball_pic = [
    'assets/images/icon_red.png',
    'assets/images/icon_green.png',
    'assets/images/icon_blue.png'
  ];
  var ball_sx = <String>[
    "鼠",
    "牛",
    "虎",
    "兔",
    "龙",
    "蛇",
    "马",
    "羊",
    "猴",
    "鸡",
    "狗",
    "猪",
  ];
  var list = ['string'];
  var l2 = <String>['111', '222'];
  int pageNo = 0;
  List<String> ball_sx_url1 = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
  ];
  List<String> ball_sx1 = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
  ];

  @override
  _myPageState(
      {required this.pageNo,
      required this.title,
      required this.wfAliplayer,
      required this.waliPlayerView,
      required this.wispause});

  @override
  void initState() {
    debugPrint(this.title + "-123");
    //  fAliPlayerMediaLoader = FlutterAliPlayerMediaLoader();
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < 7; i++) {
      debugPrint(this.title + "-55" + kj_col1[i]);
    }
    // TODO: implement build
    // throw UnimplementedError();
    return Scaffold(
        appBar: AppBar(
          title: Text("$title"),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => CommomUtils.pushPage(context, SettingPage()),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              width: 280,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
                Text(
                  "现场直播",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "高清畅享",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
            ),
            Container(
              width: 250,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent, // background_ onPrimary: Colors._white_,
                  ),
                  onPressed: () async {
                    debugPrint("x");
                    String de = await getService();
                    String relStr = EncryptUtils.decryptAes16(de);
                    debugPrint("--==" + relStr);
                    this.jsonResult = json.decode(relStr);
                    var sult = json.decode(relStr) as List;
                    debugPrint("*1**" + jsonResult.toString());
                    debugPrint("x1xx" + jsonResult.keys.toString());

                    debugPrint("=1==" + sult[0].toString());
                  },
                  child: Text('香港六合彩'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent, // background_ onPrimary: Colors._white_,
                  ),
                  onPressed: () {
                    debugPrint("object");
                    debugPrint("*2**" + jsonResult.toString());
                    debugPrint("x2xx" + jsonResult["hh"].toString());
                    debugPrint("=2==" + jsonResult["hh"][0].toString());
                    debugPrint("*-0-" + jsonResult["hh"][0]["r"]);
                    debugPrint("*-1-" + jsonResult["hh"][0]["s"]);
                    debugPrint("*-2-" + jsonResult["hh"][0]["c"]);
                    int i = 0;
                    jsonResult["hh"].forEach((member) {
                      BallInfo bif = new BallInfo(
                        int.parse(member["c"]),
                        member["r"],
                        member["s"],
                      );
                      kj_hh.binfo[i] = bif;
                      debugPrint('member name is ${member}');
                      debugPrint('Bal- ${kj_hh.binfo[i].bno}-${kj_hh.binfo[i].col}-${kj_hh.binfo[i].sx}');
                      i++;
                    });
                  },
                  child: Text('官网'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent, // background_ onPrimary: Colors._white_,
                  ),
                  onPressed: () async {
                    int de = await getKaijiangInfo();
                    debugPrint("***1*****$de");
                    if (de == 1) {
                      setState(() {
                        debugPrint("**pageNo---$pageNo");
                        switch (pageNo) {
                          case 0:
                          case 1:
                            kj_qi = kj_hh.qi + "期";
                            kj_date = kj_hh.kjdate;
                            for (int i = 0; i < 7; i++) {
                              kj_b1[i] = kj_hh.binfo[i].bno < 10
                                  ? '0' + kj_hh.binfo[i].bno.toString()
                                  : kj_hh.binfo[i].bno.toString();
                              kj_sx1[i] = kj_hh.binfo[i].sx;
                              kj_col1[i] = 'assets/images/icon_' + kj_hh.binfo[i].col + '.png';
                              debugPrint("**kj_col1[$i]---$kj_col1[i]");
                            }
                            break;
                          case 2:
                            kj_qi = kj_aa.qi + "期";
                            kj_date = kj_aa.kjdate;
                            for (int i = 0; i < 7; i++) {
                              kj_b1[i] = kj_aa.binfo[i].bno < 10
                                  ? '0' + kj_aa.binfo[i].bno.toString()
                                  : kj_aa.binfo[i].bno.toString();
                              kj_sx1[i] = kj_aa.binfo[i].sx;
                              kj_col1[i] = 'assets/images/icon_' + kj_aa.binfo[i].col + '.png';
                            }
                            break;
                          case 3:
                            kj_qi = kj_jj.qi + "期";
                            kj_date = kj_jj.kjdate;
                            for (int i = 0; i < 7; i++) {
                              kj_b1[i] = kj_jj.binfo[i].bno < 10
                                  ? '0' + kj_jj.binfo[i].bno.toString()
                                  : kj_jj.binfo[i].bno.toString();
                              kj_sx1[i] = kj_jj.binfo[i].sx;
                              kj_col1[i] = 'assets/images/icon_' + kj_jj.binfo[i].col + '.png';
                            }
                            break;
                          case 4:
                            kj_qi = kj_tt.qi + "期";
                            kj_date = kj_tt.kjdate;
                            for (int i = 0; i < 7; i++) {
                              kj_b1[i] = kj_tt.binfo[i].bno < 10
                                  ? '0' + kj_tt.binfo[i].bno.toString()
                                  : kj_tt.binfo[i].bno.toString();
                              kj_sx1[i] = kj_tt.binfo[i].sx;
                              kj_col1[i] = 'assets/images/icon_' + kj_tt.binfo[i].col + '.png';
                            }
                            break;
                        }
                      });
                    }
                  },
                  child: Text('宝典'),
                ),
              ]),
            ),
            Container(
              width: 360,
              height: 180,
              child: Stack(children: <Widget>[
                waliPlayerView,
                IconButton(
                  icon: Icon(Icons.play_circle_filled),
                  color: Colors.red,
                  alignment: Alignment.bottomCenter,
                  onPressed: () => {
                    debugPrint("wwwwww"),
                    print(wfAliplayer.playerId.runes),
                    debugPrint("eee"),
                    if (wispause != 0)
                      {
                        wispause = 0,
                        wfAliplayer.pause(),
                        print("111"),
                      }
                    else
                      {
                        wispause = 1,
                        wfAliplayer.play(),
                        print("222"),
                      }
                  },
                ),
              ]),
            ),
            Text("."),
            Container(
              width: 310,
              //height : 180,
              child: Stack(
                children: <Widget>[
                  const Image(
                    image: ExactAssetImage('assets/images/ballback.png'),
                    fit: BoxFit.cover, // width: 400,
                    // height: 100,
                  ),
                  Container(
                      width: 300,
                      margin: EdgeInsets.only(top: 5.0, left: 5),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 71,
                            // margin: EdgeInsets.only(top: 50.0),
                            child: Column(
                              children: [
                                Text(
                                  "$kj_qi",
                                  style: const TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 12.0,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "$kj_date",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.0, left: 5),
                            // margin: EdgeInsets.only(top: 50.0),
                            child: Row(
                              children: [
                                for (var i = 0; i < 6; i++)
                                  Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 0, left: 1),
                                        // margin: EdgeInsets.only(top: 50.0),
                                        child: Stack(children: <Widget>[
                                          Image(
                                            image: ExactAssetImage(kj_col1[i]),
                                            //"$ball_pic[kj_col1]"),
                                            width: 30,
                                            height: 30,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 3.0, left: 3),
                                            child: Text(
                                              kj_b1[i],
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ),
                                      Text(
                                        kj_sx1[i],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          //fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                const Text(
                                  "_",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 5.0,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 0, left: 3),
                                      child: Stack(children: <Widget>[
                                        Image(
                                          image: ExactAssetImage(kj_col1[6]),
                                          //"$ball_pic[kj_col1]"),
                                          width: 30,
                                          height: 30,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 3.0, left: 3),
                                          child: Text(
                                            kj_b1[6],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    Text(
                                      kj_sx1[6],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        //fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
/*
                ElevatedButton(
                  child: Text("恢复默认"),
                  onPressed: () {
                    print("a1");
                  },
                ),
                ElevatedButton(
                  child: Text("应用配置"),
                  onPressed: () {
                    print("a2");
                  },
                ),
               */
                        ],
                      )),
                ],
              ),
            ),
          ],
        ));
  }

  Future<int> getKaijiangInfo() async {
    String de = await getService();
    if (de.length > 10) {
      String relStr = EncryptUtils.decryptAes16(de);
      print("--==" + relStr);
      if (relStr.length > 10) {
        Map jrs = json.decode(relStr);
        int i = 0;
        jrs["hh"].forEach((member) {
          BallInfo bif = new BallInfo(
            int.parse(member["c"]),
            member["r"],
            member["s"],
          );
          kj_hh.binfo[i] = bif;
          kj_hh.qi = member["draw"];
          kj_hh.kjdate = member["date"];
          i++;
        });
        i = 0;
        jrs["aa"].forEach((member) {
          BallInfo bif = new BallInfo(
            int.parse(member["c"]),
            member["r"],
            member["s"],
          );
          kj_aa.binfo[i] = bif;
          kj_aa.qi = member["draw"];
          kj_aa.kjdate = member["date"];
          i++;
        });
        i = 0;
        jrs["jj"].forEach((member) {
          BallInfo bif = new BallInfo(
            int.parse(member["c"]),
            member["r"],
            member["s"],
          );
          kj_jj.binfo[i] = bif;
          kj_jj.qi = member["draw"];
          kj_jj.kjdate = member["date"];
          i++;
        });
        i = 0;
        jrs["tt"].forEach((member) {
          BallInfo bif = new BallInfo(
            int.parse(member["c"]),
            member["r"],
            member["s"],
          );
          kj_tt.binfo[i] = bif;
          kj_tt.qi = member["draw"];
          kj_tt.kjdate = member["date"];
          i++;
        });
      }

      return 1;
    } else {
      return -1;
    }
  }
}
