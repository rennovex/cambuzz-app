import 'package:flutter/material.dart';
import 'package:social_media_app/dummy_data.dart';
import 'package:social_media_app/widgets/app_bar.dart';
import 'package:social_media_app/widgets/community_trending.dart';
import 'package:social_media_app/widgets/user_trending.dart';

class TrendingScreen extends StatelessWidget {
  // const TrendingScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(),
              UserTrending(),
              //CommunityTrending(trending),
            ],
          ),
        ),
      ),
    );
  }
}
