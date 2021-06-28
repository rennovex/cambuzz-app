import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:social_media_app/models/http_helper.dart';
// import 'package:provider/provider.dart';

class Api with ChangeNotifier {
  Future getFeed() async {
    final response = await HttpHelper().getApi('/feed');

    return jsonDecode(response.body);
  }

  /*
  getEventsFromCommunity(String communityId){
    final response = await HttpHelper().getApi('/events/community/'+communityId);
    //Parse
    return {Event(), Event(), Event()}

  }
  */
}
