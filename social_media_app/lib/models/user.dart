import 'package:flutter/foundation.dart';

enum ProfileType {
  UserProfile,
  CommunityProfile,
}

class User {
  final ProfileType profileType = ProfileType.UserProfile;
  final String name;
  final String userName;
  final String image;
  final String coverImage;
  final String bio;
  final num followers;
  final num likes;
  final num achievements;

  User({
    @required this.userName,
    @required this.image,
    @required this.coverImage,
    @required this.bio,
    @required this.name,
    this.followers,
    this.likes,
    this.achievements,
  });

  static User fromJson(Map<String, dynamic> json) {
    User user;
    if (json.containsKey('followers') &&
        json.containsKey('likes') &&
        json.containsKey('achievements')) {
      user = new User(
        userName: json['userName'],
        name:json['name'],
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
        name:json['name'],
        coverImage: json['coverImage'],
        bio: json['bio'],
      );
    }
    return user;
  }
}
