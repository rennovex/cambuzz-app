import 'package:flutter/foundation.dart';
import 'package:social_media_app/models/event.dart';
import 'package:social_media_app/models/user.dart';

enum ProfileType {
  UserProfile,
  CommunityProfile,
}

class Community {
  final ProfileType profileType = ProfileType.CommunityProfile;
  final String name;
  final String image;
  final String coverImage;
  final List<User> members;
  final List<Event> events;
  final List<User> followers;

  Community({
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
