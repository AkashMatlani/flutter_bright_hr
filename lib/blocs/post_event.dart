abstract class PostEvent {}

class LoadPostsEvent extends PostEvent {}

class LoadPostDetailsEvent extends PostEvent {
  final int postId;

  LoadPostDetailsEvent(this.postId);
}
