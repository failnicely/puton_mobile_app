import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:puton/const/color.dart';
import 'package:puton/db/db_helper.dart';
import 'package:puton/http/personal.dart';
import 'package:puton/redux/reducer/index.dart';
import 'package:puton/redux/reducer/personal.dart';
import 'package:puton/redux/store/app_state.dart';
import 'package:puton/redux/store/personal.dart';
import 'package:puton/redux/store/post.dart';
import 'package:puton/widget/album/header.dart';
import 'package:puton/widget/shared/example_tile.dart';
import 'package:redux/redux.dart';

class MyTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) =>
      Container(
        decoration: BoxDecoration(color: PColor.white),
        child: StoreConnector<AppState, Personal>(
          onInit: (store) => _init(store),
          converter: (store) => store.state.personal,
          builder: (context, personal) => _build(personal),
        ),
      );

  Widget _build(Personal personal) =>
      personal.isLoading
          ? _buildLoading()
          : personal.isStaggered
          ? _buildGrid(personal.tiles)
          : _buildList(personal.tiles);

  Widget _buildGrid(List<Post> tiles) =>
      StaggeredGridView.count(
        crossAxisCount: 3,
        staggeredTiles: _buildStaggeredTiles(tiles.length),
        children: _buildTiles(tiles),
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
        padding: EdgeInsets.all(6.0),
      );

  Widget _buildList(List<Post> tiles) =>
      ListView.builder(
          itemCount: tiles.length + 1,
          itemBuilder: (BuildContext context, int i) =>
              Padding(
                padding: EdgeInsets.all(6.0),
                child: i == 0
                    ? _buildAlbumHeader()
                    : Tile(tiles[i - 1].image, 200),
              )
      );

  Widget _buildLoading() =>
      Container(
        padding: EdgeInsets.all(6.0),
        child: Column(
          children: [
            _buildAlbumHeader(),
            Container(height: 50),
            CircularProgressIndicator(),
          ],
        ),
      );

  List<StaggeredTile> _buildStaggeredTiles(tileLength) =>
      [StaggeredTile.fit(3)]..addAll(List.generate(tileLength, (i) => StaggeredTile.fit(1)));

  List<Widget> _buildTiles(List<Post> tiles) =>
      [_buildAlbumHeader()]..addAll(tiles.map((p) => Tile(p.image, (Random().nextInt(160) + 80).toDouble())));

  Widget _buildAlbumHeader() =>
      StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) =>
            AlbumHeader(
              isStaggered: state.personal.isStaggered,
              onTogglePressed: () => store.dispatch(ToggleStaggeredAction()),
              onSettingPressed: () => Scaffold.of(context).openEndDrawer(),
              username: state.user.username,
              id: '@${state.user.userId}',
              description: 'Hello :)',
              postCount: state.personal.tiles.length,
              followerCount: 121, // todo: from user state
              followingCount: 33, // todo: from user state
            ),
      );

  _init(Store<AppState> store) async {
    _listTiles(store);

  }

  _listTiles(Store<AppState> store) async {
    try {
      store.dispatch(ActivateLoadingAction());
      store.dispatch(ClearTilesAction());
      final user = (await DBHelper().getUsers())[0];
      final username = user.username;
      List<Post> tiles = await fetchPostByUser(username);
      store.dispatch(AddTilesAction(tiles));
    } catch (err) {
      print (err);
      throw err;
    } finally {
      store.dispatch(DeactivateLoadingAction());
    }
  }
}