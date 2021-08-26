import 'package:flutter/material.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/providers/post.dart';
import 'package:social_media_app/widgets/community_trending_item.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_media_app/constants.dart';

class CommunityTrending extends StatelessWidget {
  // const CommunityTrending({ Key? key }) : super(key: key);
  Future<List<Post>> trendingPosts;

  CommunityTrending();

  @override
  Widget build(BuildContext context) {
    trendingPosts = Api.getTrendingCommunityPosts();

    return Container(
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 10),
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
                style: kTitleTextStyle,

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                  future: trendingPosts,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data.length > 0) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) =>
                            CommunityTrendingItem(snapshot.data[index]),
                        itemCount: snapshot.data.length,
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: Container(
                          child: SpinKitWave(
                            color: kPrimaryColor,
                          ),
                          height: MediaQuery.of(context).size.height * .8,
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Center(
                          child:
                              Text('Oops! seems like nothing is trending rn'),
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
