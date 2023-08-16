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

                        //  color: Colors.red,
                        onPressed: () {
                          sendYzmUseEmail();
                        },
                        child: const Text(
                          "检查",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
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

                      //  color: Colors.red,
                        onPressed: () {
                          sendYzmUseEmail();
                        },
                        child: const Text(
                          "获取验证码",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),

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
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                cursorColor: Colors.red,
                controller: _controllerPwd1,
                obscureText: true,
                decoration:  const InputDecoration(
                    enabledBorder:  UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        )),
                    focusedBorder:  UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        )),
                    hintText:  "请输入新密码",
                    hintStyle:  TextStyle(fontSize: 14)),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                cursorColor: Colors.red,
                controller: _controllerPwd2,
                obscureText: true,
                decoration:  const InputDecoration(
                    enabledBorder:  UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        )),
                    focusedBorder:  UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        )),
                    hintText:  "请再次输入新密码",
                    hintStyle:  TextStyle(fontSize: 14)),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                        //  color: Colors.red,
                        onPressed: () {
                          sendYzmUseEmail();
                        },
                        child: const Text(
                          "注   册",
                          style: TextStyle(
                            color: Colors.white,
                              fontSize: 20
                          ),
                        )),
                  )
                ],
              ),

            ],
          ),
        ),
      ],
    ));
  }

  sendYzmUseEmail() {
    String emailField = _controllerEmail.text;
    if (emailField.isNotEmpty) {
      //   debugPrint('sendYzmUseEmail 001'+widget.loginName+','+widget.loginPwd+','+emailField);
      var rt1 = dio_api_login(2, loginName, loginPwd1, "yyy", emailField, 2);
      rt1.then((value) {
        print('rt++= $value');
        var retmsg = "发送成功，请从邮箱接收验证码";
        if (value == "-1") {
          debugPrint('sendYzmUseEmail 失败= $value');
          retmsg = "发送失败，请稍后重试";

          /*showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("错误"),
                  content: Text("发送验证码错误，请稍后重试"),
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
              });*/
        } else if (value == "1") {
          debugPrint('sendYzmUseEmail 成功 $value');
        }
        Fluttertoast.showToast(
            msg: retmsg,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 20.0);
      });

      //alertSample(emailField);
    }
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
