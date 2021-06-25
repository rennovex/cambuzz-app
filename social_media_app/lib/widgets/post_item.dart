import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/models/post.dart';
import 'package:social_media_app/screens/post_view_screen.dart';

class PostItem extends StatelessWidget {
  final String profileImg;
  final String profileName;
  final String userName;
  final String time;
  final String title;
  final String postImg;
  final String postText;
  final PostType postType;

  // PostItem(
  //     {this.imgsrc =
  //         'https://ahseeit.com//king-include/uploads/2021/01/122370488_2409620752667825_9215636083039238392_n-4472762206.jpg',
  //     this.proimgsrc =
  //         'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80'});

  PostItem({
    this.profileImg,
    this.postImg,
    this.profileName,
    this.time,
    this.title,
    this.userName,
    this.postType,
    this.postText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(profileImg),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$$profileName',
                            style: kPostHeaderTextStyle,
                            // textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 150,
                            child: Text(
                              '$userName',
                              overflow: TextOverflow.ellipsis,
                              style: kPostSubHeaderTextStyle,
                              // maxLines: 1,
                              // softWrap: true,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 22),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_sharp,
                                size: 18,
                              ),
                              Text('7 min ago',
                                  softWrap: true, style: kPostTimeTextStyle),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // SizedBox(width: 10),
                IconButton(
                    padding: EdgeInsets.all(0),
                    constraints: BoxConstraints(),
                    icon: Icon(
                      Icons.more_vert,
                      size: 36,
                    ),
                    // splashRadius: 1,
                    onPressed: () {}),
              ],
            ),
            SizedBox(height: 15),
            Container(
              // width: 300,
              child: Text(
                '$title',
                overflow: TextOverflow.ellipsis,
                style: kPostTitleTextStyle,
                // softWrap: true,
                maxLines: 2,
              ),
            ),
            SizedBox(height: 7),
            if (postType == PostType.ImagePost)
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Image.network(
                  postImg,
                  width: double.infinity,
                  height: 350,
                  fit: BoxFit.cover,
                ),
              ),
            if (postType == PostType.TextPost)
              Container(
                child: Text(postText),
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
                        icon: Icon(Icons.favorite_border),
                        onPressed: () {}),
                    Text('102', style: kPostBottomMetricTextStyle),
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
                            builder: (context) => PostViewScreen()),
                      ),
                    ),
                    Text(
                      '46',
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
          ],
        ),
      ),
    );
  }
}
