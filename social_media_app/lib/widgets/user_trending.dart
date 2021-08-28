import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_media_app/providers/post.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/widgets/trending_user_item.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_media_app/constants.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UserTrending extends StatelessWidget {
  // const UserTrending({ Key? key }) : super(key: key);
  final Future<List<Post>> trendingUserPosts = Api.getTrendingUserPosts();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),

      // height: 300,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: kTrendingLinearGradient
          ),
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
                  'Whats trending',
                  style: kTitleTextStyleWhite,
                ),
              ),
              FutureBuilder(
                future: trendingUserPosts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
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
                  else if (snapshot.hasData && snapshot.data.length == 3)
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: TrendingUserItem(
                            height: 250.0,
                            width: double.infinity,
                            borderColor: Color.fromRGBO(255, 245, 0, 1),
                            post: snapshot.data[0],
                            // ranking: Image.asset(
                            //   'images/crown_icon.png',
                            //   scale: 0.5,
                            // ),
                            ranking: FaIcon(
                              FontAwesomeIcons.crown,
                              color: Color.fromRGBO(255, 159, 0, 1),
                              size: 28,
                            ),
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
                                ranking: CircleAvatar(
                                  radius: 15,
                                  child: Text(
                                    '2',
                                    style: kTrendingUserRankingText,
                                  ),
                                  backgroundColor:
                                      Color.fromRGBO(0, 255, 255, 1),
                                ),
                                borderColor: Color.fromRGBO(0, 255, 255, 1),
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
                                ranking: CircleAvatar(
                                  radius: 15,
                                  child: Text(
                                    '3',
                                    style: kTrendingUserRankingText,
                                  ),
                                  backgroundColor:
                                      Color.fromRGBO(255, 122, 0, 1),
                                ),
                                borderColor: Color.fromRGBO(255, 122, 0, 1),
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
                  else
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Center(
                        child: Text('Oops! seems like nothing is trending rn'),
                      ),
                    );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
