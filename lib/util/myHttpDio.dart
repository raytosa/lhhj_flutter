import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

Future<String> dio_api_login(int action, String username, String pwd, String yzm, String email, int level) async {
  String result = "112";
  try {
    debugPrint('username--:$username');
    debugPrint('password--:$pwd');
    debugPrint('emali--:$email');
    String url = "https://103.214.175.126:6001/lhhj_/lhhj_login";

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
        'https://103.214.175.126:6001/History_api/a6ha_GetRules'; //'''https://api.6hhj.cc/HistorySevice/GetResult';
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
