import 'package:flutter/material.dart';
import 'package:social_media_app/models/skill.dart';

class ProfileEvents extends StatelessWidget {
  // const ProfileEvents({ Key? key }) : super(key: key);
  final List skills;

  ProfileEvents({this.skills});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        padding: EdgeInsets.only(
          left: 18,
        ),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: skills?.length ?? 3,
        itemBuilder: (ctx, index) => ProfileEventItem(skills[index]?.image),
      ),
    );
  }
}

class ProfileEventItem extends StatelessWidget {
  // const ProfileEventItem({ Key? key }) : super(key: key);
  final String image;

  ProfileEventItem(this.image);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: Image.network(
          image,
          height: 140,
          width: 140,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
