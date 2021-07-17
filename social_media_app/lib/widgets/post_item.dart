import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/providers/post.dart';
import 'package:social_media_app/models/profile.dart';
import 'package:social_media_app/screens/post_view_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Post>(context);
    print(post.isLiked);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 23,
                  backgroundImage: CachedNetworkImageProvider(
                    post.user.image,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.isUserPost()
                                ? post.user.name
                                : '\$' + post.community.name,
                            style: kPostHeaderTextStyle,
                            // textAlign: TextAlign.start,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  post.user.userName,
                                  overflow: TextOverflow.ellipsis,
                                  style: kPostSubHeaderTextStyle,
                                  // maxLines: 1,
                                  // softWrap: true,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time_sharp,
                                    size: 18,
                                  ),
                                  Text(post.howLongAgo,
                                      softWrap: true,
                                      style: kPostTimeTextStyle),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      IconButton(
                          padding: EdgeInsets.only(right: 15),
                          constraints: BoxConstraints(),
                          icon: Icon(
                            Icons.more_horiz,
                            size: 36,
                          ),
                          // splashRadius: 1,
                          onPressed: () {}),
                    ],
                  ),
                ),

                //
                // SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 15),
            Container(
              // width: 300,
              child: Text(
                post.title,
                overflow: TextOverflow.ellipsis,
                style: kPostTitleTextStyle,
                // softWrap: true,
                maxLines: 2,
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 7),
            if (post.isImagePost())
              GestureDetector(
                onDoubleTap: () => post.toggleLike(post.id),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: CachedNetworkImage(
                    imageUrl: post.postImg,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    width: double.infinity,
                    height: 350,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            if (!post.isImagePost())
              Container(
                child: Text(post.postText),
              ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    IconButton(
                        padding: EdgeInsets.all(0),
                        constraints: BoxConstraints(),
                        icon: post.isLiked
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(Icons.favorite_border),
                        onPressed: () => post.toggleLike(post.id)),
                    Text('${post.likeCount}',
                        style: kPostBottomMetricTextStyle),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.all(0),
                      constraints: BoxConstraints(),
                      icon: Icon(MdiIcons.commentTextMultipleOutline),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostViewScreen(post)),
                      ),
                    ),
                    Text(
                      '${post.commentCount}',
                      style: kPostBottomMetricTextStyle,
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        padding: EdgeInsets.all(0),
                        constraints: BoxConstraints(),
                        icon: Icon(MdiIcons.trophyOutline),
                        onPressed: () {}),
                    Text(
                      '3',
                      style: kPostBottomMetricTextStyle,
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        padding: EdgeInsets.all(0),
                        constraints: BoxConstraints(),
                        icon: Icon(MdiIcons.shareAllOutline),
                        onPressed: () {}),
                    Text(
                      '3',
                      style: kPostBottomMetricTextStyle,
                    ),
                  ],
                ),
              ],
            ),
            // SizedBox(
            //   height: 10,
            // ),
            // Row(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(left: 8.0),
            //       child: SizedBox(
            //         width: 300,
            //         child: Text(
            //           post.title,
            //           overflow: TextOverflow.ellipsis,
            //           style: kPostTitleTextStyle,
            //           // softWrap: true,
            //           maxLines: 2,
            //           textAlign: TextAlign.start,
            //         ),
            //       ),
            //     ),
            //     Container(
            //       decoration: BoxDecoration(
            //         color: Colors.grey,
            //         shape: BoxShape.rectangle,
            //         borderRadius: BorderRadius.circular(30),
            //       ),
            //       child: Text('More'),
            //     ),
          ],
        ),
      ),
    );
  }
}
