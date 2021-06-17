import 'package:flutter/foundation.dart';

enum ProfileType {
  UserProfile,
  CommunityProfile,
}

class Profile {
  final ProfileType profileType;
  final String profileName;
  final String profileImg;
  final String profileCoverImg;
  final String profileBio;
  final num followers;
  final num likes;
  final num members;
  final num events;
  final num achievements;

  Profile({
    @required this.profileType,
    @required this.profileName,
    @required this.profileImg,
    @required this.profileCoverImg,
    @required this.profileBio,
    this.followers,
    this.likes,
    this.achievements,
    this.members,
    this.events,
  });
}
