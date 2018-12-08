import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:puton/const/color.dart';
import 'package:puton/const/routes.dart';
import 'package:puton/const/style.dart';
import 'package:puton/redux/store/app_state.dart';
import 'package:puton/widget/shared/app_bar.dart';
import 'package:puton/widget/shared/logo.dart';
import 'package:puton/widget/shared/profile_image.dart';

class CommentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: EmptyAppBar(color: PColor.white),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context),
            Container(color: PColor.gray5, height: 0.5),
          ],
        ),
      );

  Widget _buildHeader(context) =>
      Container(
        color: PColor.white,
        height: 45,
        child: Stack(
          children: [
            Container(
                height: 45,
                child: Center(child: Text('comments', style: PStyle.appBarTitle))
            ),
            Row(
              children: [
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  minWidth: 0,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Image.asset('image/icon/arrow_black.png', width: 9, height: 15),
                ),
              ],
            ),
          ],
        ),
      );
}
