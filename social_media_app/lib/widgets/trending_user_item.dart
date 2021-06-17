import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_media_app/constants.dart';

class TrendingUserItem extends StatelessWidget {
  final height;
  final width;
  final Widget ranking;
  final String src;

  TrendingUserItem({
    this.ranking,
    this.src,
    this.height,
    this.width,
  });
  // const TrendingUserItem({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ranking,
        SizedBox(
          // height: height,
          // width: width,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  '$src',
                  fit: BoxFit.cover,
                  width: width,
                  height: height,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1610451915828-7cc4782b3850?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxOHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
                      ),
                      radius: 14,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Ashfin Nannase',
                          style: kTrendingUserName,
                        ),
                        Text(
                          'Photography',
                          style: kTrendingUserText,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              color: Colors.orange,
            ),
            Text('40'),
          ],
        ),
      ],
    );
  }
}
