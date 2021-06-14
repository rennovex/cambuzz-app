import 'package:flutter/material.dart';
import 'package:social_media_app/style.dart';
import 'package:social_media_app/widgets/app_bar.dart';
import 'package:social_media_app/widgets/post_item.dart';

import 'dummy_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // textTheme: TextTheme(
        //   title: TitleTextStyle,
        //   subtitle: SubtitleTextStyle,
        //   body1: BodyprimaryTextStyle,
        //   body2: BodySecondaryTextStyle,
        // )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
