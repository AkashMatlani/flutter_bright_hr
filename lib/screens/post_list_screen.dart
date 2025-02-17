import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bright_hr/blocs/post_bloc.dart';
import 'package:flutter_bright_hr/blocs/post_state.dart';
import 'package:flutter_bright_hr/core/network/post_repository.dart';
import 'package:flutter_bright_hr/screens/post_item.dart';
import 'package:flutter_bright_hr/utils/constant.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../blocs/post_event.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream:
          Connectivity().onConnectivityChanged.map((results) => results.first),
      builder: (context, snapshot) {
        bool isConnected = snapshot.hasData &&
            (snapshot.data == ConnectivityResult.mobile ||
                snapshot.data == ConnectivityResult.wifi);

        return BlocProvider(
          create: (_) =>
              PostBloc(postRepository: PostRepository())..add(LoadPostsEvent()),
          child: Scaffold(
            body: Column(
              children: [
                if (!isConnected)
                  Container(
                    width: double.infinity,
                    color: Colors.red,
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      noInternetConnection,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                Expanded(
                  child: BlocBuilder<PostBloc, PostState>(
                    builder: (context, state) {
                      if (state is PostLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is PostLoadedState) {
                        return ListView.separated(
                          itemCount: state.posts.length,
                          itemBuilder: (context, index) {
                            return PostItem(post: state.posts[index]);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider();
                          },
                        );
                      } else if (state is PostErrorState) {
                        return Center(
                          child: Text(
                            state.errorMessage ?? error,
                            style: TextStyle(fontFamily: 'Roboto'),
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text(
                            unknownState,
                            style: TextStyle(fontFamily: 'Roboto'),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
