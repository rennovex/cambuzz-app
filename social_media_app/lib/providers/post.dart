import 'package:flutter/foundation.dart';
import 'package:social_media_app/Global/globals.dart';
import 'package:social_media_app/models/comment.dart';
import 'package:social_media_app/models/community.dart';
import 'package:social_media_app/models/http_helper.dart';
import 'package:social_media_app/models/user.dart';

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
    this.likes,
    this.likeCount,
    this.isLiked = false,
  }) {
    this.isLiked = liked ?? false;
    this.likeCount = likes.length;
    this.commentCount = comments.length;
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
      id: postId,
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
      id: postId,
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
      return Post.userPost(
          json['_id'],
          user,
          json['title'],
          json['postImage'],
          json['postText'],
          DateTime.parse(json['time']),
          json['likes'],
          json['comments']);
    } else {
      return Post.communityPost(
        json['_id'],
        Community.fromJson(json['community']),
        user,
        json['title'],
        json['postImage'],
        json['postText'],
        DateTime.parse(json['time']),
        json['likes'],
        json['comments'],
      );
    }
  }

  void toggleLike(String postId) async {
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

  Future postcomment({String id, String comment}) async {
    final response = await HttpHelper()
        .post(uri: '/posts/comments/$id', body: {"commentText": "$comment"});

    if (response.statusCode != 200) {
      throw 'Not Commented ' + response.body;
    }

    // comments.add(Comment(id: id,user: Global.uid,text: comment));
    // Post postDecoded = Post.fromJson(response.body);
    // comments = postDecoded.comments;
    // notifyListeners();
  }
}
