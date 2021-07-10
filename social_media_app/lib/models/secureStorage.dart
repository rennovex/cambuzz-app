import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final _storage = FlutterSecureStorage();

  static String _apiToken;
  static String _uid;

  // factory SecureStorage.load(){
  //  readApiToken()

  // }

  // String get uid{
  //   readUid().then((value) => _uid);
  // }

  static Future setApiToken(String apiToken) async =>
      await _storage.write(key: 'apiToken', value: '$apiToken');

  static Future setUid(String uid) async =>
      await _storage.write(key: 'uid', value: '$uid');

  static Future<String> readUid() async => await _storage.read(key: 'uid');

  static Future<String> readApiToken() async =>
      await _storage.read(key: 'apiToken');

  static Future deleteAll() async => await _storage.deleteAll();

  static String getApiToken() {
    readApiToken().then((value) {
      _apiToken = value;
    });
    return _apiToken;
  }

  static String getUid() {
    readUid().then((value) {
      _uid = value;
    });
    return _uid;
  }
}
