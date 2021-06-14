import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
        SizedBox(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 10),
            Expanded(
              child: RaisedButton(
                // padding: EdgeInsets.symmetric(horizontal: 15),
                onPressed: () {},
                child: Text('+Join'),
                color: Colors.purpleAccent,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: RaisedButton(
                onPressed: () {},
                child: Text('Contact Head'),
                color: Colors.purpleAccent,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: RaisedButton(
                onPressed: () {},
                child: Text('Edit Community'),
                color: Colors.purpleAccent,
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        )
      ],
    ));
  }
}
