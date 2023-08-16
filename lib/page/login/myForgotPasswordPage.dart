import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../util/common_utils.dart';
import '../../util/myHttpDio.dart';
import 'myChgPasswordPage.dart';

///  忘记密码界面
class myForgotPasswordPage extends StatefulWidget {
  final String loginName;
  final String loginPwd;
  const myForgotPasswordPage({Key? key, required this.loginName, required this.loginPwd}) : super(key: key);

  @override
  State<myForgotPasswordPage> createState() => _myForgotPasswordPageState();
}

class _myForgotPasswordPageState extends State<myForgotPasswordPage> {
  final TextEditingController _controllerEmail = TextEditingController();

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
              const Text("忘记密码", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              const SizedBox(
                height: 38,
              ),
              TextField(
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
                    hintText: "请输入你的邮箱号",
                    hintStyle: TextStyle(fontSize: 14)),
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
                          sendYzmUseEmail();
                        },
                        child: const Text(
                          "获取验证码",
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
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                        //  color: Colors.red,
                        onPressed: () {
                          CommomUtils.pushPage(context, myChgPasswordPage(loginName:widget.loginName ,chgMode: 0,));

                        },
                        child: const Text(
                          "已获取--下一步",
                          style: TextStyle(
                            color: Colors.white,
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
      debugPrint('sendYzmUseEmail 001'+widget.loginName+','+widget.loginPwd+','+emailField);
      var rt1 =dio_api_login(2,widget.loginName,widget.loginPwd,"yyy",emailField,2);
      rt1.then((value) {
        print('rt++= $value');
        var retmsg="发送成功，请从邮箱接收验证码";
        if (value == "-1") {
          debugPrint('sendYzmUseEmail 失败= $value');
          retmsg="发送失败，请稍后重试";

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
