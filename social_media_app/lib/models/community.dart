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
  final List members;
  final List events;
  final List followers;

  Community({
    @required this.uid,
    @required this.name,
    @required this.image,
    @required this.coverImage,
    this.owner,
    this.members,
    this.events,
    this.followers,
  });

  factory Community.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('managers') || json.containsKey('events')) {
      return Community(
        uid: json['_id'],
        owner: User.fromJson(json['owner']),
        // owner: json['owner'],
        name: json['name'],
        image: json['image'],
        coverImage: json['coverImage'],
        members: json['members'],
        events: json['events'],
      );
    } else {
      return Community(
        // owner: User.fromJson(json['owner']),
        uid: json['_id'],
        name: json['name'],
        image: json['image'],
        coverImage: json['coverImage'],
      );
    }
  }
}
