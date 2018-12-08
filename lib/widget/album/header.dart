import 'package:flutter/material.dart';
import 'package:puton/const/style.dart';
import 'package:puton/widget/album/picture_toggle.dart';
import 'package:puton/widget/shared/profile_image.dart';

class AlbumHeader extends StatelessWidget {
  final bool isStaggered;
  final Function onTogglePressed;
  final Function onSettingPressed;
  final String username;
  final String id;
  final String description;
  final int postCount;
  final int followerCount;
  final int followingCount;

  AlbumHeader({
    @required this.isStaggered,
    this.onTogglePressed,
    this.onSettingPressed,
    this.username,
    this.id,
    this.description,
    this.postCount,
    this.followerCount,
    this.followingCount,
  });

  @override
  Widget build(BuildContext context) =>
      SizedBox(
        child: Container(
          margin: EdgeInsets.only(top: 6, right: 6, bottom: 12, left: 16),
          child: Center(child: _build(context)),
        ),
      );

  Widget _build(context) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIcons(),
          _buildProfile(),
          _buildProfileText(),
          _buildCountsAndToggle(),
        ],
      );

  Widget _buildIcons() =>
      Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [_buildSettingIcon()]
      );

  Widget _buildProfile() =>
      Row(
          children: [
            _buildProfileImage(),
            _buildIdAndUsername(),
          ]
      );

  Widget _buildCountsAndToggle() =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildCounts(),
          _buildPictureToggle(),
        ],
      );

  Widget _buildSettingIcon() =>
      MaterialButton(
        minWidth: 30,
        padding: EdgeInsets.all(6),
        onPressed: onSettingPressed,
        child: Image.asset('image/icon/setting.png', width: 22, height: 22),
      );

  Widget _buildProfileImage() =>
      ProfileImage('https://cdn.pixabay.com/photo/2016/11/16/10/26/girl-1828536__340.jpg', size: 55);

  Widget _buildIdAndUsername() =>
      Container(
        margin: EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(username ?? '', style: PStyle.nickname),
            Container(height: 5),
            Text(id ?? '', style: PStyle.id),
          ],
        ),
      );

  Widget _buildProfileText() =>
      Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: Text(description ?? '', style: PStyle.profile),
      );

  Widget _buildCounts() =>
      Row(
        children: [
          Text(formatCount(postCount) ?? 0, style: PStyle.count),
          Container(width: 5),
          Text('Posts', style: PStyle.countDescription),
          Container(width: 13),
          Text(formatCount(followerCount) ?? 0, style: PStyle.count),
          Container(width: 5),
          Text('Followers', style: PStyle.countDescription),
          Container(width: 13),
          Text(formatCount(followingCount) ?? 0, style: PStyle.count),
          Container(width: 5),
          Text('Followings', style: PStyle.countDescription),
        ],
      );

  String formatCount(int number) =>
      number == null
          ? 0
          : number >= 1000 * 1000 * 1000
          ? '${(number / 1000 * 1000 * 1000 * 10).floor() / 10}T'
          : number >= 1000 * 1000
          ? '${(number / 1000 * 1000 * 10).floor() / 10}M'
          : number >= 1000
          ? '${(number / 1000 * 10).floor() / 10}K'
          : number.toString();

  Widget _buildPictureToggle() =>
      PictureToggle(
          isStaggered: isStaggered,
          onPressed: onTogglePressed,
      );
}
