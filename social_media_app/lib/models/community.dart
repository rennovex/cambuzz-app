import 'package:flutter/foundation.dart';

enum ProfileType {
  UserProfile,
  CommunityProfile,
}

class Community {
  final ProfileType profileType = ProfileType.CommunityProfile;
  final String name;
  final String image;
  final String coverImage;
  final num members;
  final num events;

  Community({
    @required this.name,
    @required this.image,
    @required this.coverImage,
    this.members,
    this.events,
  });

  static Community fromJson(Map<String, dynamic> json) {
    Community community;
    if (json.containsKey('members') && json.containsKey('events')) {
      community = new Community(
        name: json['name'],
        image: json['image'],
        coverImage: json['coverImage'],
        members: json['members'],
        events: json['events'],
      );
    } else {
      community = new Community(
        name: json['userName'],
        image: json['image'],
        coverImage: json['coverImage'],
      );
    }

    return community;
  }
}
