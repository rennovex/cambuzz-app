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
  final bool disableNavigation;
  final Function refresh;
  // final post = Provider.of<Post>(context);
  //  Post post =

  PostItem({
    this.disableComments = false,
    this.disableNavigation = false,
    this.refresh,
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
    return Container(
      decoration: new BoxDecoration(
        boxShadow: [
          new BoxShadow(
              color: Color.fromRGBO(0, 0, 0, .09),
              blurRadius: 14.0,
              offset: Offset.fromDirection(1.57079, 4)),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.all(15),
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              color: kPostItemHeaderColor,

              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => disableNavigation
                          ? null
                          : post.isUserPost()
                              ? showUser(context, post.user.uid)
                              : showCommunity(context, post.community.uid),
                      child: CircleAvatar(
                        radius: 21,
                        backgroundImage: CachedNetworkImageProvider(
                          post.isUserPost()
                              ? post.user.image
                              : post.community.image,
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
                                onTap: () => disableNavigation
                                    ? null
                                    : post.isUserPost()
                                        ? showUser(context, post.user.uid)
                                        : showCommunity(
                                            context, post.community.uid),
                                child: Text(
                                  post.isUserPost()
                                      ? post.user.name
                                      : '\$' + post.community.name,
                                  style: kPostHeaderTextStyle,
                                  // textAlign: TextAlign.start,
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => disableNavigation
                                        ? null
                                        : showUser(context, post.user.uid),
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                      ),
                                      child: Text(
                                        post.user.userName,
                                        overflow: TextOverflow.ellipsis,
                                        style: kPostSubHeaderTextStyle,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time_sharp,
                                        size: 14,
                                        color:Colors.white,
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
                              color: Color.fromRGBO(255, 255, 255, 1),
                              size: 30,
                            ),
                            // splashRadius: 1,
                            onPressed: () => showModalBottomSheet(
                              context: context,
                              builder: (context) => FeedPostAction(
                                post: post,
                                refresh: refresh,
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
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,),
              child: Container(
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
            ),
            SizedBox(height: 10),
            if (post.isImagePost())
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,),
                child: GestureDetector(
                  onDoubleTap: () => post.toggleLike(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    // TODO
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
              ),
            if (!post.isImagePost())
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,),
                child: GestureDetector(
                  onDoubleTap: () => post.toggleLike(),
                  child: Container(
                    child: Text(post.postText),
                  ),
                ),
              ),
            SizedBox(
              height: 10,
            ),
            if (!post.isImagePost())
              Divider(
                thickness: 1,
              ),
            if (!post.isImagePost())
              SizedBox(
                height: 10,
              ),

            Padding(
              padding: const EdgeInsets.only(right: 10,left: 10, bottom: 12),
              child: Consumer<Post>(
                builder: (_, post, __) => Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => post.toggleLike(),
                      child: Container(
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

                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: disableComments
                          ? null
                          : () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider.value(
                                            value: post,
                                            child: PostViewScreen())),
                              ),
                      child: Row(
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
                                          child: PostViewScreen(),
                                        ),
                                      ),
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
              ),
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
