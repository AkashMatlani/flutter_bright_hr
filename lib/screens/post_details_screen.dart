import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bright_hr/blocs/offline_post_cubit.dart';
import 'package:flutter_bright_hr/blocs/post_bloc.dart';
import 'package:flutter_bright_hr/blocs/post_event.dart';
import 'package:flutter_bright_hr/blocs/post_state.dart';
import 'package:flutter_bright_hr/screens/comment_item.dart';
import 'package:flutter_bright_hr/utils/constant.dart';
import 'package:go_router/go_router.dart';

class PostDetailsScreen extends StatelessWidget {
  final int postId;

  const PostDetailsScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    context.read<PostBloc>().add(LoadPostDetailsEvent(postId));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            postDetails,
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(
            color: Colors
                .white, // Set the back button (and other icons) color to white
          ),
        ),
        body: StreamBuilder<ConnectivityResult>(
            stream: Connectivity()
                .onConnectivityChanged
                .map((results) => results.first),
            builder: (context, snapshot) {
              return BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  if (state is PostLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is PostDetailsLoadedState) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(state.post.title,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold)),
                          Text(state.post.body,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                              )),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<OfflinePostCubit>()
                                  .saveOfflinePost(state.post, context);
                            },
                            child: Text(saveForOfflineReading,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                )),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.push('/comments/$postId');
                            },
                            child: Text(viewComments),
                          ),
                          Expanded(
                            child: ListView.separated(
                              itemCount: state.comments.length,
                              itemBuilder: (context, index) {
                                return CommentItem(
                                    comment: state.comments[index]);
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider();
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(child: Text(error));
                  }
                },
              );
            }));
  }
}
