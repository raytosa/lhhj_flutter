import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lhhj/util/navigation_icon_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/common_utils.dart';
import '../../util/myHttp.dart';
import '../../util/myHttpDio.dart';
import '../../util/secure_storage.dart';
import 'myForgotPasswordPage.dart';
import 'myRegisterPage.dart';

class myLoginPage extends StatefulWidget {
  int loginmode = 0;
  late String title;

  late int wispause = 0;

  myLoginPage({required super.key, required this.loginmode, required this.title});

  @override
  _myLoginPageState createState() => _myLoginPageState(loginmode: 0, title: "11");
}

class _myLoginPageState extends State<myLoginPage> {
  String _authorized = '验证失败';
  final globalKeyValue = GlobalKey<FormState>();

  final _storage = const FlutterSecureStorage();
  final _loginNameController = TextEditingController(text: '_loginNameController');
  final _loginPwdController = TextEditingController(text: '_loginPwdController');
  List<_SecItem> _items = [];
  late String loginName = "Rayto_sa@163.com";
  late String loginPwd = "sss";
  late String loginEmail = "Rayto_sa@163.com";

  late int loginmode = 0;
  late String title;

  late String kj_date = "0001-01-01";
  late Map jsonResult;
  late List<String> kj_b1 = [
    "00", "00", "00", "00", "00", "00", "00", //
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
    "鼠", "牛", "虎", "兔", "龙", "蛇", "马", "羊", "猴", "鸡", "狗", "猪", //
  ];
  var list = ['string'];
  var l2 = <String>['111', '222'];
  int pageNo = 0;
  List<String> ball_sx_url1 = [
    '0', '1', '2', '3', '4', '5', '6', '7', '8', //
  ];
  List<String> ball_sx1 = [
    '0', '1', '2', '3', '4', '5', '6', '7', '8', //
  ];

  //final LocalAuthentication auth = LocalAuthentication();

  /// 识别结果

  String validateUsername(value) {
    debugPrint('username--100:$value');
    if (value.isEmpty) {
      return '请输入用户名';
    } else {
      return "用户名";
    }
  }

  String validatePassword(value) {
    if (value.isEmpty) {
      return '请输入密码';
    } else {
      return "密码";
    }
  }

  @override
  _myLoginPageState({required this.loginmode, required this.title});

  @override
  void initState() {
   // _loginNameController.addListener(() => _readFromStorage());
    _readFromStorage();
   /* Future.delayed(
        Duration.zero,
        () => setState(() {
              _readFromStorage();
            }));
    _get();*/
    print(this.loginName + "-123");
    //  fAliPlayerMediaLoader = FlutterAliPlayerMediaLoader();
  }

  //-----------------------------------------------------------
  //region secure_storag

  IOSOptions _getIOSOptions() => const IOSOptions(
        accountName: "lhhj_sss",
      );

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
        // sharedPreferencesName: 'Test2',
        // preferencesKeyPrefix: 'Test'
      );

//endregion secure_storag
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      //飞行动画
      tag: 'hero',
      child: CircleAvatar(
        //圆形图片组件
        backgroundColor: Colors.transparent, //透明
        radius: 60.0, //半径
        child: Image.asset("assets/images/s1.jpeg"), //图片
      ),
    );

    final usernane = TextFormField(
      //用户名
      validator: validateUsername,
      autovalidateMode: AutovalidateMode.always,
      onSaved: (value) {
        debugPrint('username1000:$value');
        loginName = value!;
      },
      onChanged: (value) {
        debugPrint('username1110:$value');
        loginName = value!;
      },
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      //是否自动对焦
     // initialValue: 'lhhj',//loginName,
      controller: _loginNameController,
      //'liyuanjinglyj@163.com',//默认输入的类容
      decoration: InputDecoration(
          hintText: '请输入用户名',
          //提示内容
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //上下左右边距设置
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0) //设置圆角大小
              )),
    );
    var password = TextFormField(
      //密码
      validator: validatePassword,
      autovalidateMode: AutovalidateMode.always,
      onSaved: (value) {
        debugPrint('loginPwd1000:$value');
        loginPwd = value!;
      },
      onChanged: (value) {
        debugPrint('loginPwd1110:$value');
        loginPwd = value!;
      },
      autofocus: false,
     // initialValue:'sss',// loginPwd,
      // 'ssssssssssssssssssssss',
      controller: _loginPwdController,
      obscureText: true,
      decoration: InputDecoration(
          hintText: '请输入密码',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    ButtonStyle stylebt = ElevatedButton.styleFrom(
      backgroundColor: Colors.redAccent,
      foregroundColor: Colors.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      shape: const StadiumBorder(),
      side: const BorderSide(
        color: Colors.black,
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0), //上下各添加16像素补白
      child: Material(
        borderRadius: BorderRadius.circular(30.0), // 圆角度
        shadowColor: Colors.lightBlueAccent.shade100, //阴影颜色
        elevation: 5.0, //浮动的距离
        child: ElevatedButton(
          //minWidth: 200.0,
          //height: 42.0,
          onPressed: () {
            _writeToStorage();
            globalKeyValue.currentState?.save();
            globalKeyValue.currentState?.validate();

            debugPrint('username11:$loginName');
            debugPrint('password22:$loginPwd');


           var rt1 =dio_api_login(0,loginName,loginPwd,"yyy","xxx",2);
           // dio_getService() ;
           // api_login(loginName, loginPwd);
          rt1.then((value) {
             print('rt++= $value');
              if (value == "-1") {
                debugPrint('rt--= $value');

                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("错误"),
                        content: Text("用户名密码错误"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("确定"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("取消"),
                          ),
                        ],
                      );
                    });
              } else {
                debugPrint('rt=== $value');
                Fluttertoast.showToast(
                    msg: "登陆成功",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                    fontSize: 20.0);
                //navigateAfterSeconds.TabNavigator();
                //Navigator.of(context).push(TabNavigator as String);//点击跳转界面
                Navigator.pushAndRemoveUntil(
                  // .push(
                  context, //MaterialPageRoute配置要打开的页面、过渡动画等
                  MaterialPageRoute(
                      builder: (context) {
                        return TabNavigator(); //要打开的X页Widget
                      }, //settings: "tt",            //路由界面的配置信息，如路由界面名称
                      maintainState: true, //true是一直保存内存中,false是路由无用时释放资源
                      fullscreenDialog: false //新路由页面是否为全屏的模态对话框
                  ),
               // );
                (route) => route == null);
              }
            });
          },
          //color: Colors.green,//按钮颜色
          child: Text(
            '登 录',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          style: stylebt,
        ),
      ),
    );

    final forgotLabel = ElevatedButton(
        //扁平化的按钮，前面博主已经讲解过

        child: Text(
          '忘记密码?',
          style: TextStyle(color: Colors.black54, fontSize: 18.0),
        ),
        onPressed: () async {
          //loginName = usernane.text.toString();

          _add(loginName);
          debugPrint('password22:$loginPwd');

          Future<String?> stringFuture = SecureStorageUtil.getString("token");
          String? message = await stringFuture;
          debugPrint('gs:$message');
        },
        style: stylebt);

    // TODO: implement build
    // throw UnimplementedError();
    return Scaffold(
      appBar: AppBar(
        title: Text('登 录'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        key: globalKeyValue,
        child: ListView(
          //将这些组件全部放置在ListView中
          shrinkWrap: true, //内容适配
          padding: EdgeInsets.only(left: 24.0, right: 24.0), //左右填充24个像素块
          children: <Widget>[
            logo,
            const SizedBox(
              height: 48.0,
            ),
            //用来设置两个控件之间的间距
            usernane,
            const SizedBox(
              height: 8.0,
            ),
            password,
            const SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () async {
                  debugPrint('111忘记密码'); //   myForgotPasswordPage();

                  CommomUtils.pushPage(context, myForgotPasswordPage(loginName:loginName ,loginPwd:loginPwd));
                  //_readFromStorage();
                  debugPrint('111忘记密码' + loginName);
                  //  Future<String?> stringFuture =
                  //     SecureStorageUtil.getString("loginName");
                  //String? message = await stringFuture;
                  // debugPrint('loginName save:$message');
                },
                child: const Align(
                  child: Text("忘记密码?"),
                  alignment: Alignment.centerRight,
                )),

            const SizedBox(
              height: 5.0,
            ),
            loginButton,

            //forgotLabel,
            const SizedBox(
              height: 30,
            ),
          /*  InkWell(
                onTap: () {
                  SecureStorageUtil.putString("loginName", loginName);
                  debugPrint('save loginName');
                  // CommomUtils.pushPage(context, myRegisterPage());
                  //  goToSignUpPage();
                },
                child: const Align(
                  child: Text("save loginName"),
                  alignment: Alignment.center,
                )),
            SizedBox(
              height: 25.0,
            ),*/
            InkWell(
                onTap: () {
                 // _writeToStorage();
                  /* var future = _readFromStorage();
                  future.then((value) {
                    print(value);
                  }, onError: (e) {
                    print(e);
                  });*/
                  debugPrint('去注册');
                   CommomUtils.pushPage(context, myRegisterPage());
                  //  goToSignUpPage();
                },
                child: const Align(
                  child: Text("还没有账号?去注册"),
                  alignment: Alignment.center,
                )),
          ],
        ),
      ),
    );
  }

  _add(String _loginName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("loginName", _loginName);
  }

  _get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loginName = prefs.getString("loginName").toString() ?? "aaa";
    });
  }

  _writeToStorage() async {
    await _storage.write(
        iOptions: _getIOSOptions(), aOptions: _getAndroidOptions(), key: 'loginName', value: loginName);
    await _storage.write(iOptions: _getIOSOptions(), aOptions: _getAndroidOptions(), key: 'loginPwd', value: loginPwd);
    debugPrint('save ss');
  }

  _readFromStorage() async {
    loginName =
        await _storage.read(iOptions: _getIOSOptions(), aOptions: _getAndroidOptions(), key: 'loginName') ?? "aaa";
    loginPwd =
        await _storage.read(iOptions: _getIOSOptions(), aOptions: _getAndroidOptions(), key: 'loginPwd') ?? "sss";
    _loginNameController.text = loginName;
    _loginPwdController.text = loginPwd;
    setState(() {

    });
    debugPrint('load aa');
  }
}

class _SecItem {
  _SecItem(this.key, this.value);

  final String key;
  final String value;
}
