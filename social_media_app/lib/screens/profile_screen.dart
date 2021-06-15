import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/widgets/profile_events.dart';
import 'package:social_media_app/widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  // const ProfileScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ProfileHeader(),
        SizedBox(
          height: 50,
        ),
        Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Profile Name'),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 200,
              child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry ',
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
                Text('80 Followers'),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.wallet_membership_outlined,
                  color: Colors.red,
                ),
                Text('50 Member'),
              ],
            ),
            Row(
              children: [
                Icon(
                  MdiIcons.medal,
                  color: Colors.purpleAccent,
                ),
                Text('3 Events'),
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
                  gradient: kLinearGradient,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    '+Join',
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
                  'Contact Head',
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
                  'Edit Community',
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
    ));
  }
}
