import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bright_hr/models/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfflinePostCubit extends Cubit<List<Post>> {
  OfflinePostCubit() : super([]);

  // Save the post for offline reading
  Future<void> saveOfflinePost(Post post, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> offlinePosts = prefs.getStringList('offline_posts') ?? [];

    // Check if the post already exists
    bool postExists = offlinePosts.any((savedPost) {
      Map<String, dynamic> decodedPost = jsonDecode(savedPost);
      return decodedPost['id'] == post.id;
    });

    if (postExists) {
      Future.delayed(Duration.zero, () {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('This post is already saved for offline reading!')),
          );
        }
      });
      return;
    }

    // Convert the post to JSON and save it
    String postJson = jsonEncode({
      'id': post.id,
      'title': post.title,
      'body': post.body,
    });

    offlinePosts.add(postJson);
    await prefs.setStringList('offline_posts', offlinePosts);

    // Reload posts to update UI
    loadOfflinePosts();

    // Show success message safely
    Future.delayed(Duration.zero, () {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Post saved for offline reading!')),
        );
      }
    });
  }

  // Load all the offline posts
  Future<void> loadOfflinePosts() async {
    final prefs = await SharedPreferences.getInstance();

    // Get the list of saved posts (as JSON strings)
    List<String> offlinePostsJson = prefs.getStringList('offline_posts') ?? [];

    // Convert each JSON string back to a Post object and emit the updated list
    try {
      List<Post> offlinePosts = offlinePostsJson.map((jsonStr) {
        final Map<String, dynamic> postMap = jsonDecode(jsonStr);
        return Post(
          id: postMap['id'],
          title: postMap['title'],
          body: postMap['body'],
        );
      }).toList();

      // Emit the list of posts to update the UI
      emit(offlinePosts);
    } catch (e) {
      // If any error occurs during decoding, emit an empty list
      emit([]);
      if (kDebugMode) {
        print('Error loading posts: $e');
      }
    }
  }
}
