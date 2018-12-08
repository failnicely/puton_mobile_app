import 'package:flutter/material.dart';
import 'package:puton/const/color.dart';
import 'package:puton/widget/shared/app_bar.dart';
import 'package:puton/widget/home/post_list.dart';
import 'package:puton/widget/shared/logo.dart';
import 'package:puton/widget/tab_bar.dart';

const test_items = ['test', 'test2', 'test3', 'test4', 'test5'];

class NotificationTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildHeader(),
          Container(color: PColor.gray5, height: 1.0),
          Flexible(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Text('준비 중입니다'),
              ),
              flex: 999
          ),
//          _buildTabs(),
        ],
      );

  Widget _buildHeader() =>
      Container(
        color: PColor.gray8,
        height: 45.0,
        child: Center(child: Logo()),
      );

//  Widget _buildTabs() => CustomTabBar(0);

}
