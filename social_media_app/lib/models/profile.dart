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
  final int followers;
  final int members;
  final int events;

  Profile({
    @required this.profileType,
    @required this.profileName,
    @required this.profileImg,
    @required this.profileCoverImg,
    @required this.profileBio,
    this.followers,
    this.members,
    this.events,
  });
}
