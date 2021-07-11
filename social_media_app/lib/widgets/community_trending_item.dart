import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/providers/post.dart';

import '../constants.dart';

class CommunityTrendingItem extends StatelessWidget {
  // const CommunityTrendingItem({ Key? key }) : super(key: key);
  final Post post;

  // final flag = false;

  CommunityTrendingItem(this.post);

  @override
  Widget build(BuildContext context) {
    print(post.isImagePost());
    return Card(
      color: Color.fromRGBO(73, 73, 73, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
        height: 180,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            post.isImagePost()
                ? SizedBox(
                    width: 10,
                  )
                : SizedBox(width: 20),
            post.isImagePost() ? ImageView(post.postImg) : PostView(post),
            SizedBox(
              width: 10,
            ),
            (post.isImagePost()) ? PostView(post) : PostBody(post.postText),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class PostView extends StatelessWidget {
  final Post post;

  PostView(this.post);

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
              '\$${this.post.community.name}',
              style: kTrendingCommunityName,
            ),
            SizedBox(
                // height: 0.1,
                ),
            Text(
              'by ${this.post.user.name}',
              style: kTrendingCommunityTitle,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              '${this.post.title}',
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
                  '${this.post.likeCount}',
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
        child: CachedNetworkImage(
          imageUrl: '$image',
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
