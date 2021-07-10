import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/Global/globals.dart';
import 'package:social_media_app/models/secureStorage.dart';

class HttpHelper {
  static const serverUrl =
      'http://cambuzz-env.eba-kru6xdw3.us-west-2.elasticbeanstalk.com/api';

  // var _apiToken;

  Future<http.Response> post({String uri, Map<String, dynamic> body}) async {
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

  Future<http.Response> delete({String uri, Map<String, dynamic> body}) async {
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

  Future<http.Response> getApi(String uri) async {
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
