import 'package:flutter/material.dart';
import 'package:social_media_app/dummy_data.dart';
import 'package:social_media_app/widgets/post_item.dart';
import 'package:social_media_app/widgets/app_bar.dart';

class FeedScreen extends StatelessWidget {
  //const FeedScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            CustomAppBar(),
            Column(
              children: [
                SingleChildScrollView(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: feed.length,
                    shrinkWrap: true,
                    itemBuilder: (ctx, ind) => PostItem(
                      postImg: feed[ind].postImg,
                      profileImg: feed[ind].profileImg,
                      profileName: feed[ind].profileName,
                      userName: feed[ind].userName,
                      title: feed[ind].title,
                      time: feed[ind].time,
                      postText: feed[ind].postText,
                      postType: feed[ind].postType,
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
