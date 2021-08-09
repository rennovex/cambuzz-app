import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:social_media_app/Global/globals.dart';
import 'package:social_media_app/models/comment.dart';
import 'package:social_media_app/models/community.dart';
import 'package:social_media_app/models/http_helper.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/widgets/post_item.dart';

class Post with ChangeNotifier {
  User user;
  Community community;

  final String id;
  final DateTime time;
  final String title;
  final String postImg;
  final String postText;
  bool isLiked;
  final List likes;
  num likeCount;
  List comments;
  num commentCount;

  Post({
    this.id,
    this.user,
    this.community,
    this.title,
    this.postImg,
    this.postText,
    this.time,
    this.comments,
    this.commentCount,
    this.likes,
    this.likeCount,
    this.isLiked,
  }) {
    this.likeCount = likes?.length ?? 0;
    this.commentCount = comments?.length ?? 0;
  }

  String get howLongAgo {
    DateTime today = DateTime.now();
    Duration duration = today.difference(this.time);
    if (duration.inDays > 0) {
      return duration.inDays.toString() + ' days ago';
    } else if (duration.inHours > 0) {
      return duration.inHours.toString() + ' hours ago';
    } else if (duration.inMinutes > 0) {
      return duration.inMinutes.toString() + ' minutes ago';
    } else if (duration.inSeconds > 0) {
      return duration.inSeconds.toString() + ' seconds ago';
    }
    return 'error';
  }

  bool get liked {
    return likes?.contains(Global.uid);
  }

  bool isUserPost() {
    return this.community == null ? true : false;
  }

  bool isImagePost() {
    return this.postImg == null ? false : true;
  }

  Post userPost(
    postId,
    user,
    title,
    postImg,
    postText,
    time,
    likes,
    comment,
    isLiked,
  ) {
    return Post(
        id: postId,
        user: user,
        title: title,
        postImg: postImg,
        postText: postText,
        time: time,
        likes: likes,
        comments: comments,
        isLiked: isLiked);
  }

  Post communityPost(
    postId,
    community,
    user,
    title,
    postImg,
    postText,
    time,
    likes,
    comments,
    isLiked,
  ) {
    return Post(
        id: postId,
        community: community,
        title: title,
        postImg: postImg,
        postText: postText,
        time: time,
        user: user,
        likes: likes,
        comments: comments,
        isLiked: isLiked);
  }

  factory Post.fromJson(json) {
    // if(json.containsKey)
    // if (json['user'] == null) return Post();
    print('trying building post');
    var user = User.fromJsonAbstract(json['user']);
    print('user completed');

    if (json['postType'] == 'userPost') {
      return Post().userPost(
          json['_id'],
          user,
          json['title'],
          json['postImage'],
          json['postText'],
          DateTime.parse(json['time']),
          json['likes'],
          json['comments'],
          json['isLiked']);
    } else {
      return Post().communityPost(
          json['_id'],
          Community.fromJsonAbstract(json['community']),
          user,
          json['title'],
          json['postImage'],
          json['postText'],
          DateTime.parse(json['time']),
          json['likes'],
          json['comments'],
          json['isLiked']);
    }
  }

  void toggleLike() async {
    final oldStatus = isLiked;
    final oldCount = likeCount;

    isLiked = !isLiked;
    isLiked ? likeCount++ : likeCount--;
    notifyListeners();
    final response = isLiked
        ? await HttpHelper.post(
            uri: '/posts/like/${this.id}',
            body: {},
          )
        : await HttpHelper.delete(
            uri: '/posts/like/${this.id}',
            body: {},
          );
    if (response.statusCode != 200) {
      isLiked = oldStatus;
      likeCount = oldCount;
      notifyListeners();
      throw 'Cant like ${response.body} of post ${this.id}';
    }
  }

  void postcomment({String id, String comment}) async {
    final response = await HttpHelper.post(
        uri: '/posts/comments/$id', body: {"commentText": "$comment"});

    if (response.statusCode != 200) {
      throw 'Not Commented ' + response.body;
    }
    final responseDecoded = jsonDecode(response.body) as List;
    comments = responseDecoded;
    commentCount++;
    notifyListeners();
  }

  Future getComments() async {
    final response = await HttpHelper.get('/posts/comments/$id');

    if (response.statusCode != 200) {
      throw response.body;
    }

    final json = jsonDecode(response.body) as List;
    comments = json;
    // return json;
    notifyListeners();
    return response;
  }
}
