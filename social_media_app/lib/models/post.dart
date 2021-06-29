import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:social_media_app/models/community.dart';
import 'package:social_media_app/models/user.dart';

class Post {
  User user;
  Community community;

  final String time;
  final String title;
  final String postImg;
  final String postText;

  Post(
      {this.user,
      this.community,
      this.title,
      this.postImg,
      this.postText,
      this.time});

  bool isUserPost() {
    return this.community == null ? true : false;
  }

  bool isImagePost() {
    return this.postImg == null ? false : true;
  }

  static Post userPost(
    user,
    title,
    postImg,
    postText,
    time,
  ) {
    return Post(
      user: user,
      title: title,
      postImg: postImg,
      postText: postText,
      time: time,
    );
  }

  static Post communityPost(
    community,
    user,
    title,
    postImg,
    postText,
    time,
  ) {
    return Post(
      community: community,
      title: title,
      postImg: postImg,
      postText: postText,
      time: time,
      user: user,
    );
  }

  static Post fromJson(json) {
    var user = User.fromJson(json['user']);

    if (json['postType'] == 'userPost') {
      return Post.userPost(user, json['title'], json['postImage'],
          json['postText'], json['time']);
    } else {
      return Post.communityPost(Community.fromJson(json['community']), user,
          json['title'], json['postImage'], json['postText'], json['time']);
    }
  }
}
