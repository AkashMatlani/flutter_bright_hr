import 'package:flutter_bright_hr/models/comment.dart';
import 'package:flutter_bright_hr/models/post.dart';

abstract class PostState {}

class PostInitialState extends PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  final List<Post> posts;

  PostLoadedState({required this.posts});
}

class PostErrorState extends PostState {
  final String? errorMessage;

  PostErrorState({this.errorMessage});
}

class PostDetailsLoadedState extends PostState {
  final Post post;
  final List<Comment> comments;

  PostDetailsLoadedState({required this.post, required this.comments});
}
