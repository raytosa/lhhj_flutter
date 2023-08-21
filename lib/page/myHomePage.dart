import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aliplayer/flutter_aliplayer.dart';
import 'package:flutter_aliplayer/flutter_aliplayer_factory.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

import 'package:url_launcher/url_launcher.dart';

import '../cfg/sysInfo.dart';
import '../util/common_utils.dart';
import '../util/myEncrypt.dart';
import '../util/myHttp.dart';

class MyHomePageTab extends StatefulWidget {
  late Orientation orientation;

  final String title;
  final Function refresh;

  //const MyHomePage({super.key, required this.title});
  MyHomePageTab({required this.title, required Function this.refresh});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePageTab> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late Timer _getServerDataTimer;

  int _timeStep = 0;
  late TabController _tabController;

//class _MyHomePageState extends State<MyHomePageTab> {
  late AliPlayerView waliPlayerView;

  late FlutterAliplayer wfAliplayer;
  bool wfAliplayer_urlIsSet = false;
  bool wispause = false;



  //设置播放源，URL播放方式//
  // fAliplayer.setUrl( "http://ha.jmied.com/aa/aa.flv?auth_key=1661958232-0-0-3d9174957759709f8b53448167c0b6f6");
  //http://ha.jmied.com/aa/aa.m3u8?auth_key=1661958232-0-0-114df08fce17ecb21f6bf42de85e7600
  //fAliplayer.setUrl("artc://ha.jmied.com/aa/aa?auth_key=1661958232-0-0-d398767e30cfb93b0f1178935bff2d05");
  //fAliplayer.setUrl("https://player.alicdn.com/video/aliyunmedia.mp4");
//fAliplayer.setUrl("artc://ha.jmied.com/aa/aa?auth_key=1661958232-0-0-d398767e30cfb93b0f1178935bff2d05");
  //fAliplayer.setUrl("http://ha.jmied.com/aa/aa.m3u8?auth_key=1661958232-0-0-114df08fce17ecb21f6bf42de85e7600");



  int _tabIndex = 0;
  int _ADIndex = 0;

  KaijiangInfo kj_hh = KaijiangInfo("1", "11", [
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
  ]);
  KaijiangInfo kj_aa = KaijiangInfo("1", "11", [
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
  ]);
  KaijiangInfo kj_jj = KaijiangInfo("1", "11", [
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
  ]);
  KaijiangInfo kj_tt = KaijiangInfo("1", "11", [
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
    BallInfo(0, "r", "s"),
  ]);

  String kj_qi = "-----期";
  String kj_date = "0000-00-00";
  List<String> kj_b1 = [
    "00",
    "00",
    "00",
    "00",
    "00",
    "00",
    "00",
  ];
  List<String> kj_col1 = [
    'assets/images/icon_red.png',
    'assets/images/icon_red.png',
    'assets/images/icon_red.png',
    'assets/images/icon_red.png',
    'assets/images/icon_red.png',
    'assets/images/icon_red.png',
    'assets/images/icon_red.png',
  ];
  List<String> kj_sx1 = ["鼠", "牛", "虎", "兔", "龙", "蛇", "马"];
  Icon icon1 = Icon(Icons.play_circle_filled);
  Icon icon2 = Icon(Icons.pause_circle_filled);
  Icon play_Icons = Icon(Icons.pause_circle_filled);

  final List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  int _isGetDate = 0;

  late CarouselSliderController _sliderController;
  double _screenWidth = 1.0;
  double _screenHeight = 1.0;
  double _fonth = 1.0;
  double _fontSize = 16;
  double _fontSizeLab = 12;
  double _awidth = 30;
  double _aheight = 0;

  @override
  void initState() {
    super.initState();
    debugPrint("***00---2345----------------------**");
    widget.orientation =Orientation.portrait;
    wfAliplayer = FlutterAliPlayerFactory.createAliPlayer();
    // if(wfAliplayer_urlIsSet == false)
    {
      wfAliplayer.setUrl(CommomUtils.MyHomePageTab_PlayList[0]);
      wfAliplayer_urlIsSet = true;
      wfAliplayer.setAutoPlay(true);
      wfAliplayer.prepare();
      debugPrint("********---3-------------------------------");
    }

    // 初始化TabController，并指定初始索引和长度
    _tabController = TabController(initialIndex: 0, length: 4, vsync: this);
    _tabController.addListener(() {
      //点击tab回调一次，滑动切换tab不会回调
      if (_tabController.indexIsChanging) {
        debugPrint("ysl--${_tabController.index}");
      }

      //点击tab时或滑动tab回调一次
      if (_tabController.index.toDouble() == _tabController.animation?.value) {
        debugPrint("ysl${_tabController.index}");
      }
    });

    _sliderController = CarouselSliderController();

    _getServerDataTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      if (_isGetDate > 0) {
        if (_timeStep < 120) {
          _timeStep++;
        } else {
          _timeStep = 0;
          _isGetDate = 0;
        }
      }
      getKaijiangInfo();
      debugPrint("***00*****$_isGetDate");
      if (_isGetDate == 1) {
        setState(() {
          debugPrint("**pageNo---$_tabIndex");
          setKaijiangData();
          _isGetDate = 2;
        });
      }
    });
    WidgetsBinding.instance.addObserver(this);
    debugPrint("addObserver`````````````````````");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      wfAliplayer.play();
      wispause = false;
      debugPrint("切换到了前台`````````````````````");
    } else if (state == AppLifecycleState.paused) {
      wispause = true;
      wfAliplayer.pause();
      debugPrint("切换到了后台``````````````````````");
    }
  }

  @override
  void dispose() {
    debugPrint("dispose`````````````````````");
// 销毁TabController
    wispause = true;
    wfAliplayer.destroy();

    _tabController.dispose();
    _getServerDataTimer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> activate() async {
    super.activate();
    await getKaijiangInfo();
    debugPrint("***01*****$_isGetDate");
    if (_isGetDate == 1) {
      setState(() {
        debugPrint("**pageNo---$_tabIndex");
        setKaijiangData();
        _isGetDate = 2;
      });
    }
  }

  @override
  Future<void> deactivate() async {
    super.deactivate();
    wispause = true;
    wfAliplayer.pause();
    debugPrint("deactivate`````````````````````");
  }

  @override
  Widget build(BuildContext context) {
    var x = 0.0;
    var y = 0.0;
    widget.orientation = MediaQuery.of(context).orientation;
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    _fonth = MediaQuery.of(context).textScaleFactor;
    if (_screenWidth >= 414) {
      _fontSize = 20;
      _fontSizeLab = 14;
    } else if (_screenWidth >= 392) {
      _fontSize = 18;
      _fontSizeLab = 14;
    } else if (_screenWidth >= 375) {
      _fontSize = 16;
      _fontSizeLab = 12;
    } else if (_screenWidth >= 320) {
      _fontSize = 14;
      _fontSizeLab = 11;
    }
    _awidth = _screenWidth - 30;

    if (widget.orientation == Orientation.portrait) {
      _aheight = _awidth * 9.0 / 16.0;
    } else {
      _awidth = _screenWidth;
      _aheight = _screenHeight;
    }

    waliPlayerView = AliPlayerView(onCreated: onViewPlayerCreated, x: x, y: y, width: _awidth, height: _aheight);
    debugPrint("********---1-------------------------------");
    // wfAliplayer.setUrl(CommomUtils.MyHomePageTab_PlayList[0]);
    //  wfAliplayer.setAutoPlay(true);
    //  wfAliplayer.prepare();
    //  wfAliplayer.play();
    // wispause = false;
    if (wfAliplayer_urlIsSet == false) {
      wfAliplayer.setUrl(CommomUtils.MyHomePageTab_PlayList[0]);
      wfAliplayer_urlIsSet = true;
      wfAliplayer.setAutoPlay(true);
      wfAliplayer.prepare();
      debugPrint("********---3-------------------------------");
    }

    return DefaultTabController(
      length: CommomUtils.MyHomePageTab_mytitle.length,
      child: OrientationBuilder(builder: (BuildContext context, Orientation orientation) {
        return Scaffold(
          appBar: _buildAppBar(orientation),
          body: _buildBody(orientation),
        );
      }),
    );
  }

  _buildAppBar(Orientation orientation) {
    if (orientation == Orientation.portrait) {
      debugPrint("********---_buildAppBar-----------------------------");
      return AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(
              text: CommomUtils.MyHomePageTab_mytitle[0],
            ),
            Tab(
              text: CommomUtils.MyHomePageTab_mytitle[1],
            ),
            Tab(
              text: CommomUtils.MyHomePageTab_mytitle[2],
            ),
            Tab(
              text: CommomUtils.MyHomePageTab_mytitle[3],
            )
          ],
          onTap: (index) {
            setState(() {
              _tabIndex = index;
              switch (index) {
                case 0:
                  wfAliplayer.setUrl(CommomUtils.MyHomePageTab_PlayList[0]);
                  break;
                case 1:
                  wfAliplayer.setUrl(CommomUtils.MyHomePageTab_PlayList[1]);
                  break;
                case 2:
                  wfAliplayer.setUrl(CommomUtils.MyHomePageTab_PlayList[2]);
                  break;
                case 3:
                  wfAliplayer.setUrl(CommomUtils.MyHomePageTab_PlayList[3]);
                  break;
                case 4:
                  wfAliplayer
                      .setUrl("http://ha.jmied.com/aa/aa.flv?auth_key=1661958232-0-0-3d9174957759709f8b53448167c0b6f6");
                  break;
              }
              wfAliplayer_urlIsSet = true;
              //设置播放源，URL播放方式//
              // fAliplayer.setUrl( "http://ha.jmied.com/aa/aa.flv?auth_key=1661958232-0-0-3d9174957759709f8b53448167c0b6f6");
              //http://ha.jmied.com/aa/aa.m3u8?auth_key=1661958232-0-0-114df08fce17ecb21f6bf42de85e7600
              //fAliplayer.setUrl("artc://ha.jmied.com/aa/aa?auth_key=1661958232-0-0-d398767e30cfb93b0f1178935bff2d05");
              //fAliplayer.setUrl("https://player.alicdn.com/video/aliyunmedia.mp4");
//fAliplayer.setUrl("artc://ha.jmied.com/aa/aa?auth_key=1661958232-0-0-d398767e30cfb93b0f1178935bff2d05");
              //fAliplayer.setUrl("http://ha.jmied.com/aa/aa.m3u8?auth_key=1661958232-0-0-114df08fce17ecb21f6bf42de85e7600");

              //fAliplayer.setUrl("https://alivc-demo-vod.aliyuncs.com/6b357371ef3c45f4a06e2536fd534380/53733986bce75cfc367d7554a47638c0-fd.mp4");
              //开启自动播放
              debugPrint("********--2--------------------------------");
              wfAliplayer.setAutoPlay(true);
              wfAliplayer.prepare();
              //  debugPrint(_tabIndex);

              _tabIndex = index;
              if (_isGetDate == 2) {
                _isGetDate = 1;
              }
              if (_isGetDate == 1) {
                setState(() {
                  debugPrint("**pageNo---$_tabIndex");
                  setKaijiangData();
                  _isGetDate = 2;
                });
              }
              debugPrint(_tabIndex.toString());
            });
          },
        ),
      );
    } else {}
  }

  _buildBody(Orientation orientation) {
    if (orientation == Orientation.portrait) {
      debugPrint("********---_buildBody-----------------------------");
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 1,
            //   width:280 ,
            child: const TabBarView(
              //  physics: NeverScrollableScrollPhysics(), //禁止TabNarView滑动
              children: [
                Text(
                  "现场直播1",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 1.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "现场直播2",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 1.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "现场直播3",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 1.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "现场直播4",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 1.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                /*   ListView(
              children: [ const Text(  "letters",
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),

              ],
            ),
            ListView(
              children: [
                ListTile(
                  title: Text("第二个Tab"),
                ),
                ListTile(
                  title: Text("第二个Tab"),
                )
              ],
            ),
            ListView(
              children: [
                Text("$_tabIndex"),
                Text("123"+CommomUtils.MyHomePageTab_mytitle[_tabIndex]),
                ListTile(
                  title: Text("第3个Tab"),
                ),
                ListTile(
                  title: Text("第3个Tab"),
                )
              ],
            ),
            ListView(
              children: [
                Text("$_tabIndex"),
                Text("123"+CommomUtils.MyHomePageTab_mytitle[_tabIndex]),
                ListTile(
                  title: Text("第4个Tab"),
                ),
                ListTile(
                  title: Text("第4个Tab"),
                )
              ],
            ),
*/
              ],
            ),
          ),
          //===============================================
          //image------广告轮播
          Container(
            width: _screenWidth,
            height: 126,
            child: GestureDetector(
              onTapDown: (details) async {
                if (!await launchUrl(
                  CommomUtils.MyHomePageTab_Uri_ADHomePage[_tabIndex], // CommomUtils.MyHomePageTab_Uri_ADHomePage[_tabIndex],
                  mode: LaunchMode.externalApplication,
                )) {
                  throw Exception('Could not launch url');
                }
                debugPrint('手指按下' + _tabIndex.toString());
              },
              // Container(
              child: CarouselSlider.builder(
                onSlideChanged: (index) => {
                  //  debugPrint("---SlideChanged"+index.toString()),
                  if (wfAliplayer_urlIsSet == false)
                    {
                      setState(() {
                        wfAliplayer.setUrl(CommomUtils.MyHomePageTab_PlayList[0]);
                        wfAliplayer_urlIsSet = true;
                        wfAliplayer.setAutoPlay(true);
                        wfAliplayer.prepare();
                      }),
                      //debugPrint("---SlideChanged_init--wfAliplayer_urlIsSet"+wfAliplayer_urlIsSet.toString()),
                    },
                  if (_isGetDate == 1)
                    {
                      setState(() {
                        //  debugPrint("**pageNo---$_tabIndex");
                        setKaijiangData();
                        _isGetDate = 2;
                      }),
                    }
                },
                unlimitedMode: true,
                controller: _sliderController,
                slideBuilder: (index) {
                  return Container(
                    alignment: Alignment.center,
                    color: colors[index],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          width: _screenWidth,
                          height: 124,
                          image: ExactAssetImage(CommomUtils.MyHomePageTab_Ad_pic[index]),
                          fit: BoxFit.fill,
                        ),

                        //  Text(  letters[index],    style: TextStyle(fontSize: 20, color: Colors.white),    ),
                      ],
                    ),
                  );
                },
                slideTransform: CubeTransform(),
                slideIndicator: SequentialFillIndicator(
                  padding: EdgeInsets.only(bottom: 10),
                  itemSpacing: 30,
                  indicatorRadius: 3,
                  indicatorBorderColor: Colors.white,
                  currentIndicatorColor: Colors.white,
                ),
                itemCount: 4,
                initialPage: 0,
                enableAutoSlider: true,
              ),
            ),
          ),
          //text------现场直播  高清畅享
          Container(
            margin: const EdgeInsets.only(top: 5.0),
            width: _screenWidth * 0.85,
            height: _screenHeight * 0.04,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "现场直播",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 16.0 / _fonth,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "高清畅享",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 16.0 / _fonth,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
          ),
          //ElevatedButton------香港六合彩  官网  宝典
          Container(
            margin: const EdgeInsets.only(top: 5.0),
            width: _screenWidth * 0.8,
            height: _screenHeight * 0.05,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent, // background_ onPrimary: Colors._white_,
                ),
                onPressed: () async {
                  if (!await launchUrl(
                    CommomUtils.MyHomePageTab_Uri_myHomePage[_tabIndex],
                    mode: LaunchMode.externalApplication,
                  )) {
                    throw Exception('Could not launch url');
                  }
                },
                child: Text(CommomUtils.MyHomePageTab_mytitle[_tabIndex] + '六合彩'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent, // background_ onPrimary: Colors._white_,
                ),
                onPressed: () async {
                  if (!await launchUrl(
                    CommomUtils.MyHomePageTab_Uri_myHomePage[_tabIndex],
                    mode: LaunchMode.externalApplication,
                  )) {
                    throw Exception('Could not launch url');
                  }
                },
                child: Text('官网'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent, // background_ onPrimary: Colors._white_,
                ),
                onPressed: () async {
                  if (!await launchUrl(
                    CommomUtils.MyHomePageTab_Uri_my6hhjHomePage[_tabIndex],
                    mode: LaunchMode.externalApplication,
                  )) {
                    throw Exception('Could not launch url');
                  }
                  /*   debugPrint("scw"+_screenWidth.toString());
                        double fs=(_screenHeight*0.02/_fonth);
                        print("scw"+fs.toString());
                        double fs1=(14/_fonth);
                        print("scw"+fs1.toString()+"---"+_fontSize.toString());*/
                },
                child: Text('宝典'),
              ),
            ]),
          ),
          //aliplay------播放器
          Container(
            margin: const EdgeInsets.only(top: 5.0, left: 15, right: 14),
            width: _awidth,
            height: _aheight,
            //   child:   AspectRatio(
            //    aspectRatio: 16.0 / 9.0,  // 宽高比
            //  child: Container(//margin: const EdgeInsets.only(top: 0, left: 0),

            color: Colors.yellow,

            // Container(
            child: Stack(
                //  alignment: Alignment.center,
                //  fit: StackFit.expand,
                children: <Widget>[
                  Positioned(
                    left: 0,
                    top: 0,
                    width: _awidth,
                    height: _aheight,
                    child: GestureDetector(
                      onTapDown: (details) async {
                        print("wwwwww");
                        print(wfAliplayer.playerId.runes);
                        print("eee");
                        setState(() {
                          if (wispause) {
                            wispause = false;
                            play_Icons = icon2;
                            wfAliplayer.play();
                          } else {
                            wispause = true;
                            play_Icons = icon1;
                            wfAliplayer.pause();
                          }
                        });
                        print('手指按下' + _tabIndex.toString());
                      },
                      child: waliPlayerView,
                    ),
                  ),
                  Positioned(
                    left: 1,
                    top: 1,
                    child: IconButton(
                      icon: play_Icons,
                      color: Colors.red,
                      alignment: Alignment.bottomCenter,
                      onPressed: () {
                        print("wwwwww");
                        print(wfAliplayer.playerId.runes);
                        print("eee");
                        setState(() {
                          if (wispause) {
                            wispause = false;
                            play_Icons = icon2;
                            wfAliplayer.play();
                          } else {
                            wispause = true;
                            play_Icons = icon1;
                            wfAliplayer.pause();
                          }
                        });
                      },
                    ),
                  ),
                  Positioned(
                    left: _awidth - 45,
                    top: _aheight - 45,
                    child: IconButton(
                      icon: const Icon(
                        Icons.fullscreen,
                        size: 40,
                      ),
                      color: Colors.red,
                      alignment: Alignment.bottomRight,
                      onPressed: () {
                        print("DeviceOrientation---00--" + orientation.toString());

                        if (orientation == Orientation.portrait) {
                          print("1111-----");
                          SystemChrome.setPreferredOrientations(
                              [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
                          print("DeviceOrientation--1---" + orientation.toString());
                        } else {
                          print("2222-----");
                          SystemChrome.setPreferredOrientations(
                              [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
                          print("DeviceOrientation---2--" + orientation.toString());
                        }
                        print("DeviceOrientation-===----" + orientation.toString());
                        widget.orientation = orientation;
                        widget.refresh(orientation);
                        //
                      },
                    ),
                  ),
                  // Container(            color: Colors.red,),
                ]),
          ), //),//),

          //image------开奖结果
          Container(
            margin: const EdgeInsets.only(top: 0.0, left: 6, right: 6),
            child: GestureDetector(
              onTapDown: (details) async {
                if (!await launchUrl(
                  CommomUtils.MyHomePageTab_Uri_ADHomePage[_tabIndex], // CommomUtils.MyHomePageTab_Uri_ADHomePage[_tabIndex],
                  mode: LaunchMode.externalApplication,
                )) {
                  throw Exception('Could not launch url');
                }
                print('手指按下' + _tabIndex.toString());
              },
              // Container(
              child: Stack(
                children: <Widget>[
                  //image------开奖结果--背景
                  Image(
                    width: _screenWidth * 0.95,
                    height: _screenHeight * 0.1,
                    image: ExactAssetImage('assets/images/ballback.png'),
                    fit: BoxFit.fill,
                  ),
                  //------开奖结果--7ball
                  Container(
                    margin: EdgeInsets.only(top: 0.0, left: 5, right: 0),
                    child: Row(
                      //
                      children: [
                        //------开奖结果--qi,date
                        SizedBox(
                          width: _screenWidth * 0.24,
                          child: Column(
                            children: [
                              Text(
                                "$kj_qi",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 12.0 / _fonth,
                                  //fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "$kj_date",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: _fontSizeLab / _fonth,
                                  //fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 12.0, left: 0, right: 0),

                          // margin: EdgeInsets.only(top: 50.0),
                          child: Row(
                            children: [
                              //------开奖结果--6ball
                              Container(
                                width: _screenWidth * 0.55,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                width: _screenWidth * 0.08,
                                                height: _screenWidth * 0.08,
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 1.0, left: 3),
                                                child: Text(
                                                  kj_b1[i],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: _fontSize / _fonth,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          ),
                                          Text(
                                            kj_sx1[i],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: _fontSize / _fonth,
                                              //fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              //------开奖结果--间隔
                              Container(
                                width: _screenWidth * 0.04,
                                child: const Text(
                                  ".",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 2.0,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              //------开奖结果--1ball
                              Container(
                                //margin: const EdgeInsets.only(top: 5.0, left: 0),
                                width: _screenWidth * 0.1,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 0, left: 0),
                                      child: Stack(children: <Widget>[
                                        Image(
                                          image: ExactAssetImage(kj_col1[6]),
                                          width: _screenWidth * 0.08,
                                          height: _screenWidth * 0.08,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 2.0, left: 3),
                                          child: Text(
                                            kj_b1[6],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: _fontSize / _fonth,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    Text(
                                      kj_sx1[6],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: _fontSize / _fonth,
                                        //fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          //text------底部空行
          Container(
            //margin: const EdgeInsets.only(top: 5.0),
            child: const Text(
              "。",
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 2.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    } else {
      return
          //aliplay------播放器
          Container(
        // margin: const EdgeInsets.only(top: 5.0, left: 15, right: 14),
        width: _awidth,
        height: _aheight,
        //   child:   AspectRatio(
        //    aspectRatio: 16.0 / 9.0,  // 宽高比
        //  child: Container(//margin: const EdgeInsets.only(top: 0, left: 0),

        color: Colors.yellow,

        // Container(
        child: Stack(
            //  alignment: Alignment.center,
            //  fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                left: 0,
                top: 0,
                width: _awidth,
                height: _aheight,
                child: GestureDetector(
                  onTapDown: (details) async {
                    print("wwwwww");
                    print(wfAliplayer.playerId.runes);
                    print("eee");
                    setState(() {
                      if (wispause) {
                        wispause = false;
                        play_Icons = icon2;
                        wfAliplayer.play();
                      } else {
                        wispause = true;
                        play_Icons = icon1;
                        wfAliplayer.pause();
                      }
                    });
                    print('手指按下' + _tabIndex.toString());
                  },
                  child: waliPlayerView,
                ),
              ),
              Positioned(
                left: 1,
                top: 1,
                child: IconButton(
                  icon: play_Icons,
                  color: Colors.red,
                  alignment: Alignment.bottomCenter,
                  onPressed: () {
                    print("wwwwww");
                    print(wfAliplayer.playerId.runes);
                    print("eee");
                    setState(() {
                      if (wispause) {
                        wispause = false;
                        play_Icons = icon2;
                        wfAliplayer.play();
                      } else {
                        wispause = true;
                        play_Icons = icon1;
                        wfAliplayer.pause();
                      }
                    });
                  },
                ),
              ),
              Positioned(
                left: _awidth - 70,
                top: _aheight - 70,
                child: IconButton(
                  icon: const Icon(
                    Icons.fullscreen_exit,
                    size: 40,
                  ),
                  color: Colors.red,
                  alignment: Alignment.bottomRight,
                  onPressed: () {
                    print("DeviceOrientation---0--" + orientation.toString());

                    if (orientation == Orientation.portrait) {
                      print("1111-----");
                      SystemChrome.setPreferredOrientations(
                          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
                      print("DeviceOrientation---3--" + orientation.toString());
                    } else {
                      print("2222-----");
                      SystemChrome.setPreferredOrientations(
                          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
                      print("DeviceOrientation--4---" + orientation.toString());
                    }
                    print("DeviceOrientation-===----" + orientation.toString());
                    widget.orientation = orientation;
                    widget.refresh(orientation);
                  },
                ),
              ),
              // Container(            color: Colors.red,),
            ]),
      );
    }
  }

  void onViewPlayerCreated(viewId) async {
//将渲染View设置给播放器
    wfAliplayer.setPlayerView(viewId);
    print("----------onCreated" + viewId.toString());
  }

  Future<void> getKaijiangInfo() async {
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

      _isGetDate = 1;
    } else {
      _isGetDate = -1;
    }
  }

  void setKaijiangData() {
    switch (_tabIndex) {
      case 0:
        kj_qi = kj_hh.qi + "期";
        kj_date = kj_hh.kjdate;
        for (int i = 0; i < 7; i++) {
          kj_b1[i] = kj_hh.binfo[i].bno < 10 ? '0' + kj_hh.binfo[i].bno.toString() : kj_hh.binfo[i].bno.toString();
          kj_sx1[i] = kj_hh.binfo[i].sx;
          kj_col1[i] = 'assets/images/icon_' + kj_hh.binfo[i].col + '.png';
          print("**kj_col1[$i]---$kj_col1[i]");
        }
        break;
      case 1:
        kj_qi = kj_aa.qi + "期";
        kj_date = kj_aa.kjdate;
        for (int i = 0; i < 7; i++) {
          kj_b1[i] = kj_aa.binfo[i].bno < 10 ? '0' + kj_aa.binfo[i].bno.toString() : kj_aa.binfo[i].bno.toString();
          kj_sx1[i] = kj_aa.binfo[i].sx;
          kj_col1[i] = 'assets/images/icon_' + kj_aa.binfo[i].col + '.png';
        }
        break;
      case 2:
        kj_qi = kj_jj.qi + "期";
        kj_date = kj_jj.kjdate;
        for (int i = 0; i < 7; i++) {
          kj_b1[i] = kj_jj.binfo[i].bno < 10 ? '0' + kj_jj.binfo[i].bno.toString() : kj_jj.binfo[i].bno.toString();
          kj_sx1[i] = kj_jj.binfo[i].sx;
          kj_col1[i] = 'assets/images/icon_' + kj_jj.binfo[i].col + '.png';
        }
        break;
      case 3:
        kj_qi = kj_tt.qi + "期";
        kj_date = kj_tt.kjdate;
        for (int i = 0; i < 7; i++) {
          kj_b1[i] = kj_tt.binfo[i].bno < 10 ? '0' + kj_tt.binfo[i].bno.toString() : kj_tt.binfo[i].bno.toString();
          kj_sx1[i] = kj_tt.binfo[i].sx;
          kj_col1[i] = 'assets/images/icon_' + kj_tt.binfo[i].col + '.png';
        }
        break;
    }
  }
}

//====================================================

/*

class VideoFullPage extends StatefulWidget {
  late AliPlayerView  waliPlayerView ;
  late FlutterAliplayer wfAliplayer;

  const VideoFullPage({Key? key, required this.waliPlayerView}) : super(key: key);

  @override
  _VideoFullPageState createState() => _VideoFullPageState();
}

class _VideoFullPageState extends State<VideoFullPage> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    ///页面退出时，切换为竖屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: 16.0/9.0,
                child: widget.waliPlayerView,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25, right: 20),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.white,
                onPressed: () {
                  ///点击返回，先切换竖屏，然后退出页面
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                  ]);
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
*/
