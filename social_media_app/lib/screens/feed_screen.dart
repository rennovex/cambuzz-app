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
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Api>(context, listen: false);
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            CustomAppBar(),
            Column(
              children: [
                SingleChildScrollView(
                  child: FutureBuilder(
                    future: provider.getFeed(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(snapshot.data);
                        // final snapshot.data = snapshot.data;
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.length,
                            shrinkWrap: true,
                            itemBuilder: (ctx, ind) {
                              return PostItem(
                                postImg: snapshot.data[ind]['postImage'],
                                profileImg:
                                    'https://i.pinimg.com/236x/96/4d/50/964d50b13ddb8011ae44f9fc2521866a.jpg',
                                profileName: snapshot.data[ind]['user']
                                    ['userName'],
                                userName: snapshot.data[ind]['user']['name'],
                                title: snapshot.data[ind]['title'],
                                time: '',
                                postText: '',
                                postType: PostType.ImagePost,
                              );
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
