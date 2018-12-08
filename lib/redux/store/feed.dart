import 'package:puton/redux/store/post.dart';

class Feed {
  final List<Post> posts;
  final bool isLoading;

  Feed({
    this.posts,
    this.isLoading,
  });

  Feed.init()
      :
        this.posts = [],
        this.isLoading = true;

  Feed copyWith({
    List<Post> posts,
    bool isLoading,
  }) =>
      Feed(
        posts: posts ?? this.posts,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  String toString() {
    return 'Feed{posts: $posts, isLoading: $isLoading}';
  }

}
