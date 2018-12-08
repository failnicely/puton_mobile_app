import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:puton/const/color.dart';
import 'package:puton/const/routes.dart';
import 'package:puton/const/style.dart';
import 'package:puton/redux/store/app_state.dart';
import 'package:puton/redux/store/user.dart';
import 'package:puton/widget/shared/app_bar.dart';
import 'package:puton/widget/shared/logo.dart';
import 'package:puton/widget/shared/profile_image.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: EmptyAppBar(color: PColor.white),
        body: StoreConnector<AppState, User>(
          converter: (store) => store.state.user,
          builder: (context, user) =>
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(context),
                  Container(color: PColor.gray5, height: 0.5),
                  _buildProfileImage(context),
                  Container(color: PColor.gray6, height: 0.5),
                  _buildListItem('이름', user.username),
                  Container(color: PColor.gray6, height: 0.5),
                  _buildListItem('사용자 이름', user.userId),
                  Container(color: PColor.gray6, height: 0.5),
                  _buildListItem('웹사이트', ''),
                  Container(color: PColor.gray6, height: 0.5),
                  _buildListItem('소개', 'hello :)'),
                  Container(color: PColor.gray6, height: 0.5),
                  Flexible(flex: 1, child: Container(color: PColor.white)),
                ],
              ),
        ),
      );

  Widget _buildProfileImage(context) =>
      Container(
          color: PColor.white,
          child: Column(
            children: [
              Container(height: 20.0),
              ProfileImage(
                  'https://cdn.pixabay.com/photo/2016/11/16/10/26/girl-1828536__340.jpg',
                  size: 55
              ),
              GestureDetector(
                onTap: () => Scaffold.of(context).showSnackBar(SnackBar(content: Text('준비 중입니다.'))),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('프로필 사진 바꾸기', style: PStyle.primary),
                ),
              ),
              Container(height: 10.0),
            ],
          )
      );

  Widget _buildListItem(String key, String value) =>
      Container(
        height: 45,
        color: PColor.white,
        child: Row(
          children: [
            Container(
              width: 120,
              padding: EdgeInsets.only(left: 14),
              child: Text(key, style: PStyle.normalLight),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(left: 14),
                child: TextFormField(
                  initialValue: value,
                  decoration: InputDecoration.collapsed(
                    hintStyle: PStyle.formHint,
                    hintText: key,
                  ),
                ),
              ),
            ),
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
                child: Center(child: Text('프로필 편집', style: PStyle.appBarTitle))
            ),
            Row(
              children: [
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  minWidth: 0,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text('Cancel', style: PStyle.appBarCancel),
                ),
                Flexible(flex: 1, child: Container()),
                MaterialButton(
                  onPressed: () =>
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('준비 중입니다.'))),
                  //todo: save
                  minWidth: 0,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text('Done', style: PStyle.appBarDone),
                ),
              ],
            ),
          ],
        ),
      );
}
