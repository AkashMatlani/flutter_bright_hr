import 'package:flutter_bright_hr/core/network/api_helper.dart';
import 'package:flutter_bright_hr/models/comment.dart';
import 'package:flutter_bright_hr/models/post.dart';

class PostRepository {
  ApiHelper apiHelper = ApiHelper();

  // Fetch all posts
  Future<List<Post>> fetchPosts() async {
    return await apiHelper.fetchPosts();
  }

  // Fetch details of a specific post
  Future<Post> fetchPostDetails(int postId) async {
    return await apiHelper.fetchPostDetails(postId);
  }

  // Fetch comments for a specific post
  Future<List<Comment>> fetchComments(int postId) async {
    return await apiHelper.fetchComments(postId);
  }
}
