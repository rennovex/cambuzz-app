import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/dummy_data.dart';
import 'package:social_media_app/models/post.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/widgets/post_item.dart';
import 'package:social_media_app/widgets/app_bar.dart';

class FeedScreen extends StatefulWidget {
  //const FeedScreen({ Key? key }) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  Future feed;

  @override
  void initState() {
    // TODO: implement initState
    print('feed callled');
    feed = Api.getFeed();
    // print(feed);
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   print('changeDependancy');
  //   feed = Api.getFeed();
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<Api>(context, listen: false);
    feed.then((value) => print(value));
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            CustomAppBar(),
            Column(
              children: [
                SingleChildScrollView(
                  child: FutureBuilder(
                    future: feed,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(snapshot.data);
                        // final snapshot.data = snapshot.data;
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.length,
                            shrinkWrap: true,
                            itemBuilder: (ctx, ind) {
                              return PostItem(post: snapshot.data[ind]);
                            }
                            // Text(snapshot.data[ind]['postImage']),

                            );
                      } else
                        return Center(
                          child: Text('Loading'),
                        );
                    },
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
