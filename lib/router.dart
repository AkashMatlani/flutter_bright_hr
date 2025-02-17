import 'package:flutter_bright_hr/main.dart';
import 'package:flutter_bright_hr/screens/comments_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bright_hr/screens/post_details_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return MainScreen(); // MainScreen as the home screen
      },
    ),
    // PostDetailsScreen route with postId as a parameter
    GoRoute(
      path: '/postDetails/:postId', //  postDetails
      builder: (context, state) {
        final postId = int.parse(state.pathParameters['postId']!);
        return PostDetailsScreen(postId: postId);
      },
    ),
    GoRoute(
      path: '/comments/:postId', // route for CommentsScreen
      builder: (context, state) {
        final postId = int.parse(state.pathParameters['postId']!);
        return CommentsScreen(postId: postId);
      },
    ),
  ],
);
