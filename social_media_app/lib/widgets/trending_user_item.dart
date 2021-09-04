import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/providers/post.dart';
import 'package:social_media_app/screens/post_view_screen.dart';
import 'package:social_media_app/screens/search_screen.dart';

class TrendingUserItem extends StatelessWidget {
  final height;
  final width;
  final Widget ranking;
  final Color borderColor;
  final Post post;

  TrendingUserItem({
    this.post,
    this.ranking,
    this.borderColor,
    this.height,
    this.width,
  });
  // const TrendingUserItem({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('image' + post.postImg);
    // print(post.user.coverImage);
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider.value(
                value: post, child: PostViewScreen())),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ranking,
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: borderColor,
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: '${post.postImg}',
                      fit: BoxFit.cover,
                      width: width,
                      height: height,
                    ),
                  ),
                ),
              ),
              Positioned(
                child: ranking,
                left: 10,
                top: 10,
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(100),
              //     color: Colors.black,
              //   ),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.max,
              //     // mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       SizedBox(
              //         width: 5,
              //       ),
              //       CircleAvatar(
              //         backgroundImage: NetworkImage(
              //           post.user.image,
              //         ),
              //         radius: 14,
              //       ),
              //       SizedBox(
              //         width: 5,
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Text(
              //             post.user.userName,
              //             style: kTrendingUserName,
              //           ),
              //           Text(
              //             post.title,
              //             style: kTrendingUserText,
              //           ),
              //         ],
              //       )
              //     ],
              //   ),
              // ),
              GestureDetector(
                onTap: () => showUser(context, post.user.uid),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5, right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          post.user.image,
                        ),
                        radius: 20,
                      ),
                      Text(
                        post.user.userName,
                        style: kTrendingUserName,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),

          // SizedBox(
          //   height: 10,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Icon(
          //       Icons.favorite_border,
          //       color: Colors.orange,
          //     ),
          //     Text(post.likeCount.toString()),
          //   ],
          // ),
        ],
      ),
    );
  }
}
