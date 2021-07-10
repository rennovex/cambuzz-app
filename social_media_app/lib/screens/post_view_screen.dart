import 'package:flutter/material.dart';
import 'package:social_media_app/providers/post.dart';
import 'package:social_media_app/widgets/post_item.dart';

class PostViewScreen extends StatelessWidget {
  // static const routeName = '/post-view';

  // const PostViewScreen({ Key? key }) : super(key: key);

  // final List<>

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              /*PostItem(
                postImg:
                    'https://i.pinimg.com/236x/0c/17/ca/0c17ca0e82e873d6b0bd5a44790c7813.jpg',
                profileImg:
                    'https://i.pinimg.com/236x/c8/c3/0f/c8c30f07d1084ca16a74f3a1757d7b26.jpg',
                title:
                    'There are many variations of passages of Lorem Ipsum available,',
                profileName: 'The Art Base',
                userName: 'BadKarma',
                time: '',
                postType: PostType.ImagePost,
              ),*/
              Text('Comments'),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (ctx, ind) => Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  margin: EdgeInsets.all(8),
                  elevation: 3,
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    isThreeLine: true,
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1530653535919-df7cc2bee192?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NjJ8fHByb2ZpbGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
                      radius: 22,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ashfin Nannase'),
                        // Text('7 min ago'),
                      ],
                    ),
                    subtitle: Text('😊'),
                    trailing: IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
