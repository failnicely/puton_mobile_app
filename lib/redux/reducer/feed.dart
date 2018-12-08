import 'dart:io';

import 'package:puton/redux/store/feed.dart';
import 'package:puton/redux/store/post.dart';
import 'package:redux/redux.dart';

class ClearPostsAction {}

class AddFeedPostsAction {
  final List<Post> posts;

  AddFeedPostsAction(this.posts);
}

class ActivateLoadingAction {}

class DeactivateLoadingAction {}

Feed _clearPosts(Feed feed, ClearPostsAction action) =>
    feed.copyWith(posts: []);

Feed _acdFeedPosts(Feed feed, AddFeedPostsAction action) {
  List<Post> newPosts = [];
  newPosts..addAll(feed.posts);

  for (var newPost in action.posts) {
    if (newPosts.any((p) => p.id == newPost.id)) {
      continue;
    }
    newPosts.add(newPost);
  }

  return feed.copyWith(posts: newPosts);
}

Feed _activateLoading(Feed feed, ActivateLoadingAction action) =>
    feed.copyWith(isLoading: true);

Feed _deactivateLoading(Feed feed, DeactivateLoadingAction action) =>
    feed.copyWith(isLoading: false);


final Reducer<Feed> feedReducer = combineReducers<Feed>([
  TypedReducer<Feed, ClearPostsAction>(_clearPosts),
  TypedReducer<Feed, AddFeedPostsAction>(_acdFeedPosts),
  TypedReducer<Feed, ActivateLoadingAction>(_activateLoading),
  TypedReducer<Feed, DeactivateLoadingAction>(_deactivateLoading),
]);
