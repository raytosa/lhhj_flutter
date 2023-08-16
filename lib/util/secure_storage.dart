import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageUtil{

  static FlutterSecureStorage _preferences = FlutterSecureStorage();

  static void init() {
    _preferences = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  }
  static Future<String?> getString (String key, {String defValue = ''}) async {
    return _preferences.read(key:key) ;
  }

  static Future<void> putString(String key, String value) async {
    return _preferences.write(key:key, value:value);
  }
  static Future<void> delete(String key) async {
    await _preferences!.delete(key: key);
  }
}