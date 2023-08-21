import 'package:flutter/material.dart';

class CommomUtils {
  //-----全局变量----------------------------



  //-----tabNavigator-------------------------------
  static List<String> tabNavigator_page_label = [
    "开奖直播",
    "网址大全",
    "客户端",
    "消息",
    "个人中心",
  ];
  static List<String> tabNavigator_page_url = [
    "https://49lh11.com/",
    "https://www.163.com",
    "https://m.6hhj.net/",
    "https://m.6hhj.net/",
  ];
//-----MyHomePageTab--------------------------------
  static List<String> MyHomePageTab_mytitle = [
    "香港",
    "澳门",
    "柬埔寨",
    "台湾",
  ];
  static List<String> MyHomePageTab_myText = [
    "香港",
    "澳门",
    "柬埔寨",
    "台湾",
  ];
  static List<String> MyHomePageTab_PlayList = [
    "http://ha.jmied.com/aa/aa.m3u8?auth_key=1661958232-0-0-114df08fce17ecb21f6bf42de85e7600",
    "http://aa.jmied.com/aa/aa.flv?auth_key=1661059701-0-0-18edbe2ace26cc97f5e86aaee951497e",
    "http://ja.jmied.com/jj/jj.m3u8?auth_key=1661059738-0-0-d70ea780a62e30bf4090b0aad21ce298",
    "http://ta.jmied.com/tt/tt.flv?auth_key=1661059661-0-0-6c43f152ce8b654f9d2d96ccb4a87a58",
  ];
  static List<Uri> MyHomePageTab_Uri_ADHomePage = [
    Uri(scheme: 'https', host: 'hh.6hhj.cc', path: '/historys'),
    Uri(scheme: 'https', host: 'aa.6hhj.cc', path: '/historys'),
    Uri(scheme: 'https', host: 'jj.6hhj.cc', path: '/historys'),
    Uri(scheme: 'https', host: 'tt.6hhj.cc', path: '/historys'),
  ];

  static List<Uri> MyHomePageTab_Uri_myHomePage = [
    Uri(scheme: 'https', host: 'bet.hkjc.com', path: '/marksix/index.aspx?lang=ch'),
    Uri(scheme: 'https', host: 'macau-jc.com', path: '/pc/#/'),
    Uri(scheme: 'https', host: 'campoolslottery.com', path: '/zh/'),
    Uri(scheme: 'https', host: 'www.taiwanlottery.com.tw', path: '/lotto/lotto649/history.aspx'),
  ];
  static List<Uri> MyHomePageTab_Uri_my6hhjHomePage = [
    Uri(scheme: 'https', host: 'hh.6hhj.cc', path: '/historys'),
    Uri(scheme: 'https', host: 'aa.6hhj.cc', path: '/historys'),
    Uri(scheme: 'https', host: 'jj.6hhj.cc', path: '/historys'),
    Uri(scheme: 'https', host: 'tt.6hhj.cc', path: '/historys'),
  ];

  static List<String> MyHomePageTab_Ad_pic = [
    'assets/images/s1.jpeg',
    'assets/images/s1.jpeg',
    'assets/images/s2.jpeg',
    'assets/images/s3.jpeg',
    'assets/images/s4.jpeg',
  ];

//-----myDownloadPage--------------------------------
  static List<String> xz_lab = [
    '安卓客户端下载',
    'iOS客户端下载',
  ];
  static List<String> xz_item = [
    '点击切换iOS客户端下载',
    '点击切换安卓客户端下载',
  ];
  static List<String> xz_link = [
    '点击切换iOS客户端下载',
    '点击切换安卓客户端下载',
  ];

  //-----切换页面----------------------------
  static pushPage(BuildContext context, Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
