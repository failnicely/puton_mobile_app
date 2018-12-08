import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:puton/const/color.dart';
import 'package:puton/const/routes.dart';


const BASE_PATH = 'image/tab';

class CustomTabBar extends StatelessWidget {
  final int current;
  final Function onClickTab;

  CustomTabBar({this.current, this.onClickTab});

  @override
  Widget build(BuildContext context) =>
      Container(
        color: PColor.white,
        height: 52.0,
        child: Column(
          children: [
            Container(color: PColor.gray5, height: 1.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _buildTabs(context),
            ),
          ],
        ),
      );

  List<Widget> _buildTabs(context) =>
      [
        Container(width: 15),
        _buildTab(0, this.current == 0 ? 'home_active' : 'home_disabled'),
        _buildTab(1, this.current == 1 ? 'search_active' : 'search_disabled'),
        _buildTab(2, this.current == 2 ? 'upload_disabled' : 'upload_disabled', context: context),
        _buildTab(3, this.current == 3 ? 'notification_disabled' : 'notification_disabled'), //todo: notification_active
        _buildTab(4, this.current == 4 ? 'mypage_active' : 'mypage_disabled'),
        Container(width: 15),
      ];

  Widget _buildTab(position, path, {context}) =>
      Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Container(
            height: 51,
            child: _buildTabImage(
                path: path,
                onTab: () => position == 2
                    ? Navigator.pushNamed(context, Routes.UPLOAD_POST)
                    : this.onClickTab(position),
            ),
          )
      );

  Widget _buildTabImage({path, onTab}) =>
      MaterialButton(
        minWidth: 10.0,
        padding: EdgeInsets.only(top: 10, right: 0, bottom: 14, left: 0),
          onPressed: onTab,
          child: Image.asset('$BASE_PATH/$path.png', width: 52, height: 52),
      );
}
