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
  List followers;
  List following;
  num likes;
  num achievements;
  String email;
  List<String> skills;

  User(
      {@required this.uid,
      @required this.userName,
      @required this.image,
      this.coverImage,
      this.bio,
      @required this.name,
      this.followers,
      this.following,
      this.likes,
      this.achievements,
      this.email,
      this.skills});

  factory User.fromJson(Map<String, dynamic> json) {
    // User user;
    // if (json.containsKey('following') ?? false) {
    //   user = new User(
    //     uid: json['_id'],
    //     userName: json['userName'],
    //     name: json['name'],
    //     image: json['image'],
    //     coverImage: json['coverImage'],
    //     bio: json['bio'],
    //     following: json['following'],
    //     likes: json['likes'],
    //   );
    // } else {
    return User(
      uid: json['_id'],
      userName: json['userName'],
      image: json['image'],
      name: json['name'],
    );
    // coverImage: json['coverImage'],
    // bio: json['bio'],
    //   );
    // }
    // return user;
  }
}
