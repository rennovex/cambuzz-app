
import 'package:flutter/foundation.dart';
import 'package:social_media_app/models/skill.dart';

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
  List<Skill> skills;
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

  static List properties = ['_id', 'userName', 'name', 'image', 'coverImage','bio','followingCount', 'followersCount', 'likeCount','isFollowing', 'skills'];
  static List abstractProperties = ['_id', 'userName', 'name', 'image'];

  static bool isUserPropertiesValid(Map <String, dynamic> json, List<String> properties){
    print('testing');
    for(String i in properties){
      print('test $i');
      if(!json.keys.contains(i)){

        return false;
      }
      print('pass $i');

    }
    return true;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    List<Skill> skills = [];
    for(var i in json['skills']){
      skills.add(Skill.fromJson(i));
    }

    //if(!isUserPropertiesValid(json, properties)) throw 'User Properties invalid';

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
      skills: skills,
      isAbstract: false,
    );
  }

  factory User.fromJsonMyProfile(Map<String, dynamic> json) {
    List<Skill> skills = [];
    for(var i in json['skills']){
      skills.add(Skill.fromJson(i));
    }

    //if(!isUserPropertiesValid(json, properties)) throw 'User Properties invalid';
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
      skills: skills,
      isAbstract: false,
    );
  }

  factory User.fromJsonAbstract(Map<String, dynamic> json) {

    //if(!isUserPropertiesValid(json, abstractProperties)) throw 'User Properties invalid';


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
