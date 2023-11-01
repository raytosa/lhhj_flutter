import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'common_utils.dart';

Future<String> dio_api_login(int action, String username, String pwd, String yzm, String email, int level) async {
  String result = "112";
  try {
    debugPrint('username--:$username');
    debugPrint('password--:$pwd');
    debugPrint('emali--:$email');
    String url = "https://103.214.175.108:6001/lhhj_/lhhj_login";

    ///创建Dio
    Dio dio = new Dio();
/*
    ///创建Map 封装参数
    Map<String, dynamic> map = Map();
    map['action'] = action;
    map['username'] = username;
    map['pwd'] = pwd;
    map['yzm'] = yzm;
    map['level'] = level;
*/

    String fromdata = jsonEncode(<String, dynamic>{
      "action": action,
      "username": username,
      "pwd": pwd,
      "yzm": yzm,
      "email": email,
      "level": level
    });
    debugPrint("---" + fromdata);

    ///发起post请求
    Response response = await dio.post(url, data: fromdata);
    String rl = response.statusCode.toString();
    debugPrint("*****" + rl);
    //response = await dio.post(url, data: "\""+data1+ "\"");
    var data = response.data.toString();
    debugPrint("result1=" + data);
    // ClassGetResult rGetResult=  ClassGetResult.fromJson(jsonDecode(response.data));
    Json1 j1 = Json1.fromJson(response.data);
    print(j1.data);
    debugPrint("rGetResult.code" + j1.code.toString());
    if (action == 0 && j1.code == 1) {
      List<String>? alltxt = j1.data?.split(';');
      for (String? it in alltxt!) {
        if (it!.isNotEmpty) {
          List<String>? itemtxt = it?.split(',');
          if (itemtxt!.isNotEmpty) {
            String item = itemtxt[0];
            int itemlen = int.parse(itemtxt[1]);
            int i = 0;
            switch (item) {
              case 'tabNavigator_page_label':
                for (i = 0; i < itemlen; i++) {
                  CommomUtils.tabNavigator_page_label[i] = itemtxt[i + 2];
                }
                break;
              case 'tabNavigator_page_url':
                for (i = 0; i < itemlen; i++) {
                  CommomUtils.tabNavigator_page_url[i] = itemtxt[i + 2];
                }
                break;
              case 'MyHomePageTab_mytitle':
                for (i = 0; i < itemlen; i++) {
                  CommomUtils.MyHomePageTab_mytitle[i] = itemtxt[i + 2];
                }
                break;
              case 'MyHomePageTab_myText':
                for (i = 0; i < itemlen; i++) {
                  CommomUtils.MyHomePageTab_myText[i] = itemtxt[i + 2];
                }
                break;
              case 'MyHomePageTab_PlayList':
                for (i = 0; i < itemlen; i++) {
                  CommomUtils.MyHomePageTab_PlayList[i] = itemtxt[i + 2];
                }
                break;
              case 'MyHomePageTab_Uri_ADHomePage':
                for (i = 0; i < itemlen; i++) {
                  List<String>? itemtxt_sub =  itemtxt[i + 2]?.split(' ');
                  CommomUtils.MyHomePageTab_Uri_ADHomePage[i] = Uri(
                      scheme: itemtxt_sub?[0],
                      host: itemtxt_sub?[1],
                      path: itemtxt_sub?[2]);
                }
                break;
              case 'MyHomePageTab_Uri_myHomePage':
                for (i = 0; i < itemlen; i++) {
                  List<String>? itemtxt_sub =  itemtxt[i + 2]?.split(' ');
                  CommomUtils.MyHomePageTab_Uri_myHomePage[i] = Uri(
                      scheme: itemtxt_sub?[0],
                      host: itemtxt_sub?[1],
                      path: itemtxt_sub?[2]);
                }
                break;
              case 'MyHomePageTab_Uri_my6hhjHomePage':
                for (i = 0; i < itemlen; i++) {
                  List<String>? itemtxt_sub =  itemtxt[i + 2]?.split(' ');
                  CommomUtils.MyHomePageTab_Uri_my6hhjHomePage[i] = Uri(
                      scheme: itemtxt_sub?[0],
                      host: itemtxt_sub?[1],
                      path: itemtxt_sub?[2]);
                }
                break;
              case 'MyHomePageTab_Ad_pic':
                for (i = 0; i < itemlen; i++) {
                  CommomUtils.MyHomePageTab_Ad_pic[i] = itemtxt[i + 2];
                }
                break;
              case 'xz_lab':
                for (i = 0; i < itemlen; i++) {
                  CommomUtils.xz_lab[i] = itemtxt[i + 2];
                }
                break;
              case 'xz_item':
                for (i = 0; i < itemlen; i++) {
                  CommomUtils.xz_item[i] = itemtxt[i + 2];
                }
                break;
              case 'xz_link':
                for (i = 0; i < itemlen; i++) {
                  CommomUtils.xz_link[i] = itemtxt[i + 2];
                }
                break;
            }
          }
        }
      }
    }
    if (j1.code == 0)
      return "-1";
    else
      return "1";
    return data;
  } catch (exception) {
    result = exception.toString();
    debugPrint("result2=" + result);
  }
  return "-1";
}

Future<String> dio_getService() async {
  String result = "112";
  try {
    final dio = Dio();
    String url =
        'https://103.214.175.108:6001/History_api/a6ha_GetRules'; //'''https://api.6hhj.cc/HistorySevice/GetResult';
    // Future<http.Response> response = http.get( url );
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      print("result0=" + response.data.toString());
      ClassGetResult rGetResult = ClassGetResult.fromJson(jsonDecode(response.data.toString()));
      result = rGetResult.data;
      // print("result1="+result);
      return result;
    } else {
      throw Exception('Failed to load ClassGetResult');
    }
  } catch (exception) {
    result = exception.toString();
    print("result2=" + result);
  }
  return result;
}

//----------------------------------------------------------------------------
class ClassGetResult {
  final int code;
  final int cntln;
  final int allcnt;
  final String data;

  const ClassGetResult({
    required this.code,
    required this.cntln,
    required this.allcnt,
    required this.data,
  });

  factory ClassGetResult.fromJson(Map<String, dynamic> json) {
    return ClassGetResult(
      code: json['code'],
      cntln: json['cntln'],
      allcnt: json['allcnt'],
      data: json['data'],
    );
  }
}

class Json1 {
  int? code;
  int? cntln;
  int? allcnt;
  String? data;

  Json1({this.code, this.cntln, this.allcnt, this.data});

  factory Json1.fromJson(Map<String, dynamic> json) {
    return Json1(
      code: json['code'],
      cntln: json['cntln'],
      allcnt: json['allcnt'],
      data: json['data'],
    );
  }
}

class Json2 {
  String? Item;
  int? Len;
  String? T0;
  String? T1;
  String? T2;
  String? T3;
  String? T4;
  String? T5;
  String? T6;

  Json2({this.Item, this.Len, this.T0, this.T1, this.T2, this.T3, this.T4, this.T5, this.T6});

  factory Json2.fromJson(Map<String, dynamic> json) {
    return Json2(
      Item: json['Item'],
      Len: json['Len'],
      T0: json['T0'],
      T1: json['T1'],
      T2: json['T2'],
      T3: json['T3'],
      T4: json['T4'],
      T5: json['T5'],
      T6: json['T6'],
    );
  }
}
