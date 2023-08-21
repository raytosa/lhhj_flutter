import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<String>  getService()  async {
  String result="112";
  try {
    Uri url = Uri.parse('https://api.6hhj.cc/HistorySevice/GetResult');
    // Future<http.Response> response = http.get( url );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      debugPrint("result0="+response.body.toString());
      ClassGetResult rGetResult=  ClassGetResult.fromJson(jsonDecode(response.body));
      result =rGetResult.data;
      // debugPrint("result1="+result);
      return result;
    } else {
      throw Exception('Failed to load ClassGetResult');
    }

  } catch(exception){
    result = exception.toString();
    debugPrint("result2="+result);
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