import 'package:flutter/material.dart';
import 'package:social_media_app/dummy_data.dart';
import 'package:social_media_app/widgets/app_bar.dart';
import 'package:social_media_app/widgets/community_trending.dart';
import 'package:social_media_app/widgets/user_trending.dart';

class TrendingScreen extends StatefulWidget {
  // const TrendingScreen({ Key? key }) : super(key: key);

  @override
  _TrendingScreenState createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen>
    with AutomaticKeepAliveClientMixin<TrendingScreen> {
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
              CommunityTrending(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
