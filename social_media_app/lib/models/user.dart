import 'package:flutter/foundation.dart';

enum ProfileType {
  UserProfile,
  CommunityProfile,
}

class User {
  ProfileType profileType = ProfileType.UserProfile;
  String name;
  String userName;
  String image;
  String coverImage;
  String bio;
  List followers;
  num likes;
  num achievements;
  String email;
  List<String> skills;

  User({
    @required this.userName,
    @required this.image,
    @required this.coverImage,
    @required this.bio,
    @required this.name,
    this.followers,
    this.likes,
    this.achievements,
    this.email,
    this.skills
  });

  factory User.fromJson(Map<String, dynamic> json) {
    User user;
    if (json.containsKey('followers') &&
        json.containsKey('likes') &&
        json.containsKey('achievements')) {
      user = new User(
        userName: json['userName'],
        name: json['name'],
        image: json['image'],
        coverImage: json['coverImage'],
        bio: json['bio'],
        followers: json['followers'],
        likes: json['likes'],
        achievements: json['achievements'],
      );
    } else {
      user = new User(
        userName: json['userName'],
        image: json['image'],
        name: json['name'],
        coverImage: json['coverImage'],
        bio: json['bio'],
      );
    }
    return user;
  }
}
