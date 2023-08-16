import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<int>  api_login(String username,String pwd,)  async {
  String result="112";
  try {
    debugPrint('username--:$username');
  debugPrint('password--:$pwd');
    Uri url = Uri.parse('https://103.214.175.126:6001/lhhj_/lhhj_login');
    // Future<http.Response> response = http.get( url );
    final response = await http.post(url, headers: <String, String>{
      'Content-Type': 'application/json-patch+json; charset=UTF-8',
    },
      body: jsonEncode(<String, dynamic>{
        'action': 0,
        "username":username,
        "pwd":pwd,
        "yzm":"sss",
        "level":2
      }),);
    if (response.statusCode == 200) {
      print("result0="+response.body.toString());
      ClassGetResult rGetResult=  ClassGetResult.fromJson(jsonDecode(response.body));
      result =rGetResult.data;
      print("result1="+result);
      return 1;
    } else { print("result1="+response.body.toString());
      throw Exception('Failed to load ClassGetResult');
    }

  } catch(exception){
    result = exception.toString();
    print("result2="+result);
  }
  return -1;

}

Future<String>  api_sendEmail()  async {
  String result="112";
  try {
    Uri url = Uri.parse('https://api.6hhj.cc/HistorySevice/GetResult');
    // Future<http.Response> response = http.get( url );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("result0="+response.body.toString());
      ClassGetResult rGetResult=  ClassGetResult.fromJson(jsonDecode(response.body));
      result =rGetResult.data;
      // print("result1="+result);
      return result;
    } else {
      throw Exception('Failed to load ClassGetResult');
    }

  } catch(exception){
    result = exception.toString();
    print("result2="+result);
  }
  return result;

}

Future<String>  getService()  async {
  String result="112";
  try {
    Uri url = Uri.parse('https://api.6hhj.cc/HistorySevice/GetResult');
    // Future<http.Response> response = http.get( url );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("result0="+response.body.toString());
      ClassGetResult rGetResult=  ClassGetResult.fromJson(jsonDecode(response.body));
      result =rGetResult.data;
      // print("result1="+result);
      return result;
    } else {
      throw Exception('Failed to load ClassGetResult');
    }

  } catch(exception){
    result = exception.toString();
    print("result2="+result);
  }
  return result;

}


//----------------------------------------------------------------------------
class ClassGetResult {
  final int code;  final String data;
  const ClassGetResult({    required this.code,    required this.data,  });
  factory ClassGetResult.fromJson(Map<String, dynamic> json) {
    return ClassGetResult(      code: json['code'],      data: json['data'],    );
  }
}


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}