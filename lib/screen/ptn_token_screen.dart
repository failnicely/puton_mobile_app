import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:puton/const/color.dart';
import 'package:puton/const/routes.dart';
import 'package:puton/const/style.dart';
import 'package:puton/redux/store/app_state.dart';
import 'package:puton/widget/shared/app_bar.dart';
import 'package:puton/widget/shared/button.dart';
import 'package:puton/widget/shared/logo.dart';
import 'package:puton/widget/shared/profile_image.dart';

class PtnTokenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: EmptyAppBar(color: PColor.white),
        body: Builder(
          builder: (context) =>
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(context),
                  Container(color: PColor.gray5, height: 0.5),
//            _buildProfileImage(),
//            Container(color: PColor.gray6, height: 0.5),
                  _buildListItem(context, '보유 PTN', ptn: 100),
                  Container(color: PColor.gray6, height: 0.5),
                  _buildListItem(context, '리워드 전 게시물'), //todo: 리워드 전 게시물
                  Container(color: PColor.gray6, height: 0.5),
                  _buildListItem(context, '리워드 완료 게시물'), //todo: 리워드 완료 게시물
                  Container(color: PColor.gray6, height: 0.5),
                  Flexible(flex: 1, child: Container(color: PColor.white)),
                ],
              ),
        ),
      );

  Widget _buildListItem(context, text, {int ptn}) =>
      Material(
          color: PColor.white,
          elevation: 0,
          child: InkWell(
//        onPressed: () => Navigator.popAndPushNamed(context, routeName), //todo: 보유 ptn
            onTap: () => Scaffold.of(context).showSnackBar(SnackBar(content: Text('준비 중입니다!'))),
            child: Column(
              children: [
                Container(
                  height: 45,
                  padding: EdgeInsets.only(left: 14, right: 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(text, style: PStyle.normalLight),
                      Flexible(flex: 1, child: Container()),
                      ptn != null
                          ? _buildPtnAmount(ptn)
                          : Image.asset('image/icon/arrow_gray.png', width: 6, height: 10),
                    ],
                  ),
                ),
              ],
            ),
          )
      );

  Widget _buildPtnAmount(ptn) =>
      Padding(
        padding: EdgeInsets.all(0),
        child: PButton(
            ptn.toString(),
            width: 38,
            height: 22,
            textStyle: PStyle.ptn,
            onPressed: () => null,
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
                child: Center(child: Text('PTN', style: PStyle.appBarTitle))
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
