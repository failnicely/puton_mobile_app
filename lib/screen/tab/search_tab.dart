import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:puton/const/color.dart';
import 'package:puton/const/style.dart';
import 'package:puton/widget/home/post_list.dart';

const test_items = ['test', 'test2', 'test3', 'test4', 'test5'];

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.fit(1),
  const StaggeredTile.fit(1),
  const StaggeredTile.fit(1),
  const StaggeredTile.fit(1),
  const StaggeredTile.fit(1),
  const StaggeredTile.fit(1),
  const StaggeredTile.fit(1),
  const StaggeredTile.fit(1),
  const StaggeredTile.fit(1),
  const StaggeredTile.fit(1),
  const StaggeredTile.fit(1),
];

List<Widget> _tiles = const <Widget>[
  const _Example01Tile('https://cdn.pixabay.com/photo/2016/04/10/21/34/woman-1320810__480.jpg', Icons.widgets, 100),
  const _Example01Tile('https://cdn.pixabay.com/photo/2016/11/16/10/26/girl-1828536__340.jpg', Icons.wifi, 150),
  const _Example01Tile('https://cdn.pixabay.com/photo/2017/08/01/08/29/people-2563491__480.jpg', Icons.panorama_wide_angle, 120),
  const _Example01Tile('https://cdn.pixabay.com/photo/2017/01/14/10/03/fashion-1979136__480.jpg', Icons.map, 80),
  const _Example01Tile('https://cdn.pixabay.com/photo/2016/03/23/08/34/beautiful-1274361__480.jpg', Icons.send, 120),
  const _Example01Tile('https://cdn.pixabay.com/photo/2016/11/29/11/32/beautiful-1869208__480.jpg', Icons.airline_seat_flat, 130),
  const _Example01Tile('https://cdn.pixabay.com/photo/2017/08/01/11/48/blue-2564660__480.jpg', Icons.bluetooth, 140),
  const _Example01Tile('https://cdn.pixabay.com/photo/2015/10/12/14/54/girl-983969__480.jpg', Icons.battery_alert, 200),
  const _Example01Tile('https://cdn.pixabay.com/photo/2015/07/27/20/21/beauty-863439__480.jpg', Icons.desktop_windows, 150),
  const _Example01Tile('https://cdn.pixabay.com/photo/2016/11/29/09/25/beautiful-1868701__480.jpg', Icons.radio, 160),
  const _Example01Tile('https://cdn.pixabay.com/photo/2017/04/16/01/53/girl-2233820__480.jpg', Icons.radio, 165),
];

class _Example01Tile extends StatelessWidget {
  final String imgUrl;
  final IconData iconData;
  final double height;

  const _Example01Tile(this.imgUrl, this.iconData, this.height);


  @override
  Widget build(BuildContext context) =>
      Container(
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.all(0),
        height: this.height,
        child: Card(
          margin: EdgeInsets.all(0),
          elevation: 0,
          child: Container(
              decoration: BoxDecoration(
                color: PColor.gray5,
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(this.imgUrl, fit: BoxFit.cover),
              )
          ),
        ),
      );
}

class SearchTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Builder(
          builder: (context) =>
              Container(
                decoration: BoxDecoration(color: PColor.white),
                child: GestureDetector(
                  onTap: () =>
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('준비 중입니다.'))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildHeader(), //todo: 검색
                      Flexible(child: _build(), flex: 9999),
                    ],
                  ),
                ),
              )
      );

  Widget _buildHeader() =>
      Container(
        height: 28.0,
        margin: EdgeInsets.only(top: 12, right: 16, bottom: 12, left: 16),
        decoration: BoxDecoration(
          color: PColor.gray7,
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
        ),
        child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search, size: 12, color: PColor.gray2),
                Container(width: 3),
                Text('검색', style: PStyle.search),
              ],
            )),
      );

  Widget _build() =>
      StaggeredGridView.count(
        crossAxisCount: 2,
        staggeredTiles: _staggeredTiles,
        children: _tiles,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        padding: EdgeInsets.all(6.0),
      );

}
