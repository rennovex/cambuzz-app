import 'package:flutter/foundation.dart';

enum PostType {
  ImagePost,
  TextPost,
}

class Post {
  final String profile_img;
  final String profile_name;
  final String user_name;
  final String time;
  final String title;
  final String post_img;
  final String post_text;
  final PostType post_type;

  Post({
    @required this.profile_img,
    @required this.profile_name,
    @required this.time,
    @required this.title,
    @required this.user_name,
    @required this.post_type,
    this.post_img,
    this.post_text,
  });
}
