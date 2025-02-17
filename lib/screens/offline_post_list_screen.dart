import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bright_hr/blocs/offline_post_cubit.dart';
import 'package:flutter_bright_hr/models/post.dart';
import 'package:flutter_bright_hr/utils/constant.dart';
import 'package:go_router/go_router.dart';

class OfflinePostListScreen extends StatelessWidget {
  const OfflinePostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OfflinePostCubit()..loadOfflinePosts(),
      child: Scaffold(
        body: BlocBuilder<OfflinePostCubit, List<Post>>(
          builder: (context, offlinePosts) {
            if (offlinePosts.isEmpty) {
              return Center(child: Text(noPostSaved));
            }
            return ListView.separated(
              itemCount: offlinePosts.length,
              itemBuilder: (context, index) {
                final post = offlinePosts[index];
                return ListTile(
                  title: Text(post.title,
                      style: TextStyle(
                          fontFamily: 'Roboto', fontWeight: FontWeight.bold)),
                  subtitle: Text(post.body,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                      )),
                  onTap: () {
                    // Navigate to comments screen for the selected post
                    context.push('/comments/${post.id}');
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            );
          },
        ),
      ),
    );
  }
}
