import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/providers/post.dart';
import 'package:social_media_app/screens/Profiles/community_profile_screen.dart';
import 'package:social_media_app/screens/Profiles/user_profile_screen.dart';
import 'package:social_media_app/screens/post_view_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:social_media_app/widgets/feed_post_action.dart';

class PostItem extends StatelessWidget {
  final bool disableComments;
  // final post = Provider.of<Post>(context);
  //  Post post =

  PostItem({
    this.disableComments = false,
    // @required this.post,
    Key key,
  }) : super(key: key);

  void showUser(context, id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfileScreen(userId: id),
      ),
    );
  }

  void showCommunity(context, id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommunityProfileScreen(uid: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Post>(context, listen: false);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => showUser(context, post.user.uid),
                  child: CircleAvatar(
                    radius: 21,
                    backgroundImage: CachedNetworkImageProvider(
                      post.user?.image ?? '',
                    ),
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
                          GestureDetector(
                            onTap: () {
                              post.isUserPost()
                                  ? showUser(context, post.user.uid)
                                  : showCommunity(context, post.community.uid);
                            },
                            child: Text(
                              post.isUserPost()
                                  ? post.user.name
                                  : '\$' + post.community.name,
                              style: kPostHeaderTextStyle,
                              // textAlign: TextAlign.start,
                            ),
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
                          Icons.more_vert,
                          color: Color.fromRGBO(97, 97, 97, 1),
                          size: 36,
                        ),
                        // splashRadius: 1,
                        onPressed: () => showModalBottomSheet(
                          context: context,
                          builder: (context) => FeedPostAction(
                            post,
                          ),
                        ),
                      ),
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
                onDoubleTap: () => post.toggleLike(),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: CachedNetworkImage(
                    imageUrl: post.postImg,
                    // placeholder: (context, url) =>
                    //     Center(child: CircularProgressIndicator()),
                    width: double.infinity,
                    height: 350,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            if (!post.isImagePost())
              GestureDetector(
                onDoubleTap: () => post.toggleLike(),
                child: Container(
                  child: Text(post.postText),
                ),
              ),
            SizedBox(
              height: 10,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => post.toggleLike(),
                  child: Consumer<Post>(
                    builder: (_, post, __) => Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: post.isLiked
                            ? Colors.red
                            : Color.fromRGBO(235, 237, 236, 1),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                              padding: EdgeInsets.all(0),
                              constraints: BoxConstraints(),
                              icon: post.isLiked
                                  ? Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.favorite,
                                      color: Colors.black,
                                    ),
                              onPressed: () => post.toggleLike()),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5, top: 5, bottom: 5),
                            child: SizedBox(
                              width: 35,
                              child: Text(
                                '${post.likeCount}',
                                style: TextStyle(
                                  color: post.isLiked
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.all(0),
                      constraints: BoxConstraints(),
                      icon: Icon(
                        MdiIcons.comment,
                      ),
                      onPressed: disableComments
                          ? null
                          : () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider.value(
                                            value: post,
                                            child: PostViewScreen())),
                              ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      '${post.commentCount}',
                      style: kPostBottomMetricTextStyle,
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     IconButton(
                //         padding: EdgeInsets.all(0),
                //         constraints: BoxConstraints(),
                //         icon: Icon(MdiIcons.trophyOutline),
                //         onPressed: () {}),
                //     Text(
                //       '3',
                //       style: kPostBottomMetricTextStyle,
                //     ),
                //   ],
                // ),
                // Row(
                //   children: [
                //     IconButton(
                //         padding: EdgeInsets.all(0),
                //         constraints: BoxConstraints(),
                //         icon: Icon(MdiIcons.shareAllOutline),
                //         onPressed: () {}),
                //     Text(
                //       '3',
                //       style: kPostBottomMetricTextStyle,
                //     ),
                //   ],
                // ),
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
