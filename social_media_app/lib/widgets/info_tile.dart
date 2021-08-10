import 'package:flutter/material.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/screens/Profiles/user_profile_screen.dart';

class InfoTile extends StatelessWidget {
  final User info;
  InfoTile({this.info, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 15,
      ),
      color: Color.fromRGBO(224, 224, 224, 0.88),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListTile(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UserProfileScreen(userId: info.uid),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(info?.image ?? ''),
        ),
        title: Text(info?.userName ?? ''),
        subtitle: Text(info?.name ?? ''),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Color.fromRGBO(98, 65, 234, 1),
          size: 25,
        ),
      ),
    );
  }
}
