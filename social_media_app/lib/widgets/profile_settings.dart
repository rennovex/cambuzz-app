import 'package:flutter/material.dart';
import 'package:social_media_app/constants.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Privacy',
                    style: kSubtitleTextStyle.copyWith(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.privacy_tip,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
