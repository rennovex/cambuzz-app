import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_media_app/providers/post.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/widgets/trending_user_item.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_media_app/constants.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UserTrending extends StatelessWidget {
  // const UserTrending({ Key? key }) : super(key: key);
  Future<List<Post>> trendingUserPosts;

  @override
  Widget build(BuildContext context) {
    trendingUserPosts = Api.getTrendingUserPosts();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      height: 300,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: FutureBuilder(
          future: trendingUserPosts,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Container(
                  child: SpinKitWave(
                    color: kPrimaryColor,
                  ),
                  height: MediaQuery.of(context).size.height * .8,
                ),
              );
            }
            return Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 8,
                  child: TrendingUserItem(
                    height: 121.0,
                    width: 121.0,
                    ranking: Text('2'),
                    post: snapshot.data[1],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 9,
                  child: TrendingUserItem(
                    height: 145.0,
                    width: 140.0,
                    ranking: Icon(
                      MdiIcons.crown,
                      size: 30,
                    ),
                    post: snapshot.data[0],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 8,
                  child: TrendingUserItem(
                    height: 121.0,
                    width: 121.0,
                    ranking: Text('3'),
                    post: snapshot.data[2],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
