import 'package:flutter/material.dart';

class ProfileEvents extends StatelessWidget {
  // const ProfileEvents({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        padding: EdgeInsets.only(
          left: 18,
        ),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (ctx, index) => ProfileEventItem(),
      ),
    );
  }
}

class ProfileEventItem extends StatelessWidget {
  // const ProfileEventItem({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: Image.network(
          'https://images.unsplash.com/photo-1589254066213-a0c9dc853511?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80',
          height: 200,
          width: 166,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
