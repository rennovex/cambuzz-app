import 'package:flutter/foundation.dart';

import 'http_helper.dart';

enum ProfileType {
  UserProfile,
  CommunityProfile,
}

class User with ChangeNotifier {
  // ProfileType profileType = ProfileType.UserProfile;
  String uid;
  String name;
  String userName;
  String image;
  String coverImage;
  String bio;
  int followersCount;
  int followingCount;
  int likeCount;
  num achievements;
  String email;
  List<String> skills;
  bool isAbstract;
  bool isFollowing;

  User(
      {@required this.uid,
      @required this.userName,
      @required this.image,
      this.coverImage,
      this.bio,
      @required this.name,
      @required this.isAbstract,
      this.followersCount,
      this.followingCount,
      this.likeCount,
      this.achievements,
      this.isFollowing,
      this.email,
      this.skills});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['_id'],
      userName: json['userName'],
      name: json['name'],
      image: json['image'],
      coverImage: json['coverImage'],
      bio: json['bio'],
      followingCount: json['followingCount'],
      followersCount: json['followersCount'],
      likeCount: json['likeCount'],
      isFollowing: json['isFollowing'],
      isAbstract: false,
    );
  }

  factory User.fromJsonMyProfile(Map<String, dynamic> json) {
    return User(
      uid: json['_id'],
      userName: json['userName'],
      name: json['name'],
      image: json['image'],
      email: json['email'],
      coverImage: json['coverImage'],
      bio: json['bio'],
      followingCount: json['followingCount'],
      followersCount: json['followersCount'],
      likeCount: json['likeCount'],
      isFollowing: json['isFollowing'],
      isAbstract: false,
    );
  }

  factory User.fromJsonAbstract(Map<String, dynamic> json) {
    return User(
        uid: json['_id'],
        userName: json['userName'],
        image: json['image'],
        name: json['name'],
        isAbstract: true);
  }

  void toggleFollow() async {
    final oldStatus = isFollowing;
    final oldCount = followersCount;

    isFollowing = !isFollowing;
    isFollowing ? followersCount++ : followersCount--;
    notifyListeners();
    final response = isFollowing
        ? await HttpHelper.post(
            uri: '/users/follow/${this.uid}',
            body: {},
          )
        : await HttpHelper.delete(
            uri: '/users/follow/${this.uid}',
            body: {},
          );
    if (response.statusCode != 200) {
      isFollowing = oldStatus;
      followersCount = oldCount;
      notifyListeners();
      throw 'Cant unfollow ${response.body} of post ${this.uid}';
    }
  }
}
