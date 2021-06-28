import 'package:flutter/foundation.dart';
import 'package:social_media_app/models/community.dart';
import 'package:social_media_app/models/user.dart';

enum PostType {
  ImagePost,
  TextPost,
}

class Post {
  User user;
  Community community;

  //remove
  final String profileImg;
  final String profileName;
  final String userName;

  final String time;
  final String title;
  final String postImg;
  final String postText;
  final PostType postType;

  Post({
    @required this.profileImg,
    @required this.profileName,
    @required this.time,
    @required this.title,
    @required this.userName,
    @required this.postType,
    this.postImg,
    this.postText,
  });
}
