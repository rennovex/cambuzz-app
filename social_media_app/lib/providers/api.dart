import 'dart:convert';
import 'package:async/async.dart';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:social_media_app/models/community.dart';
import 'package:social_media_app/models/http_helper.dart';
import 'package:social_media_app/models/post.dart';
import 'package:social_media_app/models/user.dart';
// import 'package:provider/provider.dart';

/*
  Future getFeed() async {
    final response = await HttpHelper().getApi('/feed');

    return jsonDecode(response.body);
  }
  */
class Api {
  static AsyncMemoizer _memoizer = AsyncMemoizer();

  static Future feedRefresh() async {
    print('refresh');
    // _memoizer = await AsyncMemoizer();
    // return getFeed();
    // await getFeed();
  }

  static Future getFeed() async {
    print('getfeedRefresh');
    final response = await HttpHelper().getApi('/feed');

    if (response.statusCode != 200) {
      throw response.body;
    }

    final json = jsonDecode(response.body) as List;

    final List<Post> posts = [];

    json.forEach((post) {
      return posts.add(Post.fromJson(post));
    });

    return posts;
  }

  /*
  getEventsFromCommunity(String communityId){
    final response = await HttpHelper().getApi('/events/community/'+communityId);
    //Parse
    return {Event(), Event(), Event()}

  }
  */
}
