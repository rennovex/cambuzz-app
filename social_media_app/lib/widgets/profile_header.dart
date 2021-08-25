import 'package:cached_network_image/cached_network_image.dart';
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
    final size = MediaQuery.of(context).size;
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
            child: CachedNetworkImage(
              imageUrl: '$coverImg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: size.height * 0.25,
            ),
          ),
        ),
        Positioned(
          // left: 150,
          top: size.height * 0.2,
          child: Container(
            decoration: BoxDecoration(
              gradient: kLinearGradient,
              shape: BoxShape.circle,
              boxShadow: [
                new BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, .09),
                    blurRadius: 10.0,
                    offset: Offset.fromDirection(1.57079, 4)),
              ],
            ),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: kProfilePicRadius + 8,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: kProfilePicRadius + 4,
                child: CircleAvatar(
                  radius: kProfilePicRadius,
                  backgroundImage: CachedNetworkImageProvider(
                    '$profileImg',
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
