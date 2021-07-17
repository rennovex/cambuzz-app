import 'package:flutter/material.dart';
import 'package:social_media_app/constants.dart';

enum PostType {
  ImagePost,
  TextPost,
}

class AddPost extends StatefulWidget {
  // const AddPost({Key key}) : super(key: key);
  final BuildContext context;

  AddPost(this.context);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  PostType postType;

  @override
  void initState() {
    super.initState();
    postType = PostType.TextPost;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            child: Text(
              'New Post',
              style: kTitleTextStyle,
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Community Name',
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(6),
                  ),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(6),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 15,
            ),
            child: Text('Post Type'),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      postType = PostType.TextPost;
                    });
                  },
                  child: CustomButton(
                    icon: Icon(
                      Icons.document_scanner_sharp,
                      color: Colors.white,
                    ),
                    label: 'Text Post',
                    selected: postType == PostType.TextPost ? true : false,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      postType = PostType.ImagePost;
                    });
                  },
                  child: CustomButton(
                    icon: Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    label: 'Image Post',
                    selected: postType == PostType.ImagePost ? true : false,
                  ),
                ),
              ),
            ],
          ),
          postType == PostType.TextPost
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(6),
                        ),
                      ),
                    ),
                    maxLines: 8,
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Center(
                    child: InkWell(
                      child: PickImageBtn(),
                      onTap: () {},
                    ),
                  ),
                ),
          Row(
            children: [
              Expanded(
                  child: SizedBox(
                width: 0,
              )),
              Container(
                margin: EdgeInsets.only(right: 15, top: 10),
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(69, 83, 243, 1)),
                  onPressed: () {},
                  child: Text('Post'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PickImageBtn extends StatelessWidget {
  const PickImageBtn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 24,
          ),
        ],
      ),
      child: Text('Pick Image'),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final bool selected;

  Color isSelected() {
    return selected
        ? Color.fromRGBO(141, 38, 221, 1)
        : Color.fromRGBO(135, 135, 135, 1);
  }

  CustomButton({this.icon, this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20, left: 15, right: 15),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: isSelected(),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          icon,
          Text(
            '$label',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(width: 5),
        ],
      ),
    );
  }
}
