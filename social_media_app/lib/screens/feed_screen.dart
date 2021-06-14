import 'package:flutter/material.dart';
import 'package:social_media_app/dummy_data.dart';
import 'package:social_media_app/widgets/post_item.dart';
import 'package:social_media_app/widgets/app_bar.dart';

class FeedScreen extends StatelessWidget {
  //const FeedScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:SingleChildScrollView(
        child: Column(children: [
          CustomAppBar(),
          Column(
            
            children: feed
                .map((e) => PostItem(
                      postImg: e.postImg,
                      profileImg: e.profileImg,
                      profileName: e.profileName,
                      userName: e.userName,
                      title: e.title,
                      time: e.time,
                      postText: e.postText,
                      postType: e.postType,
                    ))
                .toList(),
          ),
        ]),
      ),
    );
  }
}