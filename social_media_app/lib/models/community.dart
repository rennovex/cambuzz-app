import 'package:flutter/foundation.dart';
import 'package:social_media_app/models/event.dart';
import 'package:social_media_app/models/user.dart';

enum ProfileType {
  UserProfile,
  CommunityProfile,
}

class Community {
  final ProfileType profileType = ProfileType.CommunityProfile;
  final String uid;
  final User owner;
  final String name;
  final String image;
  final String coverImage;
  final int membersCount;
  final int eventsCount;
  bool isMember;

  Community({
    @required this.uid,
    @required this.name,
    @required this.image,
    @required this.coverImage,
    this.owner,
    this.membersCount,
    this.eventsCount,
    this.isMember
  });

  factory Community.fromJsonAbstract(Map<String, dynamic> json) {
    return Community(
        uid: json['_id'],
        name: json['name'],
        image: json['image'],
        coverImage: json['coverImage']);
  }

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
      uid: json['_id'],
      owner: User.fromJsonAbstract(json['owner']),
      // owner: json['owner'],
      name: json['name'],
      image: json['image'],
      coverImage: json['coverImage'],
      membersCount: json['membersCount'],
      eventsCount: json['eventsCount'],
      isMember: json['isMember']
    );
  }
}
