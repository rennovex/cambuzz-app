import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:social_media_app/models/user.dart';

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

  static Future setUser(User user) async {
    await _storage.write(key: 'my_userName', value: user.userName);
    await _storage.write(key: 'my_name', value: user.name);
    await _storage.write(key: 'my_uid', value: user.uid);
    await _storage.write(key: 'my_bio', value: user.bio);
    await _storage.write(
        key: 'my_followersCount', value: user.followersCount.toString());
    await _storage.write(
        key: 'my_followingCount', value: user.followingCount.toString());
    await _storage.write(key: 'my_likeCount', value: user.likeCount.toString());
    await _storage.write(key: 'my_image', value: user.image);
    await _storage.write(key: 'my_coverImage', value: user.coverImage);
  }

  static Future<User> readUser() async {
    try {
      User user = new User();
      user.userName = await _storage.read(key: 'my_userName');
      user.name = await _storage.read(key: 'my_name');
      user.uid = await _storage.read(key: 'my_uid');
      user.bio = await _storage.read(key: 'my_bio');
      user.followersCount =
          int.parse(await _storage.read(key: 'my_followersCount'));
      user.followingCount =
          int.parse(await _storage.read(key: 'my_followingCount'));
      user.likeCount = int.parse(await _storage.read(key: 'my_likeCount'));
      user.image = await _storage.read(key: 'my_image');
      user.coverImage = await _storage.read(key: 'my_coverImage');

      return user;
    } catch (ex) {
      throw 'user not found' + ex.toString();
    }
  }

  static Future setApiToken(String apiToken) async =>
      await _storage.write(key: 'apiToken', value: '$apiToken');

  static Future setUid(String uid) async =>
      await _storage.write(key: 'uid', value: '$uid');

  static Future<String> readUid() async {
    return await _storage.read(key: 'uid');

  }

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
