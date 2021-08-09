import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/models/comment.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/providers/post.dart';
import 'package:social_media_app/widgets/post_item.dart';

class PostViewScreen extends StatefulWidget {
  @override
  _PostViewScreenState createState() => _PostViewScreenState();
}

class _PostViewScreenState extends State<PostViewScreen> {
  Post post;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<Post>(context, listen: false).getComments();
  }

  @override
  Widget build(BuildContext context) {
    // final future = post.getComments(post.id);

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Consumer<Post>(
                        builder: (_, post, __) => ChangeNotifierProvider.value(
                          value: post,
                          child: PostItem(
                            disableComments: true,
                          ),
                        ),
                      ),
                      Text('Comments'),

                      Consumer<Post>(
                        builder: (_, post, __) => ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: post.comments?.length ?? 0,
                          itemBuilder: (ctx, ind) => CommentItem(
                            Comment.fromJson(post.comments[ind]),
                          ),
                        ),
                      ),

                      // else{
                      //   return
                      // }

                      // FutureBuilder(
                      //     future: _future,
                      //     builder: (_, snapshot) {
                      //       if (snapshot.hasData) {
                      //         return ListView.builder(
                      //           shrinkWrap: true,
                      //           physics: NeverScrollableScrollPhysics(),
                      //           itemCount: snapshot.data?.length ?? 0,
                      //           itemBuilder: (ctx, ind) => CommentItem(
                      //             Comment.fromJson(snapshot.data[ind]),
                      //           ),
                      //         );
                      //       } else
                      //         return Center(
                      //           child: CircularProgressIndicator(),
                      //         );
                      //     }),
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
    widget.post.postcomment(
        id: widget.post.id, comment: textEditingController.value.text.trim());
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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      margin: EdgeInsets.all(8),
      elevation: 3,
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
          onPressed: () {},
        ),
      ),
    );
  }
}
