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
    this.members,
    this.events,
    this.followers,
  });

  static Community fromJson(Map<String, dynamic> json) {
    Community community;
    if (json.containsKey('members') && json.containsKey('events')) {
      community = new Community(
        uid: json['_id'],
        name: json['name'],
        image: json['image'],
        coverImage: json['coverImage'],
        members: json['members'],
        events: json['events'],
      );
    } else {
      community = new Community(
        uid: json['_id'],
        name: json['name'],
        image: json['image'],
        coverImage: json['coverImage'],
      );
    }

    return community;
  }
}
