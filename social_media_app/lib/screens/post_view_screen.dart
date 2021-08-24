import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/models/comment.dart';
import 'package:social_media_app/providers/api.dart';

import 'package:social_media_app/providers/post.dart';
import 'package:social_media_app/widgets/post_item.dart';

class PostViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Post post = Provider.of<Post>(context, listen: false);

    final future = post.getComments();

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          // extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: kAppBarPrimaryColor,
            brightness: Brightness.dark,
            title: Text('Comments'),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Consumer<Post>(
                        builder: (_, post, __) => PostItem(
                          disableComments: true,
                        ),
                      ),
                      Text('Comments'),
                      Consumer<Post>(
                        builder: (_, post, __) => FutureBuilder(
                            future: future,
                            builder: (_, snapshot) {
                              print(snapshot.connectionState);
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting)
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              else if (snapshot.hasData) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: post.comments?.length ?? 0,
                                  itemBuilder: (ctx, ind) => CommentItem(
                                    Comment.fromJson(post.comments[ind]),
                                  ),
                                );
                              } else
                                return Container();
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              NewComment(post),
            ],
          ),
        ),
      ),
    );
  }
}

class NewComment extends StatefulWidget {
  final Post post;

  NewComment(this.post);
  @override
  _NewCommentState createState() => _NewCommentState();
}

class _NewCommentState extends State<NewComment> {
  TextEditingController textEditingController;
  var enteredText = '';
  FocusNode focusNode;

  void postComment() {
    print(textEditingController.value.text);
    widget.post.postcomment(comment: textEditingController.value.text.trim());
    textEditingController.clear();
    focusNode.unfocus();
  }

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(56, 56, 56, 1)),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: TextField(
        keyboardType: TextInputType.text,
        focusNode: focusNode,
        style: TextStyle(color: Colors.white),
        controller: textEditingController,
        minLines: 1,
        maxLines: 10,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Add a comment ...',
            hintStyle: TextStyle(color: Colors.white),
            suffixIcon: ValueListenableBuilder<TextEditingValue>(
              valueListenable: textEditingController,
              builder: (_, value, child) => IconButton(
                icon: Icon(
                  Icons.send,
                  color:
                      value.text.trim().isEmpty ? Colors.white30 : Colors.white,
                ),
                onPressed:
                    value.text.trim().isEmpty ? null : () => postComment(),
              ),
            )),
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  final Comment comment;

  CommentItem(this.comment);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        boxShadow: [
          new BoxShadow(
            color: Color.fromRGBO(0, 0, 0, .09),
            blurRadius: 14.0,
            offset: Offset.fromDirection(1.57079,4)
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        margin: EdgeInsets.all(8),
        elevation: 0,
        child: ListTile(
          // isThreeLine: true,
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(comment.user.image),
            radius: 22,
          ),
          title: Text(comment.user.userName),
          subtitle: Text(
            '${comment.text}',
            style: kSubtitleTextStyle,
          ),
          trailing: IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) => SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.report_rounded),
                      title: Text('Report'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () async {
                        await Api.postReport(
                            id: comment.id, objectType: 'Comment');
                        Fluttertoast.showToast(msg: 'Reported');
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
