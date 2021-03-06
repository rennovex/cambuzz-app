import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/Global/globals.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/providers/myself.dart';
import 'package:social_media_app/widgets/app_bar.dart';
import 'package:social_media_app/widgets/community_trending.dart';
import 'package:social_media_app/widgets/user_trending.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({Key key}) : super(key: key);

  @override
  _TrendingScreenState createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  //var user;
  @override
  void initState() {
    super.initState();
    Global.setStatusBarColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(Provider.of<Myself>(context).myself),
        preferredSize: kAppBarPreferredSize,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 1)).then(
              (value) => setState(() {}),
            );
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                UserTrending(),
                CommunityTrending(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
