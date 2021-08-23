import 'package:flutter/foundation.dart';
import 'package:social_media_app/models/event.dart';
import 'package:social_media_app/models/user.dart';

import 'http_helper.dart';

enum ProfileType {
  UserProfile,
  CommunityProfile,
}

class Community with ChangeNotifier {
  final ProfileType profileType = ProfileType.CommunityProfile;
  final String uid;
  final User owner;
  final String name;
  final String image;
  final String coverImage;
  int membersCount;
  final int eventsCount;
  bool isMember;
  bool isOwner;
  bool isSociety;
  bool isManager;

  Community(
      {@required this.uid,
      @required this.name,
      @required this.image,
      @required this.coverImage,
      this.owner,
      this.membersCount,
      this.eventsCount,
      this.isMember,
      this.isManager,
      this.isSociety = false,
      this.isOwner});

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
        isMember: json['isMember'],
        isOwner: json['isOwner'],
        isManager: json['isManager'],
        isSociety: json['isSociety']);
  }

  void toggleJoin() async {
    final oldStatus = isMember;
    final oldCount = membersCount;

    isMember = !isMember;
    isMember ? membersCount++ : membersCount--;
    print(isMember);
    print(membersCount);
    notifyListeners();
    final response = isMember
        ? await HttpHelper.post(
            uri: '/communities/join/${this.uid}',
            body: {},
          )
        : await HttpHelper.delete(
            uri: '/communities/join/${this.uid}',
            body: {},
          );
    if (response.statusCode != 200) {
      isMember = oldStatus;
      membersCount = oldCount;
      notifyListeners();
      throw 'Cant toggle membership in communities ${response.body} of post ${this.uid}';
    }
  }
}
