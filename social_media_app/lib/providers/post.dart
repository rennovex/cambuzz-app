import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  num likeCount;
  num commentCount;
  List comments;

  Post({
    this.id,
    this.user,
    this.community,
    this.title,
    this.postImg,
    this.postText,
    this.time,
    this.commentCount,
    this.likeCount,
    this.isLiked,
  }) {}

  String get howLongAgo {
    DateTime today = DateTime.now();
    Duration duration = today.difference(this.time);

    if (duration.inDays > 365) {
      return (duration.inDays ~/ 365).toString() + ' yrs';
    } else if (duration.inDays > 30) {
      return (duration.inDays ~/ 30).toString() + ' mos';
    } else if (duration.inDays > 0) {
      return duration.inDays.toString() + ' days';
    } else if (duration.inHours > 0) {
      return duration.inHours.toString() + ' hrs';
    } else if (duration.inMinutes > 0) {
      return duration.inMinutes.toString() + ' min';
    } else if (duration.inSeconds > 0) {
      return duration.inSeconds.toString() + ' sec';
    } else if (duration.inSeconds == 0) {
      return 'now';
    }
    return 'error';
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
    likeCount,
    commentCount,
  ) {
    return Post(
        id: postId,
        user: user,
        title: title,
        postImg: postImg,
        postText: postText,
        time: time,
        commentCount: commentCount,
        likeCount: likeCount,
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
    likeCount,
    commentCount,
  ) {
    return Post(
      id: postId,
      community: community,
      title: title,
      postImg: postImg,
      postText: postText,
      time: time,
      user: user,
      commentCount: commentCount,
      likeCount: likeCount,
      isLiked: isLiked,
    );
  }

  factory Post.fromJson(json) {
    // if(json.containsKey)
    // if (json['user'] == null) return Post();
    var user = User.fromJsonAbstract(json['user']);

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
          json['isLiked'],
          json['likeCount'],
          json['commentCount']);
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
          json['isLiked'],
          json['likeCount'],
          json['commentCount']);
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

  void postcomment({String comment}) async {
    final response = await HttpHelper.post(
        uri: '/posts/comments/${this.id}', body: {"commentText": "$comment"});

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

  Future deletePost() async {
    final response =
        await HttpHelper.delete(uri: '/posts/${this.id}', body: {});

    if (response.statusCode != 200) {
      Fluttertoast.showToast(msg: 'Couldn\'t delete post');
      throw response.body + ' Couldnt delete post';
    }

    Fluttertoast.showToast(msg: 'Post deleted');

    return response;
  }

  Future deleteComment(String commentId) async {
    final response = await HttpHelper.delete(
        uri: '/posts/comments/${this.id}/$commentId', body: {});

    if (response.statusCode != 200) {
      Fluttertoast.showToast(msg: 'Couldn\'t delete comment');
      throw response.body + ' Couldnt delete comment';
    }

    final responseDecoded = jsonDecode(response.body) as List;
    comments = responseDecoded;
    commentCount--;
    notifyListeners();

    Fluttertoast.showToast(msg: 'Comment deleted');
    // notifyListeners();
    return response;
  }
}
