import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:social_media_app/models/secureStorage.dart';

class HttpHelper {
  static const serverUrl = 'https://cambuzz-rennovex.herokuapp.com/api';

  var _apiToken = SecureStorage.getApiToken();

  HttpHelper() {
    // _apiToken = SecureStorage.getApiToken();
  }

  // Future getApiToken() async {
  //   // String apiToken;
  //   await SecureStorage.readApiToken().then(
  //     (value) => _apiToken = value,
  //     // print(apiToken);
  //   );
  //   // print(_apiToken);
  //   // return apiToken;
  // }

  // String getToken() {
  //   getApiToken();
  //   // print(_apiToken);
  //   return _apiToken;
  // }

  // HttpHelper() {
  //   SecureStorage.readApiToken().then((value) {
  //     _apiToken = value;
  //     print(_apiToken);
  //   });
  // }

  Future<http.Response> post({String uri, Map<String, dynamic> body}) async {
    var url = Uri.parse(serverUrl + '$uri');
    return http.post(
      url,
      body: jsonEncode(body),
      headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "x-auth-token": _apiToken,
      },
    );
  }

  Future<http.Response> getApi(String uri) async {
    var url = Uri.parse(serverUrl + '$uri');
    // print(_apiToken);
    return http.get(
      url,
      headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "x-auth-token": "${_apiToken}",
      },
    );
  }
}
