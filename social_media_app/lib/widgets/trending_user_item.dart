import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/providers/post.dart';

class TrendingUserItem extends StatelessWidget {
  final height;
  final width;
  final Widget ranking;
  final Post post;

  TrendingUserItem({
    this.post,
    this.ranking,
    this.height,
    this.width,
  });
  // const TrendingUserItem({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('image' + post.postImg);
    // print(post.user.coverImage);
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ranking,
        SizedBox(
          // height: height,
          // width: width,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: '${post.postImg}',
                  fit: BoxFit.cover,
                  width: width,
                  height: height,
                ),
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
              Padding(
                padding: const EdgeInsets.only(bottom: 5, right: 5),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        post.user.image,
                      ),
                      radius: 20,
                    ),
                    Text(
                      post.user.userName,
                      style: kTitleTextStyle.copyWith(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        shadows: <Shadow>[
                          Shadow(
                            blurRadius: 5.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
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
    );
  }
}
