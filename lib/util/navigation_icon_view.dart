import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:lhhj/page/myHomePage.dart';

import '../page/myDownloadPage.dart';
import '../page/myWebPage.dart';
import '../util/myEncrypt.dart';
import 'common_utils.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  Orientation orientationF = Orientation.portrait;

  int _onetime = 0;

  final _defaultColor = Colors.grey;
  final _activeColor = Colors.redAccent;
  int _currentIndex = 2;
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
  void initState() {
    var _mode = AESMode.cbc;
    var _padding = 'PKCS7';
    EncryptUtils eu1 = new EncryptUtils();
    EncryptUtils.initAes("12345678900000001234567890000000", mode: _mode, padding: _padding);

    super.initState();
    doGetServiceAsyncStuff();

//创建播放器
  }

  Future<void> doGetServiceAsyncStuff() async {
    /*  String de=await getService();
    String relStr=EncryptUtils.decryptAes16(de);
    debugPrint("--=="+relStr);
    final jsonResult = json.decode(relStr);
    debugPrint("***"+jsonResult.toString());
  //  SysInfo sysinfo1=   SysInfo.fromJson(jsonResult);
   // debugPrint("***"+sysinfo1.SubwebPage.toString());
  //  sysinfo1.data?.forEach((element) {
  //    debugPrint(element);
  //  });
*/
    Future.delayed(Duration(milliseconds: 300), () {
      debugPrint("延时300ms执行");
      // _controller.jumpToPage(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    /*  var x = 0.0;
    var y = 0.0;
    Orientation orientation = MediaQuery.of(context).orientation;
    var width = MediaQuery.of(context).size.width;
    var height;

    if (orientation == Orientation.portrait) {
      height = width * 9.0 / 16.0;
    } else {
      height = MediaQuery.of(context).size.height;
    }

*/
    debugPrint("**-----------------------************" + orientationF.toString());
    return Scaffold(
      body: _buildBody(orientationF),
      bottomNavigationBar: _buildBottomNavigationBar(orientationF),
    );
  }

  _buildBody(Orientation orientation) {
    if (true) //(orientation != Orientation.portrait)
    {
      debugPrint('0子组件的值是: ' + orientation.toString());
      doGetServiceAsyncStuff();
      return PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: _pageChange,
        controller: _controller,
        children: [
          MyHomePageTab(
              title: CommomUtils.tabNavigator_page_label[0],
              refresh: (Orientation orientation1) {
                orientationF = orientation1;
                debugPrint('00子组件的值是: ' + orientationF.toString());

                setState(() {});
              }), //
          myWebPage(
            page_title: CommomUtils.tabNavigator_page_label[1],
            web_url: CommomUtils.tabNavigator_page_url[0],
          ), //消息
          myDownloadPage(
            title: CommomUtils.tabNavigator_page_label[2],
          ), //客户端下载
          myWebPage(
            page_title: CommomUtils.tabNavigator_page_label[3],
            web_url: CommomUtils.tabNavigator_page_url[1],
          ), //消息
          myWebPage(
            page_title: CommomUtils.tabNavigator_page_label[4],
            web_url: CommomUtils.tabNavigator_page_url[2],
          ), //消息
          //

          //  webPage(),
          //  SettingPage(),
        ],
      );
    } else {
      debugPrint('01子组件的值是: ' + orientation.toString());
      return Center(
        child: MyHomePageTab(
            title: CommomUtils.tabNavigator_page_label[0],
            refresh: (Orientation orientation1) {
              orientationF = orientation1;
              debugPrint('011子组件的值是: ' + orientationF.toString());
              setState(() {});
            }), //
      );
    }
  }

  _buildBottomNavigationBar(Orientation orientation) {
    if (orientation == Orientation.portrait) {
      debugPrint("**-000----------------------************" + orientation.toString());
      return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: 24.0,
          fixedColor: Colors.redAccent,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          backgroundColor: Colors.grey[300],
          // _currentIndex == 1 ? _activeColor : _defaultColor,
          selectedFontSize: 14.0,
          //设置选中时文字大小
          unselectedFontSize: 12.0,
          //设置没选中时的文字大小
          showUnselectedLabels: true,
          // _currentIndex == 2 ? _activeColor : _defaultColor,

          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
            debugPrint(_currentIndex.toString());
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
              label: CommomUtils.tabNavigator_page_label[0],
              backgroundColor: Colors.grey[400], // _currentIndex == 1 ? _activeColor : _defaultColor,
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
              label: CommomUtils.tabNavigator_page_label[1],
              backgroundColor: Colors.grey[400], //_currentIndex == 3 ? _activeColor : _defaultColor,
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
              label: CommomUtils.tabNavigator_page_label[2],
              backgroundColor: Colors.grey[400], // _currentIndex == 4 ? _activeColor : _defaultColor,
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
              label: CommomUtils.tabNavigator_page_label[3],
              backgroundColor: Colors.grey[400], // _currentIndex == 2 ? _activeColor : _defaultColor,
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
              label: CommomUtils.tabNavigator_page_label[4],
              backgroundColor: Colors.grey[400], // _currentIndex == 2 ? _activeColor : _defaultColor,
            ),
          ]);
    } else {
      debugPrint("**-001----------------------************" + orientation.toString());
    }
  }

  void onViewPlayerCreated(viewId) async {
//将渲染View设置给播放器
  }

  void onViewPlayerChg(int id) async {
    switch (id) {
      case 0:
        break;
      case 1:
      case 2:
      case 3:
      case 4:
        break;
    }
    if (_onetime == 0) {
      _onetime = 1;
      setState(() {
        _currentIndex = 0;
      });
    }
    debugPrint("****************************************");
  }
}
