import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bright_hr/blocs/post_bloc.dart';
import 'package:flutter_bright_hr/core/network/post_repository.dart';
import 'package:flutter_bright_hr/router.dart';
import 'package:flutter_bright_hr/screens/post_list_screen.dart';
import 'blocs/offline_post_cubit.dart';
import 'models/post.dart';
import 'screens/offline_post_list_screen.dart';
import 'utils/constant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final postRepository = PostRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider<OfflinePostCubit>(
          create: (context) => OfflinePostCubit()..loadOfflinePosts(),
          // Provide the OfflinePostCubit
        ),
        BlocProvider<PostBloc>(
          create: (context) =>
              PostBloc(postRepository: postRepository), // Provide the PostBloc
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
          length: 2, // Two tabs (Original Posts and Offline Posts)
          child: Scaffold(
              body: Column(children: [
            TabBar(
              padding: EdgeInsets.zero,
              tabs: [
                Tab(text: originalPost),
                BlocBuilder<OfflinePostCubit, List<Post>>(
                    builder: (context, offlinePosts) {
                  return Tab(
                    text: offlinePost,
                    icon: Badge(
                      label: Text(
                        offlinePosts.length.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                })
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [PostListScreen(), OfflinePostListScreen()],
              ),
            ),
          ]))),
    );
  }
}
