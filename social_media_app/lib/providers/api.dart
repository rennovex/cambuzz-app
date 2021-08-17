import 'dart:convert';
import 'package:async/async.dart';
import 'dart:ffi';
import 'package:social_media_app/models/event.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:social_media_app/models/community.dart';
import 'package:social_media_app/models/http_helper.dart';
import 'package:social_media_app/providers/post.dart';
import 'package:social_media_app/models/user.dart';
// import 'package:provider/provider.dart';

/*
  Future getFeed() async {
    final response = await HttpHelper().getApi('/feed');

    return jsonDecode(response.body);
  }
  */
class Api {
  static Future feedRefresh() async {
    print('refresh');
    // _memoizer = await AsyncMemoizer();
    // return getFeed();
    // await getFeed();
  }

  static Future getFeed() async {
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

  static Future<User> getUser() async {
    final response = await HttpHelper().getApi('/users');

    if (response.statusCode != 200) {
      throw response.body;
    }

    final json = jsonDecode(response.body);
    User user = User.fromJson(json);
    return user;
  }

  static Future<List<Event>> getEvents() async {
    final response = await HttpHelper().getApi('/events/all');

    print(response.body);

    final json = jsonDecode(response.body) as List;

    final List<Event> events = [];
    json.forEach((e) {
      print(e);
      events.add(Event.fromJson(e));
    });
    print(events);

    return events;
  }
  /*
  getEventsFromCommunity(String communityId){
    final response = await HttpHelper().getApi('/events/community/'+communityId);
    //Parse
    return {Event(), Event(), Event()}

  }
  */
}
