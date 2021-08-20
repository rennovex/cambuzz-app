import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/Global/globals.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/providers/myself.dart';
import 'package:social_media_app/providers/post.dart';

class FeedPostAction extends StatelessWidget {
  // const FeedPostAction({Post post, Key key}) : super(key: key);
  final Post post;

  FeedPostAction(this.post);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(left: 15, bottom: 10),
          //   child: Text(
          //     '',
          //     style: kTitleTextStyle,
          //   ),
          // ),

          ListTile(
            leading: Icon(Icons.report_rounded),
            title: Text('Report'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () async {
              await Api.postReport(id: post.id, objectType: 'Post');
              Navigator.of(context).pop();
              Fluttertoast.showToast(msg: 'Reported');
            },
          ),
          if (post.user.uid != Provider.of<Myself>(context).myself.uid)
            ListTile(
              leading: Icon(Icons.block),
              title: Text('Block'),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              onTap: () async {
                await Api.block(post.user.uid);
                Navigator.of(context).pop();
                Fluttertoast.showToast(msg: '${post.user.userName} blocked');
              },
            ),

          // Container(
          //   margin: EdgeInsets.only(
          //     left: 15,
          //     right: 15,
          //   ),
          //   width: double.infinity,
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //         primary: Color.fromRGBO(69, 83, 243, 1)),
          //     onPressed: () {},
          //     child: Text('Logout'),
          //   ),
          // ),
        ],
      ),
    );
  }
}
