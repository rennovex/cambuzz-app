import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_media_app/widgets/trending_user_item.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UserTrending extends StatelessWidget {
  // const UserTrending({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      height: 300,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 8,
              child: TrendingUserItem(
                height: 121.0,
                width: 121.0,
                ranking: Text('2'),
                src:
                    'https://images.unsplash.com/photo-1604537529586-87ac173f4310?ixid=MnwxMjA3fDB8MHxwcm9maWxlLXBhZ2V8MTF8fHxlbnwwfHx8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80',
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 9,
              child: TrendingUserItem(
                height: 145.0,
                width: 140.0,
                ranking: Icon(
                  MdiIcons.crown,
                  size: 30,
                ),
                src:
                    'https://images.unsplash.com/photo-1623852620519-7a476b8d8207?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 8,
              child: TrendingUserItem(
                height: 121.0,
                width: 121.0,
                ranking: Text('3'),
                src:
                    'https://images.unsplash.com/photo-1604537529586-87ac173f4310?ixid=MnwxMjA3fDB8MHxwcm9maWxlLXBhZ2V8MTF8fHxlbnwwfHx8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80',
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
