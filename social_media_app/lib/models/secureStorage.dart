import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final _storage = FlutterSecureStorage();

  static String _apiToken;

  static Future setApiToken(String apiToken) async =>
      await _storage.write(key: 'apiToken', value: '$apiToken');

  static Future<String> readApiToken() async =>
      await _storage.read(key: 'apiToken');

  static Future deleteApiToken() async => await _storage.deleteAll();

  static String getApiToken() {
    readApiToken().then((value) {
      _apiToken = value;
      print(_apiToken);
    });
    return _apiToken;
  }
}
