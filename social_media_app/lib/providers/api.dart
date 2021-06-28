import 'dart:convert';
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
  class Api with ChangeNotifier{
  Future<List<Post>> getFeed() async {
    final response = await HttpHelper().getApi('/feed');
    final json = jsonDecode(response.body) as List;

    final List<Post> posts = [];

    json.forEach((post) {
      var user = User.fromJson(post['user']);

      posts.add(
        post['postType']=='userPost'?Post.userPost(user, post['title'], post['postImage'], post['postText'], post['time']):

          Post.communityPost(Community.fromJson(post['community']), user, post['title'], post['postImage'], post['postText'], post['time'])
        );
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
