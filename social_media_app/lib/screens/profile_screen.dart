import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/models/profile.dart';
import 'package:social_media_app/widgets/profile_events.dart';
import 'package:social_media_app/widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  final Profile profile;

  ProfileScreen({this.profile});
  // const ProfileScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileHeader(
            coverImg: profile.profileCoverImg,
            profileImg: profile.profileImg,
          ),
          SizedBox(
            height: 50,
          ),
          Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${profile.profileName}',
                style: kProfileName,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 200,
                child: Text(
                  '${profile.profileBio}',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  Text(
                    '${profile.followers} Followers',
                    style: kProfileLabel,
                  ),
                ],
              ),
              Row(
                children: [
                  if (profile.profileType == ProfileType.CommunityProfile)
                    Icon(
                      Icons.wallet_membership_outlined,
                      color: Colors.red,
                    ),
                  if (profile.profileType == ProfileType.UserProfile)
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  if (profile.profileType == ProfileType.CommunityProfile)
                    Text(
                      '${profile.members} Members',
                      style: kProfileLabel,
                    ),
                  if (profile.profileType == ProfileType.UserProfile)
                    Text(
                      '${profile.likes} Likes',
                      style: kProfileLabel,
                    ),
                ],
              ),
              Row(
                children: [
                  if (profile.profileType == ProfileType.CommunityProfile)
                    Icon(
                      MdiIcons.medal,
                      color: Colors.purpleAccent,
                    ),
                  if (profile.profileType == ProfileType.UserProfile)
                    Icon(
                      MdiIcons.medal,
                      color: Colors.purpleAccent,
                    ),
                  if (profile.profileType == ProfileType.CommunityProfile)
                    Text(
                      '${profile.events} Events',
                      style: kProfileLabel,
                    ),
                  if (profile.profileType == ProfileType.UserProfile)
                    Text(
                      '${profile.achievements} Achievements',
                      style: kProfileLabel,
                    ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 22,
          ),
          Row(
            children: [
              SizedBox(width: 15),
              Expanded(
                child: Ink(
                  height: 38,
                  decoration: BoxDecoration(
                    gradient: kButtonLinearGradient,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      profile.profileType == ProfileType.CommunityProfile
                          ? '+Join'
                          : 'Follow',
                      textAlign: TextAlign.center,
                      style: kProfileButtonText,
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    profile.profileType == ProfileType.CommunityProfile
                        ? 'Contact Head'
                        : 'Send a message',
                    textAlign: TextAlign.center,
                    style: kProfileButtonText,
                  ),
                  // color: Colors.purpleAccent,
                  style: OutlinedButton.styleFrom(
                    primary: Color.fromRGBO(225, 37, 255, 1),
                    backgroundColor: Colors.transparent,
                    side: BorderSide(
                      width: 1.3,
                      color: Color.fromRGBO(225, 37, 255, 1),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    profile.profileType == ProfileType.CommunityProfile
                        ? 'Edit Community'
                        : 'Edit Profile',
                    textAlign: TextAlign.center,
                    style: kProfileButtonText,
                  ),
                  style: OutlinedButton.styleFrom(
                    primary: Color.fromRGBO(40, 102, 253, 1),
                    backgroundColor: Colors.transparent,
                    side: BorderSide(
                      width: 1.3,
                      color: Color.fromRGBO(40, 102, 253, 1),
                    ),
                  ),

                  // color: Colors.purpleAccent,
                ),
              ),
              SizedBox(width: 15),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                'Events',
                style: kProfileTitle,
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          ProfileEvents(),
        ],
      ),
    ));
  }
}
