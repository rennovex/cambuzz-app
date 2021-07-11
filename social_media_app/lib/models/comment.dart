import 'package:social_media_app/models/user.dart';

class Comment {
  final String id;
  final User user;
  final String text;

  Comment({this.id, this.user, this.text});

  factory Comment.fromJson(comment) {
    return Comment(
      id: comment['_id'],
      user: User.fromJson(comment['user']),
      text: comment['text'],
    );
  }
}
