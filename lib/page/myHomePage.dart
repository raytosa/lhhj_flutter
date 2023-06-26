import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:flutter_aliplayer/flutter_aliplayer.dart';
import 'package:flutter_aliplayer/flutter_aliplayer_factory.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cfg/sysInfo.dart';
import '../util/myEncrypt.dart';
import '../util/myHttp.dart';

class MyHomePageTab extends StatefulWidget {


  final String title;
  //const MyHomePage({super.key, required this.title});
  MyHomePageTab({required this.title}) ;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePageTab> with SingleTickerProviderStateMixin{

  late TabController _tabController;

//class _MyHomePageState extends State<MyHomePageTab> {
  late AliPlayerView  waliPlayerView ;
  late FlutterAliplayer wfAliplayer;
  bool wfAliplayer_urlIsSet =false;
  int wispause=0;

  final List<String> mytitle = ["香港","澳门","柬埔寨","台湾",];
  final List<String> myPlayList = [
    "http://ha.jmied.com/aa/aa.m3u8?auth_key=1661958232-0-0-114df08fce17ecb21f6bf42de85e7600",
    "http://aa.jmied.com/aa/aa.flv?auth_key=1661059701-0-0-18edbe2ace26cc97f5e86aaee951497e",
    "http://ja.jmied.com/jj/jj.m3u8?auth_key=1661059738-0-0-d70ea780a62e30bf4090b0aad21ce298",
    "http://ta.jmied.com/tt/tt.flv?auth_key=1661059661-0-0-6c43f152ce8b654f9d2d96ccb4a87a58",
  ];
  final List<Uri> Uri_myHomePage = [
    Uri(scheme: 'https', host: 'bet.hkjc.com', path: '/marksix/index.aspx?lang=ch'),
    Uri(scheme: 'https', host: 'macau-jc.com', path: '/pc/#/'),
    Uri(scheme: 'https', host: 'campoolslottery.com', path: '/zh/'),
    Uri(scheme: 'https', host: 'www.taiwanlottery.com.tw', path: '/lotto/lotto649/history.aspx'),
  ];
  final List<Uri> Uri_my6hhjHomePage = [
    Uri(scheme: 'https', host: 'hh.6hhj.cc', path: '/historys'),
    Uri(scheme: 'https', host: 'aa.6hhj.cc', path: '/historys'),
    Uri(scheme: 'https', host: 'jj.6hhj.cc', path: '/historys'),
    Uri(scheme: 'https', host: 'tt.6hhj.cc', path: '/historys'),
  ];
  //设置播放源，URL播放方式//
  // fAliplayer.setUrl( "http://ha.jmied.com/aa/aa.flv?auth_key=1661958232-0-0-3d9174957759709f8b53448167c0b6f6");
  //http://ha.jmied.com/aa/aa.m3u8?auth_key=1661958232-0-0-114df08fce17ecb21f6bf42de85e7600
  //fAliplayer.setUrl("artc://ha.jmied.com/aa/aa?auth_key=1661958232-0-0-d398767e30cfb93b0f1178935bff2d05");
  //fAliplayer.setUrl("https://player.alicdn.com/video/aliyunmedia.mp4");
//fAliplayer.setUrl("artc://ha.jmied.com/aa/aa?auth_key=1661958232-0-0-d398767e30cfb93b0f1178935bff2d05");
  //fAliplayer.setUrl("http://ha.jmied.com/aa/aa.m3u8?auth_key=1661958232-0-0-114df08fce17ecb21f6bf42de85e7600");

  final List<String> Ad_pic = ['assets/images/s1.jpeg','assets/images/s1.jpeg','assets/images/s2.jpeg','assets/images/s3.jpeg','assets/images/s4.jpeg',];

  int _tabIndex=0;


   KaijiangInfo kj_hh=KaijiangInfo("1","11",[BallInfo(0,"r","s"),BallInfo(0,"r","s"),BallInfo(0,"r","s"),BallInfo(0,"r","s"),BallInfo(0,"r","s"),BallInfo(0,"r","s"),BallInfo(0,"r","s"),]);
   KaijiangInfo kj_aa=KaijiangInfo("1","11",[BallInfo(0,"r","s"),BallInfo(0,"r","s"),BallInfo(0,"r","s"),BallInfo(0,"r","s"),BallInfo(0,"r","s"),BallInfo(0,"r","s"),BallInfo(0,"r","s"),]);
   KaijiangInfo kj_jj=KaijiangInfo("1","11",[BallInfo(0,"r","s"),BallInfo(0,"r","s"),BallInfo(0,"r","s"),BallInfo(0,"r","s"),BallInfo(0,"r","s"),BallInfo(0,"r","s"),BallInfo(0,"r","s"),]);
   KaijiangInfo kj_tt=KaijiangInfo("1","11",[BallInfo(0,"r","s"),BallInfo(0,"r","s"),BallInfo(0,"r","s"),BallInfo(0,"r","s"),BallInfo(0,"r","s"),BallInfo(0,"r","s"),BallInfo(0,"r","s"),]);


   String kj_qi="-----期";
   String kj_date="0000-00-00";
   List<String> kj_b1=["00","00","00","00","00","00","00",];
   List<String> kj_col1=['assets/images/icon_red.png','assets/images/icon_red.png','assets/images/icon_red.png','assets/images/icon_red.png','assets/images/icon_red.png','assets/images/icon_red.png','assets/images/icon_red.png',];
   List<String> kj_sx1=["鼠","牛","虎","兔", "龙","蛇", "马"];

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
  double _screenWidth=1.0;
  double _screenHeight=1.0;



  @override
  void initState()  {
    super.initState();
    // 初始化TabController，并指定初始索引和长度
    _tabController = TabController(initialIndex: 0, length: 4, vsync: this);
    _tabController.addListener(() {
      //点击tab回调一次，滑动切换tab不会回调
      if(_tabController.indexIsChanging){
        print("ysl--${_tabController.index}");
      }

      //点击tab时或滑动tab回调一次
      if(_tabController.index.toDouble() == _tabController.animation?.value){
        print("ysl${_tabController.index}");
      }

    });

    _sliderController = CarouselSliderController();
    wfAliplayer = FlutterAliPlayerFactory.createAliPlayer();

 getKaijiangInfo() ;
   print("***00*****$_isGetDate");
 if(_isGetDate==1){
      setState(() {
        print("**pageNo---$_tabIndex");
        setKaijiangData();
        _isGetDate=2;
      });
    }

  }

  @override
  void dispose() {
// 销毁TabController
    _tabController.dispose();
    super.dispose();
  }

  @override
  Future<void> activate() async {
    super.activate();
    await getKaijiangInfo();
    print("***01*****$_isGetDate");
    if(_isGetDate==1){
      setState(() {
        print("**pageNo---$_tabIndex");
        setKaijiangData();
        _isGetDate=2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var x = 0.0;
    var y = 0.0;
    Orientation orientation = MediaQuery.of(context).orientation;
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    var awidth=_screenWidth-30;
    var aheight;

    if (orientation == Orientation.portrait) {
      aheight = awidth * 9.0 / 16.0;
    } else {
      aheight = _screenHeight;
    }
    waliPlayerView = AliPlayerView(
        onCreated: onViewPlayerCreated,
        x: x,
        y: y,
        width: awidth,
        height: aheight);





    return DefaultTabController(
      length: mytitle.length,
      child:
      Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: [
              Tab(text: mytitle[0],),Tab(text: mytitle[1],),Tab(text: mytitle[2],),Tab(text: mytitle[3],)
            ],
            onTap:  (index){
              _tabIndex=index;
              switch(index)
              {
                case 0:wfAliplayer.setUrl(myPlayList[0]);break;
                case 1:wfAliplayer.setUrl(myPlayList[1]);break;
                case 2:wfAliplayer.setUrl(myPlayList[2]);break;
                case 3:wfAliplayer.setUrl(myPlayList[3]);break;
                case 4:wfAliplayer.setUrl("http://ha.jmied.com/aa/aa.flv?auth_key=1661958232-0-0-3d9174957759709f8b53448167c0b6f6");break;
              }
              wfAliplayer_urlIsSet=true;
              //设置播放源，URL播放方式//
              // fAliplayer.setUrl( "http://ha.jmied.com/aa/aa.flv?auth_key=1661958232-0-0-3d9174957759709f8b53448167c0b6f6");
              //http://ha.jmied.com/aa/aa.m3u8?auth_key=1661958232-0-0-114df08fce17ecb21f6bf42de85e7600
              //fAliplayer.setUrl("artc://ha.jmied.com/aa/aa?auth_key=1661958232-0-0-d398767e30cfb93b0f1178935bff2d05");
              //fAliplayer.setUrl("https://player.alicdn.com/video/aliyunmedia.mp4");
//fAliplayer.setUrl("artc://ha.jmied.com/aa/aa?auth_key=1661958232-0-0-d398767e30cfb93b0f1178935bff2d05");
              //fAliplayer.setUrl("http://ha.jmied.com/aa/aa.m3u8?auth_key=1661958232-0-0-114df08fce17ecb21f6bf42de85e7600");

              //fAliplayer.setUrl("https://alivc-demo-vod.aliyuncs.com/6b357371ef3c45f4a06e2536fd534380/53733986bce75cfc367d7554a47638c0-fd.mp4");
              //开启自动播放
              wfAliplayer.setAutoPlay(true);
              wfAliplayer.prepare();
            //  print(_tabIndex);
              setState((){
              _tabIndex=index;
              if(_isGetDate==2){_isGetDate=1;}
              if(_isGetDate==1){
                setState(() {
                  print("**pageNo---$_tabIndex");
                  setKaijiangData();
                  _isGetDate=2;
                });

              }
              print(_tabIndex);
              });
            },
          ),
        ),
        body:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Container(
              height: 1,
              //   width:280 ,
              child:  const TabBarView(

              //  physics: NeverScrollableScrollPhysics(), //禁止TabNarView滑动
                children: [
                  Text("现场直播1", style: TextStyle(  color: Colors.redAccent,   fontSize: 1.0,   fontWeight: FontWeight.bold,  ),),
                  Text("现场直播2", style: TextStyle(  color: Colors.redAccent,   fontSize: 1.0,   fontWeight: FontWeight.bold,  ),),
                  Text("现场直播3", style: TextStyle(  color: Colors.redAccent,   fontSize: 1.0,   fontWeight: FontWeight.bold,  ),),
                  Text("现场直播4", style: TextStyle(  color: Colors.redAccent,   fontSize: 1.0,   fontWeight: FontWeight.bold,  ),),
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
                Text("123"+mytitle[_tabIndex]),
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
                Text("123"+mytitle[_tabIndex]),
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
              child: CarouselSlider.builder(
                onSlideChanged: (index) =>{

                //  print("---SlideChanged"+index.toString()),
                  if(wfAliplayer_urlIsSet==false){
                    wfAliplayer.setUrl(myPlayList[0]),
                    wfAliplayer_urlIsSet=true,
                    wfAliplayer.setAutoPlay(true),
                    wfAliplayer.prepare(),
                    //print("---SlideChanged_init--wfAliplayer_urlIsSet"+wfAliplayer_urlIsSet.toString()),
                  },
                  if(_isGetDate==1){
                    setState(() {
                      //  print("**pageNo---$_tabIndex");
                      setKaijiangData();
                      _isGetDate=2;
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
                            image:ExactAssetImage( Ad_pic[index])),

                        //  Text(  letters[index],    style: TextStyle(fontSize: 20, color: Colors.white),    ),
                      ],
                    ),
                  );
                },
                slideTransform: CubeTransform(),
                slideIndicator: SequentialFillIndicator(
                  padding: EdgeInsets.only(bottom: 10),
                  itemSpacing:30,
                  indicatorRadius:3,
                  indicatorBorderColor: Colors.white,
                  currentIndicatorColor: Colors.white,
                ),
                itemCount: 4,
                initialPage: 0,
                enableAutoSlider: true,
              ),
            ),
            //text------现场直播  高清畅享
            Container(margin: const EdgeInsets.only(top: 5.0),
              width: _screenWidth*0.85,
              child:   Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("现场直播", style: TextStyle(  color: Colors.redAccent,   fontSize: 16.0,   fontWeight: FontWeight.bold,  ),),
                    Text("高清畅享", style: TextStyle(  color: Colors.redAccent,   fontSize: 16.0,   fontWeight: FontWeight.bold,  ),),
                  ]),
            ),
            //ElevatedButton------香港六合彩  官网  宝典
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              width: _screenWidth*0.8,
              child:   Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent, // background_ onPrimary: Colors._white_,
                      ),
                      onPressed: () async {
                        if (!await launchUrl(
                          Uri_myHomePage[_tabIndex],
                          mode: LaunchMode.externalApplication,
                        )) {
                          throw Exception('Could not launch url');
                        }
                      },
                      child: Text(mytitle[_tabIndex]+'六合彩'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent, // background_ onPrimary: Colors._white_,
                      ),
                      onPressed: () async {
                        if (!await launchUrl(
                        Uri_myHomePage[_tabIndex],
                        mode: LaunchMode.externalApplication,
                        )) {
                        throw Exception('Could not launch url');
                        }
                      } ,
                      child: Text('官网'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent, // background_ onPrimary: Colors._white_,
                      ),
                      onPressed: () async {
                        if (!await launchUrl(
                        Uri_my6hhjHomePage[_tabIndex],
                        mode: LaunchMode.externalApplication,
                        )) {
                        throw Exception('Could not launch url');
                        }
                      },
                      child: Text('宝典'),
                    ),
                  ]),
            ),
            //aliplay------播放器
            Container(margin: const EdgeInsets.only(top: 5.0, left: 15, right: 15),
              child:   AspectRatio(
                aspectRatio: 16.0 / 9.0,  // 宽高比
                child: Container(
                  color: Colors.yellow,
                  child:Stack(
                      children: <Widget>[
                        waliPlayerView,
                        IconButton(
                          icon: Icon(Icons.play_circle_filled),
                          color: Colors.red,
                          alignment: Alignment.bottomCenter,
                          onPressed: () =>{print("wwwwww"),
                            print(wfAliplayer.playerId.runes),print("eee"),
                            if(wispause!=0)
                              {wispause=0,
                                wfAliplayer.pause(),print("111"),}
                            else{wispause=1,
                              wfAliplayer.play(),
                              print("222"),
                            }
                          },
                        ),
                        // Container(            color: Colors.red,),
                      ]
                  ),
                ),),),
            //image------开奖结果
            Container(margin: const EdgeInsets.only(top: 5.0, left: 6, right: 6),
              child:Stack(
                children: <Widget>[
                  //image------开奖结果--背景
                  const Image(
                    image: ExactAssetImage('assets/images/ballback.png'),
                    fit: BoxFit.cover,
                  ),
                  //------开奖结果--7ball
                  Container( margin: EdgeInsets.only(top: 5.0, left: 5,right: 0),
                    child:   Row(
                      //
                      children: [
                        //------开奖结果--qi,date
                        SizedBox(
                          width: _screenWidth*0.24,
                          child:  Column(

                            children: [
                              Text("$kj_qi",
                                style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 12.0,
                                  //fontWeight: FontWeight.bold,
                                ),),

                              Text("$kj_date",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                  //fontWeight: FontWeight.bold,
                                ),),
                            ],
                          ),),
                        Container( margin: const EdgeInsets.only(top: 12.0, left: 0,right: 0),

                          // margin: EdgeInsets.only(top: 50.0),
                          child: Row(
                            children: [
                              //------开奖结果--6ball
                              Container(   width: _screenWidth*0.55,
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    for(var i=0;i<6;i++)
                                      Column(
                                        children: [

                                          Container(
                                            margin: EdgeInsets.only(top: 0, left:1),
                                            // margin: EdgeInsets.only(top: 50.0),
                                            child: Stack(
                                                children: <Widget>[
                                                  Image(image: ExactAssetImage(kj_col1[i]),
                                                    width: 26,
                                                    height: 26,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(top: 1.0, left:3),
                                                    child:  Text(kj_b1[i],
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16.0,
                                                        fontWeight: FontWeight.bold,
                                                      ),),
                                                  ),
                                                ]),
                                          ),

                                          Text(kj_sx1[i],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              //fontWeight: FontWeight.bold,
                                            ),),
                                        ],
                                      ), ],),
                              ),
                              //------开奖结果--间隔
                              Container(width: _screenWidth*0.04,
                                child: const Text(".",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 2.0,
                                    //fontWeight: FontWeight.bold,
                                  ),),
                              ),
                              //------开奖结果--1ball
                              Container( //margin: const EdgeInsets.only(top: 5.0, left: 0),
                                width: _screenWidth*0.1,
                                child: Column(

                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 0, left: 0),
                                      child: Stack(
                                          children: <Widget>[
                                            Image(image: ExactAssetImage(kj_col1[6]),
                                              width: 26,
                                              height: 26,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 1.0, left: 3),
                                              child:  Text(kj_b1[6],
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),),
                                            ),
                                          ]),
                                    ),

                                    Text(kj_sx1[6],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        //fontWeight: FontWeight.bold,
                                      ),),
                                  ],
                                ),
                              ),
                            ],),),

                      ],
                    ),
                  ),

                ],
              ),
            ),
            //text------底部空行
            Container(//margin: const EdgeInsets.only(top: 5.0),
              child: Text("。", style: TextStyle(  color: Colors.redAccent,   fontSize: 2.0,   fontWeight: FontWeight.bold,  ),),
            ),
          ],
        ),

      ),


    );

  }

  void onViewPlayerCreated(viewId) async {

//将渲染View设置给播放器
    wfAliplayer.setPlayerView(viewId);

  }


  Future<void> getKaijiangInfo() async {
      String de=await getService();
      if(de.length>10) {
        String relStr = EncryptUtils.decryptAes16(de);
        print("--==" + relStr);
        if (relStr.length > 10) {
          Map jrs = json.decode(relStr);
          int i=0;
          jrs["hh"].forEach((member) {
            BallInfo bif=new BallInfo(int.parse(member["c"]),member["r"],member["s"],);
            kj_hh.binfo[i]=bif;
            kj_hh.qi=member["draw"];          kj_hh.kjdate = member["date"];
            i++;
          } );
          i=0;
          jrs["aa"].forEach((member) {
            BallInfo bif=new BallInfo(int.parse(member["c"]),member["r"],member["s"],);
            kj_aa.binfo[i]=bif;
            kj_aa.qi=member["draw"];          kj_aa.kjdate = member["date"];
            i++;
          } );
          i=0;
          jrs["jj"].forEach((member) {
            BallInfo bif=new BallInfo(int.parse(member["c"]),member["r"],member["s"],);
            kj_jj.binfo[i]=bif;
            kj_jj.qi=member["draw"];          kj_jj.kjdate = member["date"];
            i++;
          } );
          i=0;
          jrs["tt"].forEach((member) {
            BallInfo bif=new BallInfo(int.parse(member["c"]),member["r"],member["s"],);
            kj_tt.binfo[i]=bif;
            kj_tt.qi=member["draw"];          kj_tt.kjdate = member["date"];
            i++;
          } );
        }

        _isGetDate= 1; }
      else{
        _isGetDate= -1;
      }
    }
  void setKaijiangData()  {

    switch (_tabIndex) {
      case 0:
        kj_qi = kj_hh.qi + "期";
        kj_date = kj_hh.kjdate;
        for (int i = 0; i < 7; i++) {
          kj_b1[i] = kj_hh.binfo[i].bno < 10 ? '0' +
              kj_hh.binfo[i].bno.toString() : kj_hh
              .binfo[i].bno.toString();
          kj_sx1[i] = kj_hh.binfo[i].sx;
          kj_col1[i] = 'assets/images/icon_' +
              kj_hh.binfo[i].col + '.png';
          print("**kj_col1[$i]---$kj_col1[i]");
        }
        break;
      case 1:
        kj_qi = kj_aa.qi + "期";
        kj_date = kj_aa.kjdate;
        for (int i = 0; i < 7; i++) {
          kj_b1[i] = kj_aa.binfo[i].bno < 10 ? '0' +
              kj_aa.binfo[i].bno.toString() : kj_aa
              .binfo[i].bno.toString();
          kj_sx1[i] = kj_aa.binfo[i].sx;
          kj_col1[i] = 'assets/images/icon_' +
              kj_aa.binfo[i].col + '.png';
        }
        break;
      case 2:
        kj_qi = kj_jj.qi + "期";
        kj_date = kj_jj.kjdate;
        for (int i = 0; i < 7; i++) {
          kj_b1[i] = kj_jj.binfo[i].bno < 10 ? '0' +
              kj_jj.binfo[i].bno.toString() : kj_jj
              .binfo[i].bno.toString();
          kj_sx1[i] = kj_jj.binfo[i].sx;
          kj_col1[i] = 'assets/images/icon_' +
              kj_jj.binfo[i].col + '.png';
        }
        break;
      case 3:
        kj_qi = kj_tt.qi + "期";
        kj_date = kj_tt.kjdate;
        for (int i = 0; i < 7; i++) {
          kj_b1[i] = kj_tt.binfo[i].bno < 10 ? '0' +
              kj_tt.binfo[i].bno.toString() : kj_tt
              .binfo[i].bno.toString();
          kj_sx1[i] = kj_tt.binfo[i].sx;
          kj_col1[i] = 'assets/images/icon_' +
              kj_tt.binfo[i].col + '.png';
        }
        break;
    }

  }
}
