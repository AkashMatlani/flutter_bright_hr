import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bright_hr/core/network/post_repository.dart';

import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc({required this.postRepository}) : super(PostInitialState()) {
    on<LoadPostsEvent>(_onLoadPosts);
    on<LoadPostDetailsEvent>(_onLoadPostDetails);
  }

  void _onLoadPosts(LoadPostsEvent event, Emitter<PostState> emit) async {
    try {
      emit(PostLoadingState());
      final posts = await postRepository.fetchPosts();
      emit(PostLoadedState(posts: posts));
    } catch (e) {
      emit(PostErrorState(errorMessage: e.toString()));
    }
  }

  void _onLoadPostDetails(
      LoadPostDetailsEvent event, Emitter<PostState> emit) async {
    try {
      emit(PostLoadingState());
      final post = await postRepository.fetchPostDetails(event.postId);
      final comments = await postRepository.fetchComments(event.postId);
      emit(PostDetailsLoadedState(post: post, comments: comments));
    } catch (e) {
      emit(PostErrorState(errorMessage: e.toString()));
    }
  }
}
