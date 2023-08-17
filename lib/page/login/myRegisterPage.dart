import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../util/myHttpDio.dart';

///  忘记密码界面
class myRegisterPage extends StatefulWidget {
  const myRegisterPage({Key? key}) : super(key: key);

  @override
  State<myRegisterPage> createState() => _myRegisterPageState();
}

class _myRegisterPageState extends State<myRegisterPage> {
  late String loginName = "aaa";
  late String loginYzm = "sss";
  late String loginPwd1 = "sss";
  late String loginPwd2 = "sss";
  late String loginEmail = "Rayto_sa@163.com";

  late int loginmode = 0;
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerYzm = TextEditingController();
  final TextEditingController _controllerPwd1 = TextEditingController();
  final TextEditingController _controllerPwd2 = TextEditingController();
  late Color myNameButtenColor = Colors.red;
  late Color myEmailButtenColor = Colors.red;
  late Color myRegButtenColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  ///
  Widget getBody() {
    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 15, top: 20),
              child: Icon(Icons.arrow_back_ios),
            )),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              const Text("注册新账号", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              const SizedBox(
                height: 38,
              ),
              Container(
                //width:280 ,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        cursorColor: Colors.red,
                        controller: _controllerName,
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.red,
                            )),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.red,
                            )),
                            hintText: "请输入你的帐号",
                            hintStyle: TextStyle(fontSize: 14)),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: myNameButtenColor,
                            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)), // set the background color
                        onPressed: () {
                          if (_controllerName.text.isNotEmpty) {
                            var rtl1 = chkLoginName(_controllerName.text);
                            rtl1.then((value) {
                              debugPrint('rtl1= ' + value.toString());
                              setState(() {
                                if (value == 1) {
                                  myNameButtenColor = Colors.green;
                                  debugPrint('color 失败= ' + myNameButtenColor.toString());
                                } else {
                                  myNameButtenColor = Colors.orange;
                                  debugPrint('color 失败= ' + myNameButtenColor.toString());
                                }
                              });
                            });
                          }
                        },
                        child: const Text(
                          "检查",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ), //检查帐号
              const SizedBox(
                height: 18,
              ),
              Container(
                //width:280 ,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        cursorColor: Colors.red,
                        controller: _controllerEmail,
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.red,
                            )),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.red,
                            )),
                            hintText: "请输入你的邮箱",
                            hintStyle: TextStyle(fontSize: 14)),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: myEmailButtenColor,
                            padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 16),
                            textStyle:
                                const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)), // set
                        onPressed: () {
                          if (_controllerEmail.text.isNotEmpty) {
                            var rtl1 = sendYzmUseEmail(_controllerName.text,_controllerEmail.text);
                            rtl1.then((value) {
                              debugPrint('rtl1= ' + value.toString());
                              setState(() {
                                if (value == 1) {
                                  myEmailButtenColor = Colors.green;
                                  debugPrint('color 失败= ' + myEmailButtenColor.toString());
                                } else {
                                  myEmailButtenColor = Colors.orange;
                                  debugPrint('color 失败= ' + myEmailButtenColor.toString());
                                }
                              });
                            });
                          }
                        },
                        child: const Text(
                          "获取验证码",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ), //获取验证码
              const SizedBox(
                height: 18,
              ),
              TextField(
                cursorColor: Colors.red,
                controller: _controllerYzm,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.red,
                    )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.red,
                    )),
                    hintText: "请输入你的验证码",
                    hintStyle: TextStyle(fontSize: 14)),
              ), //验证码
              const SizedBox(
                height: 10,
              ),
              TextField(
                cursorColor: Colors.red,
                controller: _controllerPwd1,
                obscureText: true,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.red,
                    )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.red,
                    )),
                    hintText: "请输入新密码",
                    hintStyle: TextStyle(fontSize: 14)),
              ), //新密码1
              const SizedBox(
                height: 10,
              ),
              TextField(
                cursorColor: Colors.red,
                controller: _controllerPwd2,
                obscureText: true,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.red,
                    )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.red,
                    )),
                    hintText: "请再次输入新密码",
                    hintStyle: TextStyle(fontSize: 14)),
              ), //新密码2
              const SizedBox(
                height: 25,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: myRegButtenColor,
                            padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 16),
                            textStyle:
                                const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)), // set
                        onPressed: () {
                          if (_controllerPwd1.text.isNotEmpty && _controllerPwd2.text.isNotEmpty) {
                            if (_controllerPwd1.text != _controllerPwd2.text) {
                              Fluttertoast.showToast(
                                  msg: "两次输入密码不符，请重新输入",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 20.0);
                            }
                          }
                          if (_controllerYzm.text.isNotEmpty &&
                              _controllerPwd1.text.isNotEmpty &&
                              _controllerPwd2.text.isNotEmpty) {
                            var rtl1 = sendReg(
                                _controllerName.text, _controllerEmail.text, _controllerYzm.text, _controllerPwd1.text);
                            rtl1.then((value) {
                              debugPrint('rtl1= ' + value.toString());
                              setState(() {
                                if (value == 1) {
                                  myRegButtenColor = Colors.green;
                                  debugPrint('color 失败= ' + myRegButtenColor.toString());
                                } else {
                                  myRegButtenColor = Colors.orange;
                                  debugPrint('color 失败= ' + myRegButtenColor.toString());
                                }
                              });
                            });
                          } else {
                            Fluttertoast.showToast(
                                msg: "请完整输入注册信息",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 20.0);
                          }
                        },
                        child: const Text(
                          "注   册",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  )
                ],
              ), //注   册
            ],
          ),
        ),
      ],
    ));
  }

  Future<int> sendReg(String name_text, email_text, String yzm_text, String pwd_text) async {
    int rtl1 = 0;
    if (yzm_text.isNotEmpty) {
      var rt1 = await dio_api_login(6, name_text, pwd_text, yzm_text, email_text, 2);

      print('rt++= $rt1');
      var retmsg = "注册成功";
      if (rt1 == "-1") {
        retmsg = "注册失败，请稍后重试";
        rtl1 = 0;
      } else if (rt1 == "1") {
        rtl1 = 1;
      }
      Fluttertoast.showToast(
          msg: retmsg,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 20.0);
    }
    return rtl1;
  }

  Future<int> sendYzmUseEmail(String name_text,String email_text) async {
    int rtl1 = 0;
    if (email_text.isNotEmpty) {
      //   debugPrint('sendYzmUseEmail 001'+widget.loginName+','+widget.loginPwd+','+emailField);
      var rt1 = await dio_api_login(2, name_text, "sss", "yyy", email_text, 2);

      print('rt++= $rt1');
      var retmsg = "发送成功，请从邮箱接收验证码";
      if (rt1 == "-1") {
        retmsg = "发送失败，请稍后重试";
        rtl1 = 0;
      } else if (rt1 == "1") {
        rtl1 = 1;
      }
      Fluttertoast.showToast(
          msg: retmsg,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 20.0);
    }
    return rtl1;
  }

  Future<int> chkLoginName(String Name_text) async {
    int rtl1 = 0;
    if (Name_text.isNotEmpty) {
      //   debugPrint('sendYzmUseEmail 001'+widget.loginName+','+widget.loginPwd+','+emailField);
      var rt1 = await dio_api_login(1, Name_text, "sss", "yyy", "email", 2);

      print('rt++= $rt1');
      var retmsg = "检查成功，此账号未被占用";
      if (rt1 == "-1") {
        retmsg = "检查失败，此账号已被占用";
        rtl1 = 0;
      } else if (rt1 == "1") {
        rtl1 = 1;
      }
      Fluttertoast.showToast(
          msg: retmsg,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 20.0);
    }
    return rtl1;
  }

  /// 获取短信验证码弹框
  Future<void> alertSample(email) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("获取短信验证码"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("发送验证码至 $email 邮箱"),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("确认"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
