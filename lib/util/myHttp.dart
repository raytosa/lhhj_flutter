import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


Future<String>  getService()  async {
  String result="112";
  try {
    Uri url = Uri.parse('https://api.6hhj.cc/HistorySevice/GetResult');
    // Future<http.Response> response = http.get( url );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("result0="+response.body.toString());
      ClassGetResult rGetResult=  ClassGetResult.fromJson(jsonDecode(response.body));
      result =rGetResult.list;
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
  final int code;  final String list;
  const ClassGetResult({    required this.code,    required this.list,  });
  factory ClassGetResult.fromJson(Map<String, dynamic> json) {
    return ClassGetResult(      code: json['code'],      list: json['list'],    );
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