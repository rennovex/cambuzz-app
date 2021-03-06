import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/Global/globals.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/providers/myself.dart';
import 'package:social_media_app/screens/FeedScreen/paged_feed_list_view.dart';
import 'package:social_media_app/widgets/app_bar.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with AutomaticKeepAliveClientMixin<FeedScreen> {
  Future feed;

  @override
  void initState() {
    super.initState();
    Global.setStatusBarColor();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: CustomAppBar(Provider.of<Myself>(context).myself),
          preferredSize: kAppBarPreferredSize,
        ),
        // appBar: AppBar(
        //   leading: IconButton(
        //     icon: Icon(Icons.search),
        //     onPressed: () =>
        //         Navigator.of(context).pushNamed(SearchScreen.routeName),
        //   ),
        //   actions: [
        //     TextButton(
        //       onPressed: () =>
        //           Navigator.pushNamed(context, AddEventsScreen.routeName),
        //       child: Text('Add Event'),
        //     )
        //   ],
        // ),
        body: PagedFeedListView(),
        // body: RefreshIndicator(
        //     onRefresh: () async {
        //       return feed = Api.getFeed().whenComplete(
        //         () => setState(() {}),
        //       );
        //     },
        //     child: SingleChildScrollView(
        //       child: Column(
        //         children: [
        //           CustomAppBar(),
        //           FutureBuilder(
        //             future: feed,
        //             builder: (context, snapshot) {
        //               if (snapshot.hasData) {
        //                 // final snapshot.data = snapshot.data;
        //                 return ListView.builder(
        //                   cacheExtent: 1500,
        //                   itemCount: snapshot.data.length,
        //                   physics: NeverScrollableScrollPhysics(),
        //                   // addAutomaticKeepAlives: true,
        //                   shrinkWrap: true,
        //                   itemBuilder: (ctx, ind) => PostItem(
        //                     post: snapshot.data[ind],
        //                   ),
        //                   // {
        //                   //   return PostItem(post: snapshot.data[ind]);
        //                   // }
        //                   // Text(snapshot.data[ind]['postImage']),
        //                 );
        //               } else
        //                 return Center(
        //                   child: Container(
        //                     child: SpinKitWave(
        //                       color: kPrimaryColor,
        //                     ),
        //                     height: MediaQuery.of(context).size.height * .8,
        //                   ),
        //                 );
        //             },
        //           ),
        //         ],
        //       ),
        //     )),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
