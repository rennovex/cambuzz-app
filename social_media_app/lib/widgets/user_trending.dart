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
    Size size = MediaQuery.of(context).size;
    trendingUserPosts = Api.getTrendingUserPosts();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      // height: 300,
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
            // print(snapshot.data);
            else
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: TrendingUserItem(
                      height: 250.0,
                      width: double.infinity,
                      post: snapshot.data[0],
                      ranking: Text('1'),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TrendingUserItem(
                          height: 200.0,
                          width: double.infinity,
                          post: snapshot.data[1],
                          ranking: Text('2'),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TrendingUserItem(
                          height: 200.0,
                          width: double.infinity,
                          post: snapshot.data[2],
                          ranking: Text('3'),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
          },
        ),
      ),
    );
  }
}
