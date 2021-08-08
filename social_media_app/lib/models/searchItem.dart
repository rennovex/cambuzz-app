import 'package:social_media_app/models/community.dart';
import 'package:social_media_app/models/user.dart';

enum ProfileType {
  UserProfile,
  CommunityProfile,
}

class SearchItem {
  final ProfileType profileType;
  final User user;
  final Community community;

  isUser() => profileType == ProfileType.UserProfile ? true : false;

  SearchItem({this.community, this.user, this.profileType});

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('userName'))
      return SearchItem(
        profileType: ProfileType.UserProfile,
        user: User.fromJson(json),
      );
    else
      return SearchItem(
        profileType: ProfileType.CommunityProfile,
        community: Community.fromJson(json),
      );
  }
}
