import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:puton/const/color.dart';
import 'package:puton/const/routes.dart';
import 'package:puton/const/style.dart';
import 'package:puton/redux/store/post.dart';
import 'package:puton/widget/home/heart.dart';
import 'package:puton/widget/shared/profile_image.dart';

class PostListWrapper extends StatelessWidget {
  final List<Post> items;

  PostListWrapper(this.items);

  @override
  Widget build(BuildContext context) =>
      Container(
        color: PColor.white,
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, i) => _buildItem(context, i)
        ),
      );

  Widget _buildItem(context, i) =>
      Material(
        color: PColor.transparent,
        child: InkWell(
          onTap: () =>
              Scaffold.of(context).showSnackBar(SnackBar(content: Text('준비 중입니다.'))), // todo: Navigator.pushNamed(context, Routes.COMMENTS),
          child: Padding(
            padding: EdgeInsets.all(0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildListItemHead(
                    context,
                    image: 'https://cdn.pixabay.com/photo/2016/11/16/10/26/girl-1828536__340.jpg',
                    username: items[i].author,
                  ),
                  _buildImages(context, items[i].image),
                  Padding(
                    padding: EdgeInsets.only(top: 10, right: 14, left: 14),
                    child: Text(items[i].content, style: PStyle.content),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6, right: 14, left: 14, bottom: 12),
                    child: Text(
                      '좋아요 ${items[i].likeCount}개 ∙ 댓글 ${items[i].comments.length}개',
                      style: PStyle.metaInfo,
                    ),
                  ),
                ]
            ),
          ),
        ),
      );


  Widget _buildListItemHead(context, {image, username}) =>
      Padding(
          padding: EdgeInsets.only(top: 12, right: 12, bottom: 8, left: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: <Widget>[
                  ProfileImage(image),
                  Container(width: 6.0),
                  Text(username, style: PStyle.username),
                  Container(width: 5.0),
                  Text('∙', style: PStyle.username),
                  InkWell(
                      onTap: () =>
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text('준비 중입니다.'))),
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text('follow', style: PStyle.follow)
                      )
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('1시간 전 (2일 3시간 남음)', style: PStyle.time),
//                  Container(width: 10.0),
                  InkWell(
                      onTap: () =>
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text('준비 중입니다.'))),
                      child: Padding(
                        padding: EdgeInsets.only(top: 5, right: 1, bottom: 5, left: 9.0),
                        child: Image.asset('image/icon/more.png', width: 14.0, height: 14.0),
                      )
                  )
                ],
              ),
            ],
          )
      );

  Widget _buildImages(context, Uint8List image) =>
      Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          SizedBox(
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 1,
                  itemBuilder: (context, i) => _buildImageWrapper(context, i, image)
              )
          ),
          Heart(
            onPressed: () => Scaffold.of(context).showSnackBar(SnackBar(content: Text('준비 중입니다.'))),
            isActive: true,
          ),
        ],
      );

  Widget _buildImageWrapper(context, i, image) {
    double width = MediaQuery.of(context).size.width;
    double leftPadding = i == 0 ? 12.0 : 0.0;
    double rightPadding = i == 4 ? 12.0 : 5.0; //todo: is last
    EdgeInsets edgeInsets = EdgeInsets.only(left: leftPadding, right: rightPadding);

    return Padding(
      padding: edgeInsets,
      child: ClipRRect(borderRadius: BorderRadius.circular(4), child: _buildImage(width, image)),
    );
  }

  Image _buildImage(width, image) =>
      Image.memory(
        image,
        fit: BoxFit.cover,
        width: width - 24,
        height: 200,
      );
}

