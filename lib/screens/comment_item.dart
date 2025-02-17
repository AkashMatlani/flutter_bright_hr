import 'package:flutter/material.dart';
import 'package:flutter_bright_hr/models/comment.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;

  const CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(comment.name,
          style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold)),
      subtitle: Text(comment.body,
          style: TextStyle(
            fontFamily: 'Roboto',
          )),
    );
  }
}
