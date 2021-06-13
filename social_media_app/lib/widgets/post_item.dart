import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_media_app/models/post.dart';

class PostItem extends StatelessWidget {
  final String profile_img;
  final String profile_name;
  final String user_name;
  final String time;
  final String title;
  final String post_img;
  final String post_text;
  final PostType post_type;

  // PostItem(
  //     {this.imgsrc =
  //         'https://ahseeit.com//king-include/uploads/2021/01/122370488_2409620752667825_9215636083039238392_n-4472762206.jpg',
  //     this.proimgsrc =
  //         'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80'});

  PostItem({
    this.profile_img,
    this.post_img,
    this.profile_name,
    this.time,
    this.title,
    this.user_name,
    this.post_type,
    this.post_text,
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
                  backgroundImage: NetworkImage(profile_img),
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
                            '\$$profile_name',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                            // textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'by $user_name',
                            softWrap: true,
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
                              Text(
                                '7 min ago',
                                softWrap: true,
                              ),
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
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                softWrap: true,
                maxLines: 2,
              ),
            ),
            SizedBox(height: 7),
            if (post_type == PostType.ImagePost)
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Image.network(
                  post_img,
                  width: double.infinity,
                  height: 350,
                  fit: BoxFit.cover,
                ),
              ),
            if (post_type == PostType.TextPost)
              Container(
                child: Text(post_text),
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
                    Text('102'),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        padding: EdgeInsets.all(0),
                        constraints: BoxConstraints(),
                        icon: Icon(MdiIcons.commentTextMultipleOutline),
                        onPressed: () {}),
                    Text('46'),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        padding: EdgeInsets.all(0),
                        constraints: BoxConstraints(),
                        icon: Icon(MdiIcons.trophyOutline),
                        onPressed: () {}),
                    Text('3'),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        padding: EdgeInsets.all(0),
                        constraints: BoxConstraints(),
                        icon: Icon(MdiIcons.shareAllOutline),
                        onPressed: () {}),
                    Text('3'),
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
