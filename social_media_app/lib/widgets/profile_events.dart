import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileEvents extends StatelessWidget {
  const ProfileEvents({this.skills, Key key}) : super(key: key);
  final List skills;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        padding: EdgeInsets.only(
          left: 18,
        ),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: skills?.length ?? 3,
        itemBuilder: (ctx, index) =>
            ProfileEventItem(image: skills[index]?.image),
      ),
    );
  }
}

class ProfileEventItem extends StatelessWidget {
  const ProfileEventItem({this.image, Key key}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: CachedNetworkImage(
          imageUrl: image,
          height: 150,
          width: 120,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
