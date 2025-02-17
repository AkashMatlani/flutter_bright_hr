import 'package:flutter/material.dart';
import 'package:flutter_bright_hr/models/post.dart';
import 'package:go_router/go_router.dart';

class PostItem extends StatelessWidget {
  final Post post;

  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        post.title,
        style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w600),
      ),
      subtitle: Text(post.body,
          style: TextStyle(
            fontFamily: 'Roboto',
          )),
      onTap: () {
        context.push('/postDetails/${post.id}');
      },
    );
  }
}
