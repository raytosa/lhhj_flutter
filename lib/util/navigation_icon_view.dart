import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' ;


import 'package:lhhj/page/webPage.dart';
import 'package:lhhj/page/setPage.dart';
import 'package:lhhj/page/my_page.dart';
import 'package:lhhj/page/myHomePage.dart';
import '../page/myDownloadPage.dart';
import '../page/myWebPage.dart';

import '../util/myHttp.dart';
import '../util/myEncrypt.dart';
import '../cfg/sysInfo.dart';

import 'package:flutter_aliplayer/flutter_aliplayer.dart';
import 'package:flutter_aliplayer/flutter_aliplayer_factory.dart';




class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  List<String> page_label=["开奖直播","网址大全","客户端","消息","登录｜注册",];
  late FlutterAliplayer fAliplayer;

  final _defaultColor = Colors.grey;
  final _activeColor = Colors.redAccent;
  int _currentIndex = 0;
  int _ispause = 0;
  final PageController _controller = PageController(
    initialPage: 0,
  );

  void _pageChange(int index) {
    setState(() {
      _currentIndex = index;
      onViewPlayerChg(_currentIndex);
    });
  }
  @override
  void initState()  {
    var _mode = AESMode.cbc;
    var _padding = 'PKCS7';
    EncryptUtils eu1= new EncryptUtils();
    EncryptUtils.initAes("12345678900000001234567890000000",
        mode: _mode, padding: _padding);

    super.initState();
    //doGetServiceAsyncStuff();

//创建播放器
    fAliplayer = FlutterAliPlayerFactory.createAliPlayer();
  }
  Future<void> doGetServiceAsyncStuff() async {
    String de=await getService();
    String relStr=EncryptUtils.decryptAes16(de);
    print("--=="+relStr);
    final jsonResult = json.decode(relStr);
    print("***"+jsonResult.toString());
  //  SysInfo sysinfo1=   SysInfo.fromJson(jsonResult);
   // print("***"+sysinfo1.SubwebPage.toString());
  //  sysinfo1.data?.forEach((element) {
  //    print(element);
  //  });


  }


  @override
  Widget build(BuildContext context) {
    var x = 0.0;
    var y = 0.0;
    Orientation orientation = MediaQuery.of(context).orientation;
    var width = MediaQuery.of(context).size.width;
    var height;

    if (orientation == Orientation.portrait) {
      height = width * 9.0 / 16.0;
    } else {
      height = MediaQuery.of(context).size.height;
    }
    AliPlayerView  aliPlayerView = AliPlayerView(
        onCreated: onViewPlayerCreated,
//    onPressed: () =>{print("wwwwww"),}
        x: x,
        y: y,
        width: width,
        height: height);

    return Scaffold(
    
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: _pageChange,
        controller: _controller,
        children: [
          MyHomePageTab(title: page_label[0],),// myPage(title: "001",key:null,wfAliplayer:fAliplayer,waliPlayerView:aliPlayerView,wispause:_ispause),
          myWebPage(page_title: page_label[1],web_url: "https://49lh11.com/",),//消息
          myDownloadPage(title: page_label[2],),//客户端下载
          myWebPage(page_title: page_label[3],web_url: "https://www.163.com",),//消息
          myWebPage(page_title: page_label[4],web_url: "https://m.6hhj.net/",),//消息
        //  myPage(pageNo: 4,title: page_label[4],key:null,wfAliplayer:fAliplayer,waliPlayerView:aliPlayerView,wispause:_ispause),

          //  webPage(),
        //  SettingPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(

          type: BottomNavigationBarType.fixed,
          iconSize : 24.0,
          fixedColor: Colors.redAccent,
          selectedLabelStyle :TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
          unselectedLabelStyle :  TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
          backgroundColor:Colors.grey[300],// _currentIndex == 1 ? _activeColor : _defaultColor,
          selectedFontSize : 14.0,//设置选中时文字大小
          unselectedFontSize :12.0,//设置没选中时的文字大小
          showUnselectedLabels:true,// _currentIndex == 2 ? _activeColor : _defaultColor,


          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
            print(_currentIndex);
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: _defaultColor,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: _activeColor,
                ),
                label: page_label[0],
              backgroundColor:Colors.grey[400],// _currentIndex == 1 ? _activeColor : _defaultColor,
                ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.supervisor_account,
                  color: _defaultColor,
                ),
                activeIcon: Icon(
                  Icons.camera,
                  color: _activeColor,
                ),
                label:  page_label[1],
                backgroundColor: Colors.grey[400],//_currentIndex == 3 ? _activeColor : _defaultColor,

                  ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.desktop_mac,
                  color: _defaultColor,
                ),
                activeIcon: Icon(
                  Icons.desktop_mac,
                  color: _activeColor,
                ),
                label:   page_label[2],
    backgroundColor:Colors.grey[400],// _currentIndex == 4 ? _activeColor : _defaultColor,
                  ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.message,
                  color: _defaultColor,
                ),
                activeIcon: Icon(
                  Icons.account_circle,
                  color: _activeColor,
                ),
                label:    page_label[3],
    backgroundColor:Colors.grey[400],// _currentIndex == 2 ? _activeColor : _defaultColor,
                  ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                color: _defaultColor,
              ),
              activeIcon: Icon(
                Icons.account_circle,
                color: _activeColor,
              ),
              label:      page_label[4],
              backgroundColor:Colors.grey[400],// _currentIndex == 2 ? _activeColor : _defaultColor,
            ),
          ]),
    );
  }

void onViewPlayerCreated(viewId) async {

//将渲染View设置给播放器
  fAliplayer.setPlayerView(viewId);

}


  void onViewPlayerChg(int id) async {
switch(id)
{
  case 0:fAliplayer.setUrl("artc://ha.jmied.com/aa/aa?auth_key=1661958232-0-0-d398767e30cfb93b0f1178935bff2d05");break;
  case 1:case 2:case 3:case 4:fAliplayer.setUrl("http://ha.jmied.com/aa/aa.flv?auth_key=1661958232-0-0-3d9174957759709f8b53448167c0b6f6");break;
}
//设置播放源，URL播放方式//
   // fAliplayer.setUrl( "http://ha.jmied.com/aa/aa.flv?auth_key=1661958232-0-0-3d9174957759709f8b53448167c0b6f6");
    //http://ha.jmied.com/aa/aa.m3u8?auth_key=1661958232-0-0-114df08fce17ecb21f6bf42de85e7600
    //fAliplayer.setUrl("artc://ha.jmied.com/aa/aa?auth_key=1661958232-0-0-d398767e30cfb93b0f1178935bff2d05");
    //fAliplayer.setUrl("https://player.alicdn.com/video/aliyunmedia.mp4");
//fAliplayer.setUrl("artc://ha.jmied.com/aa/aa?auth_key=1661958232-0-0-d398767e30cfb93b0f1178935bff2d05");
    //fAliplayer.setUrl("http://ha.jmied.com/aa/aa.m3u8?auth_key=1661958232-0-0-114df08fce17ecb21f6bf42de85e7600");

    //fAliplayer.setUrl("https://alivc-demo-vod.aliyuncs.com/6b357371ef3c45f4a06e2536fd534380/53733986bce75cfc367d7554a47638c0-fd.mp4");
    //开启自动播放
    fAliplayer.setAutoPlay(true);
    fAliplayer.prepare();
  }
}
