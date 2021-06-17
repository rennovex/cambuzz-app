import 'package:flutter/material.dart';
import 'package:social_media_app/models/trending_post.dart';
import 'package:social_media_app/widgets/community_trending_item.dart';

class CommunityTrending extends StatelessWidget {
  // const CommunityTrending({ Key? key }) : super(key: key);
  final List<TrendingPost> trending;

  CommunityTrending(this.trending);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                top: 20,
                bottom: 12,
              ),
              child: Text(
                'Top community posts',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, index) => CommunityTrendingItem(
                  communityName: trending[index].communityName,
                  userName: trending[index].userName,
                  image: trending[index].image,
                  likeCount: trending[index].likeCount,
                  postType: trending[index].postType,
                  text: trending[index].text,
                  title: trending[index].title,
                ),
                itemCount: trending.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
