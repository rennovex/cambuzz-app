import 'package:flutter/material.dart';
import 'package:social_media_app/style.dart';
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
      appBar: AppBar(
        title: Text('Social Media App'),
      ),
      body: ListView.builder(
        itemCount: feed.length,
        itemBuilder: (ctx, index) => PostItem(
          post_img: feed[index].post_img,
          profile_img: feed[index].profile_img,
          profile_name: feed[index].profile_name,
          user_name: feed[index].user_name,
          title: feed[index].title,
          time: feed[index].time,
          post_type: feed[index].post_type,
          post_text: feed[index].post_text,
        ),
      ),
    );
  }
}
