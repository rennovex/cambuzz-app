import 'package:flutter/material.dart';
import 'package:social_media_app/providers/post.dart';

import '../constants.dart';

class CommunityTrendingItem extends StatelessWidget {
  // const CommunityTrendingItem({ Key? key }) : super(key: key);
  final String communityName;
  final String userName;
  final String title;
  final String image;
  final String text;
  final num likeCount;

  // final flag = false;

  CommunityTrendingItem({
    this.communityName,
    this.userName,
    this.image,
    this.title,
    this.likeCount,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(73, 73, 73, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
        height: 180,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /*
            postType == PostType.ImagePost
                ? SizedBox(
                    width: 10,
                  )
                : SizedBox(width: 20),
            postType == PostType.ImagePost
                ? ImageView(image)
                : PostView(
                    communityName: communityName,
                    likeCount: likeCount,
                    title: title,
                    userName: userName,
                  ),
            SizedBox(
              width: 10,
            ),
            postType == PostType.ImagePost
                ? PostView(
                    communityName: communityName,
                    likeCount: likeCount,
                    title: title,
                    userName: userName,
                  )
                : PostBody(text),
            SizedBox(
              width: 10,
            ),*/
          ],
        ),
      ),
    );
  }
}

class PostView extends StatelessWidget {
  final String communityName;
  final String userName;
  final String title;
  final num likeCount;

  PostView({
    @required this.communityName,
    @required this.userName,
    @required this.likeCount,
    @required this.title,
  });

  // const PostView({
  //   Key key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // alignment: Alignment.centerLeft,
        // transformAlignment: CrossAxisAlignment.start,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '\$${communityName}',
              style: kTrendingCommunityName,
            ),
            SizedBox(
                // height: 0.1,
                ),
            Text(
              'by ${userName}',
              style: kTrendingCommunityTitle,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              '${title}',
              style: kTrendingCommunityBody,
              // softWrap: true,
              overflow: TextOverflow.clip,
              // textAlign: TextAlign.start,
              // maxLines: 3,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  '${likeCount}',
                  style: kTrendingCommunityLikes,
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Ink(
              height: 30,
              width: 130,
              decoration: BoxDecoration(
                gradient: kButtonLinearGradient,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  '+Join Community',
                  textAlign: TextAlign.center,
                  style: kTrendingJoinButton,
                ),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ImageView extends StatelessWidget {
  final String image;

  // const ImageView({
  //   Key key,
  // }) : super(key: key);

  ImageView(this.image);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.network(
          '${image}',
          width: 145,
          height: 155,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class PostBody extends StatelessWidget {
  final String text;

  PostBody(this.text);

  // const PostBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Text(
          '${text}',
          style: kTrendingCommunityContent,
        ),
      ),
    );
  }
}
