import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/Global/globals.dart';

class HttpHelper {
  //static const serverUrl = 'http://192.168.18.51:3000/api';
  static const serverUrl =
      'https://cambuzz-rennovex.net/api';

  // var _apiToken;

  static Future<http.Response> putImage({String uri, XFile body}) async {
    // await SecureStorage.readApiToken().then((value) => _apiToken = value);
    var url = Uri.parse('$uri');
    return http.put(
      url,
      body: await body.readAsBytes(),
    );
  }

  static Future<http.Response> post(
      {String uri, Map<String, dynamic> body}) async {
    // await SecureStorage.readApiToken().then((value) => _apiToken = value);
    var url = Uri.parse(serverUrl + '$uri');
    return http.post(
      url,
      body: jsonEncode(body),
      headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "x-auth-token": "${Global.apiToken}",
      },
    );
  }

  static Future<http.Response> put(
      {String uri, Map<String, dynamic> body}) async {
    // await SecureStorage.readApiToken().then((value) => _apiToken = value);
    var url = Uri.parse(serverUrl + '$uri');
    return http.put(
      url,
      body: jsonEncode(body),
      headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "x-auth-token": "${Global.apiToken}",
      },
    );
  }

  static Future<http.Response> delete(
      {String uri, Map<String, dynamic> body}) async {
    // await SecureStorage.readApiToken().then((value) => _apiToken = value);
    var url = Uri.parse(serverUrl + '$uri');
    return http.delete(
      url,
      body: jsonEncode(body),
      headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "x-auth-token": "${Global.apiToken}",
      },
    );
  }

  static Future<http.Response> get(String uri) async {
    // await SecureStorage.readApiToken().then((value) => _apiToken = value);
    var url = Uri.parse(serverUrl + '$uri');
    return await http.get(
      url,
      headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "x-auth-token": "${Global.apiToken}",
      },
    );
  }
}
