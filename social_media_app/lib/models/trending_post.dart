import 'package:flutter/foundation.dart';
import 'package:social_media_app/models/post.dart';

class TrendingPost {
  // final String postId;
  //  final String userId;
  //  final String communityId;
  final String communityName;
  final String userName;
  final String title;
  final String image;
  final String text;
  final num likeCount;
  //  final num position;

  TrendingPost({
    this.communityName,
    this.image,
    this.text,
    @required this.userName,
    @required this.likeCount,
    @required this.title,
  });
}
