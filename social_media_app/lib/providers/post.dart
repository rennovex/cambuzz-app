import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:social_media_app/Global/globals.dart';
import 'package:social_media_app/models/community.dart';
import 'package:social_media_app/models/http_helper.dart';
import 'package:social_media_app/models/secureStorage.dart';
import 'package:social_media_app/models/user.dart';

class Post with ChangeNotifier {
  User user;
  Community community;

  final String postId;
  final String time;
  final String title;
  final String postImg;
  final String postText;
  bool isLiked;
  final List likes;
  num likeCount;
  final List comments;

  Post({
    this.postId,
    this.user,
    this.community,
    this.title,
    this.postImg,
    this.postText,
    this.time,
    this.comments,
    this.likes,
    this.likeCount,
    this.isLiked = false,
  }) {
    this.isLiked = Liked ?? false;
    this.likeCount = likes.length;
  }

  bool get Liked {
    print(Global.uid);
    return likes?.contains(Global.uid);
  }

  bool isUserPost() {
    return this.community == null ? true : false;
  }

  bool isImagePost() {
    return this.postImg == null ? false : true;
  }

  static Post userPost(
    postId,
    user,
    title,
    postImg,
    postText,
    time,
    likes,
    comments,
  ) {
    return Post(
      postId: postId,
      user: user,
      title: title,
      postImg: postImg,
      postText: postText,
      time: time,
      likes: likes,
      comments: comments,
    );
  }

  static Post communityPost(
    postId,
    community,
    user,
    title,
    postImg,
    postText,
    time,
    likes,
    comments,
  ) {
    return Post(
      postId: postId,
      community: community,
      title: title,
      postImg: postImg,
      postText: postText,
      time: time,
      user: user,
      likes: likes,
      comments: comments,
    );
  }

  factory Post.fromJson(json) {
    var user = User.fromJson(json['user']);

    if (json['postType'] == 'userPost') {
      return Post.userPost(json['_id'], user, json['title'], json['postImage'],
          json['postText'], json['time'], json['likes'], json['comments']);
    } else {
      print(json);
      return Post.communityPost(
        json['_id'],
        Community.fromJson(json['community']),
        user,
        json['title'],
        json['postImage'],
        json['postText'],
        json['time'],
        json['likes'],
        json['comments'],
      );
    }
  }

  void toggleLike(String postId) async {
    print(postId);
    final oldStatus = isLiked;
    final oldCount = likeCount;

    isLiked = !isLiked;
    isLiked ? likeCount++ : likeCount--;
    notifyListeners();
    final response = isLiked
        ? await HttpHelper().post(
            uri: '/posts/like/$postId',
            body: {},
          )
        : await HttpHelper().delete(
            uri: '/posts/like/$postId',
            body: {},
          );
    if (response.statusCode != 200) {
      isLiked = oldStatus;
      likeCount = oldCount;
      notifyListeners();
      throw 'Cant like' + '${response.body}';
    }
  }
}