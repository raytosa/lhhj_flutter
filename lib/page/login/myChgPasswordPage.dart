import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../util/myHttpDio.dart';

///  忘记密码界面
class myChgPasswordPage extends StatefulWidget {
  final String loginName;
  final int chgMode;
  const myChgPasswordPage({Key? key, required this.loginName, required this.chgMode}) : super(key: key);

  @override
  State<myChgPasswordPage> createState() => _myChgPasswordPageState();
}

class _myChgPasswordPageState extends State<myChgPasswordPage> {
  final TextEditingController _controllerYzm = TextEditingController();
  final TextEditingController _controllerPwd1= TextEditingController();
  final TextEditingController _controllerPwd2 = TextEditingController();
  late String? hText="请输入你的验证码";
  @override
  Widget build(BuildContext context) {
    debugPrint('widget.chgMode= '+widget.chgMode.toString());
    if(widget.chgMode==1){this.hText="请输入你的旧密码";}
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
                  const Text("修改密码", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  const SizedBox(
                    height: 38,
                  ),
                  TextField(
                    cursorColor: Colors.red,
                    controller: _controllerYzm,
                    obscureText: true,
                    decoration:  InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            )),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            )),
                        hintText:  hText,
                        hintStyle: const TextStyle(fontSize: 14)),
                  ),
                  const SizedBox(
                    height: 30,
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
                    height: 30,
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
                    height: 30,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          //  color: Colors.red,
                            onPressed: () {
                              if (_controllerYzm.text.isNotEmpty&&_controllerPwd1.text.isNotEmpty&&_controllerPwd2.text.isNotEmpty) {
                                if (_controllerPwd1.text == _controllerPwd2.text) {
                                  do_ChgPwd();
                                }
                                else {
                                  Fluttertoast.showToast(
                                      msg: "两次密码输入不相同",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.TOP,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 20.0);
                                }
                              }else{Fluttertoast.showToast(
                                  msg: "请完整输入信息",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 20.0);}
                            },
                            child: const Text(
                              "修改密码",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                ],
              ),
            ),
          ],
        ));
  }

  do_ChgPwd() {

    String yzmField = _controllerYzm.text;
    String pwdField = _controllerPwd1.text;

    debugPrint('do_ChgPwd 001'+widget.loginName+','+widget.chgMode.toString()+','+yzmField+','+pwdField);
    var rt1 =dio_api_login(widget.chgMode+3,widget.loginName,'123',yzmField,pwdField,2);
    rt1.then((value) {
      print('rt++= $value');
      if (value == "-1") {
        debugPrint('do_ChgPwd 失败= $value');
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("错误"),
                content: Text("修改密码失败，请检查后重试"),
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
      } else if (value == "1") {
        debugPrint('do_ChgPwd 成功 $value');
        Fluttertoast.showToast(
            msg: "修改密码成功",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 20.0);
      }
    });



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
