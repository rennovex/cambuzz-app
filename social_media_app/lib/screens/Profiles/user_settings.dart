import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/Global/globals.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/providers/google_sign_in.dart';
import 'package:social_media_app/screens/Profiles/community_profile_screen.dart';
import 'package:social_media_app/screens/blocked_screen.dart';

class UserSettings extends StatelessWidget {
  Function onLogout;
  UserSettings({
    Key key,
    this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPrivate;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10),
            child: Text(
              'Settings',
              style: kTitleTextStyle,
            ),
          ),

          ListTile(
            leading: Icon(Icons.group),
            title: Text('Communities'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => Navigator.of(context)
                .pushNamed(CommunityProfileScreen.routeName),
          ),
          ListTile(
            leading: Icon(Icons.block),
            title: Text('Blocked'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () =>
                Navigator.of(context).pushNamed(BlockedScreen.routeName),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            trailing: Icon(Icons.close),
            onTap: () async {
              Navigator.of(context).pop();
              onLogout();
              Provider.of<GoogleSignInProvider>(context, listen: false)
                  .logout();
            },
          ),
          // Container(
          //   margin: EdgeInsets.only(
          //     left: 15,
          //     right: 15,
          //   ),
          //   width: double.infinity,
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //         primary: Color.fromRGBO(69, 83, 243, 1)),
          //     onPressed: () {},
          //     child: Text('Logout'),
          //   ),
          // ),
        ],
      ),
    );
  }
}
