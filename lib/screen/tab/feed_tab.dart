import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:puton/const/color.dart';
import 'package:puton/http/post.dart';
import 'package:puton/redux/reducer/feed.dart';
import 'package:puton/redux/store/app_state.dart';
import 'package:puton/redux/store/feed.dart';
import 'package:puton/redux/store/post.dart';
import 'package:puton/widget/home/post_list.dart';
import 'package:puton/widget/shared/logo.dart';
import 'package:redux/redux.dart';

const test_items = ['test', 'test2', 'test3', 'test4', 'test5'];

class FeedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildHeader(),
          Container(color: PColor.gray5, height: 1.0),
          Flexible(child: _build(), flex: 1),
        ],
      );

  Widget _buildHeader() =>
      Container(
        color: PColor.white,
        height: 45.0,
        child: Center(child: Logo()),
      );

  Widget _build() =>
      StoreConnector<AppState, Feed>(
        onInit: (store) => _initFeed(store),
        converter: (store) => store.state.feed,
        builder: (context, feed) => _buildPostList(feed),
      );

  _buildPostList(feed) =>
      feed.isLoading
          ? _buildLoading()
          : PostListWrapper(feed.posts);

  _buildLoading() =>
      Container(
        padding: EdgeInsets.all(6.0),
        child: Column(
          children: [
            Container(height: 50),
            CircularProgressIndicator(),
          ],
        ),
      );

  _initFeed(Store<AppState> store) async {
    try {
      store.dispatch(ActivateLoadingAction());
      store.dispatch(ClearPostsAction());
      List<Post> posts = await fetchPost();
      print('fetchPost $posts');
      store.dispatch(AddFeedPostsAction(posts));
    } catch (err) {
      print(err);
      throw err;
    } finally {
      store.dispatch(DeactivateLoadingAction());
    }
  }
}
