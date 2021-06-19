import 'package:flutter/material.dart';
import 'package:social_media_app/constants.dart';

class ProfileHeader extends StatelessWidget {
  // const ProfileScreen({ Key? key }) : super(key: key);
  final String coverImg;
  final String profileImg;

  ProfileHeader({
    @required this.profileImg,
    @required this.coverImg,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      // overflow: Overflow.visible,
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 5, right: 11, left: 11, bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(33),
            child: Image.network(
              '$coverImg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 167,
            ),
          ),
        ),
        Positioned(
          // left: 150,
          top: 145,
          child: Container(
            decoration: BoxDecoration(
              gradient: kLinearGradient,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: kProfilePicRadius + 8,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: kProfilePicRadius + 4,
                child: CircleAvatar(
                  radius: kProfilePicRadius,
                  backgroundImage: NetworkImage('$profileImg'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
