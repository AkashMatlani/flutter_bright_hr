import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bright_hr/blocs/post_bloc.dart';
import 'package:flutter_bright_hr/blocs/post_event.dart';
import 'package:flutter_bright_hr/blocs/post_state.dart';
import 'package:flutter_bright_hr/core/network/post_repository.dart';
import 'package:flutter_bright_hr/utils/constant.dart';

class CommentsScreen extends StatelessWidget {
  final int postId;

  const CommentsScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            comments,
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        body: StreamBuilder<ConnectivityResult>(
            stream: Connectivity()
                .onConnectivityChanged
                .map((results) => results.first),
            builder: (context, snapshot) {
              return BlocProvider(
                create: (context) => PostBloc(postRepository: PostRepository())
                  ..add(LoadPostDetailsEvent(postId)),
                child: BlocBuilder<PostBloc, PostState>(
                  builder: (context, state) {
                    if (state is PostLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is PostDetailsLoadedState) {
                      final comments = state.comments;
                      if (comments.isEmpty) {
                        return Center(
                            child: Text(noCommentsAvailable,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                )));
                      }
                      return ListView.separated(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final comment = comments[index];
                          return ListTile(
                            title: Text(comment.name,
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(comment.body,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                )),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                      );
                    } else if (state is PostErrorState) {
                      return Center(
                          child: Text(state.errorMessage!,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                              )));
                    } else {
                      return Center(
                          child: Text(noCommentsAvailable,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                              )));
                    }
                  },
                ),
              );
            }));
  }
}
