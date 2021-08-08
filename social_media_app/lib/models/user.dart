import 'package:flutter/foundation.dart';

enum ProfileType {
  UserProfile,
  CommunityProfile,
}

class User {
  // ProfileType profileType = ProfileType.UserProfile;
  String uid;
  String name;
  String userName;
  String image;
  String coverImage;
  String bio;
  int followersCount;
  int followingCount;
  num likes;
  num achievements;
  String email;
  List<String> skills;
  bool isAbstract;
  bool isFollowing;
  bool isMyProfile;

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
      this.likes,
      this.achievements,
      this.isFollowing,
      this.email,
      this.isMyProfile,
      this.skills});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
        uid: json['_id'],
        userName: json['userName'],
        name: json['name'],
        image: json['image'],
        coverImage: json['coverImage'],
        bio: json['bio'],
        followingCount: json['followingCount'],
        followersCount: json['followersCount'],
        likes: json['likes'],
        isFollowing: json['isFollowing'],
        isAbstract: false,
        isMyProfile: false,
      );
  }

  factory User.fromJsonMyProfile(Map<String, dynamic> json){
    return User(
        uid: json['_id'],
        userName: json['userName'],
        name: json['name'],
        image: json['image'],
        coverImage: json['coverImage'],
        bio: json['bio'],
        followingCount: json['followingCount'],
        followersCount: json['followersCount'],
        likes: json['likes'],
        isFollowing: json['isFollowing'],
        isAbstract: false,
        isMyProfile: true,
      );
  }

  factory User.fromJsonAbstract(Map<String, dynamic> json) {
    return User(
      uid: json['_id'],
      userName: json['userName'],
      image: json['image'],
      name: json['name'],
      isAbstract: true
    );
  }
}
