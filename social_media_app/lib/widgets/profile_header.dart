import 'package:flutter/material.dart';
import 'package:social_media_app/constants.dart';

class ProfileHeader extends StatelessWidget {
  // const ProfileScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      // overflow: Overflow.visible,
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 30, right: 11, left: 11, bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              'https://i.pinimg.com/736x/e9/5c/60/e95c60d5a695d14a76bea6470c2540d5.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 167,
            ),
          ),
        ),
        Positioned(
          // left: 150,
          top: 145,
          child: CircleAvatar(
            backgroundColor:Colors.white,
            radius: 50,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 44,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                    'https://i.pinimg.com/236x/b7/1c/5f/b71c5f377615229c2d23c79686400eff.jpg'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
