import 'package:flutter/material.dart';
import 'package:lhhj/page/myHomePage.dart';
import 'package:lhhj/page/my_page.dart';
import 'package:lhhj/page/myWebPage.dart';
import 'package:lhhj/page/setting_page.dart';

import 'package:lhhj/util/navigation_icon_view.dart'; // 如果是在同一个包的路径下，可以直接使用对应的文件名

// 创建一个 带有状态的 Widget Index
class Index extends StatefulWidget {

  //  固定的写法
  @override
  State<StatefulWidget> createState()  => new _IndexState();
}

// 要让主页面 Index 支持动效，要在它的定义中附加mixin类型的对象TickerProviderStateMixin
class _IndexState extends State<Index> with TickerProviderStateMixin{

  int _currentIndex = 0;    // 当前界面的索引值
  late List<NavigationIconView> _navigationViews;  // 底部图标按钮区域
  late List<StatefulWidget> _pageList;   // 用来存放我们的图标对应的页面
  late StatefulWidget _currentPage;  // 当前的显示页面

  // 定义一个空的设置状态值的方法
  void _rebuild() {
    setState((){});
  }

  @override
  void initState() {
    super.initState();

    // 初始化导航图标
    _navigationViews = <NavigationIconView>[
      new NavigationIconView(icon: new Icon(Icons.assessment), lable: "首页", vsync: this), // vsync 默认属性和参数
      new NavigationIconView(icon: new Icon(Icons.all_inclusive), lable: "想法", vsync: this),
      new NavigationIconView(icon: new Icon(Icons.add_shopping_cart), lable:"市场", vsync: this),
      new NavigationIconView(icon: new Icon(Icons.add_alert), lable: "通知", vsync: this),
      new NavigationIconView(icon: new Icon(Icons.perm_identity), lable: "我的", vsync: this),
    ];

    // 给每一个按钮区域加上监听
    for (NavigationIconView view in _navigationViews) {
      view.controller.addListener(_rebuild);
    }

    // 将我们 bottomBar 上面的按钮图标对应的页面存放起来，方便我们在点击的时候
    _pageList = <StatefulWidget>[
     // new myHomePage(),
     // new myPage(title: "110",key:null),
    //  new myWebPage(),
      new SettingPage()
    ];
    _currentPage = _pageList[_currentIndex];
  }

  @override
  Widget build(BuildContext context) {

    // 声明定义一个 底部导航的工具栏
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      items: _navigationViews
          .map((NavigationIconView navigationIconView) => navigationIconView.item)
          .toList(),  // 添加 icon 按钮
      currentIndex: _currentIndex,  // 当前点击的索引值
      type: BottomNavigationBarType.fixed,    // 设置底部导航工具栏的类型：fixed 固定
      onTap: (int index){   // 添加点击事件
        setState((){    // 点击之后，需要触发的逻辑事件
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
          _currentPage = _pageList[_currentIndex];
        });
      },
    );

    return new MaterialApp(
      home: new Scaffold(
        body: new Center(
            child: _currentPage   // 动态的展示我们当前的页面
        ),
        bottomNavigationBar: bottomNavigationBar,   // 底部工具栏
      ),

      theme: new ThemeData(
        primarySwatch: Colors.blue,   // 设置主题颜色
      ),

    );
  }

}

// 创建一个 Icon 展示控件
class NavigationIconView {

  // 创建两个属性，一个是 用来展示 icon， 一个是动画处理
  final BottomNavigationBarItem item;
  final AnimationController controller;

  // 类似于 java 中的构造方法
  // 创建 NavigationIconView 需要传入三个参数， icon 图标，title 标题， TickerProvider
  NavigationIconView({required Icon icon, required String lable, required TickerProvider vsync}):
        item = new BottomNavigationBarItem(
          icon: icon,
          label: lable,
        ),
        controller = new AnimationController(
            duration: kThemeAnimationDuration,    // 设置动画持续的时间
            vsync: vsync                          // 默认属性和参数
        );
}