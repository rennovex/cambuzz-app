import 'package:flutter/material.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/screens/Profiles/user_profile_screen.dart';
import 'package:social_media_app/screens/promotion_screen.dart';
import 'package:social_media_app/screens/search_screen.dart';

class CustomAppBar extends StatelessWidget {
  final User user;
  CustomAppBar(this.user);
  @override
  Widget build(BuildContext context) {
    return AppBar(
                backgroundColor: Color.fromRGBO(28, 28, 28, 1),
                foregroundColor: Colors.white,
                brightness: Brightness.dark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                leading: IconButton(
                  icon: CircleAvatar(
                    backgroundImage: NetworkImage(
                      user.image,
                    ),
                    radius: 19,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return UserProfileScreen();
                    }));
                  },
                ),
                title: Text('CamBuzz'),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: Icon(Icons.near_me),
                    onPressed: () {},
                  )
                ],
              );
  }
}
