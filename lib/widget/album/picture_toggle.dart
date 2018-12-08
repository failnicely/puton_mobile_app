import 'package:flutter/material.dart';
import 'package:puton/const/color.dart';

const BASE_PATH = 'image/icon/pic_';

class PictureToggle extends StatelessWidget {
  final bool isStaggered;
  final Function onPressed;

  const PictureToggle({
    @required this.isStaggered,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) =>
      Material(
          color: PColor.transparent,
          child: InkWell(
            onTap: onPressed,
            splashColor: PColor.gray4,
            highlightColor: PColor.gray5,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: Stack(
              children: [
                _buildBackground(),
                _buildInactiveIcon(),
                _buildActiveIcon(),
              ],
            ),
          )
      );

  Widget _buildBackground() =>
      Opacity(
          opacity: 0.5,
          child: Container(
            width: 60,
            height: 30,
            decoration: BoxDecoration(
              color: PColor.gray8,
              border: Border.all(width: 1, color: PColor.gray5),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Container(),
          ),
      );

  Widget _buildInactiveIcon() =>
      Container(
        margin: EdgeInsets.only(left: this.isStaggered ? 30 : 0),
        width: 30,
        height: 30,
        child: Center(
            child: _buildImage('$BASE_PATH${this.isStaggered ? 'list' : 'staggered'}_gray.png')),
      );

  Widget _buildActiveIcon() =>
      Container(
        margin: EdgeInsets.only(left: this.isStaggered ? 0 : 30),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: PColor.white,
          border: Border.all(width: 1, color: PColor.gray5),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Material(
          color: PColor.transparent,
          child: InkWell(
            onTap: onPressed,
            splashColor: PColor.primary,
            highlightColor: PColor.gray4,
            radius: 10,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: Center(
                child: _buildImage('$BASE_PATH${this.isStaggered ? 'staggered' : 'list'}_black.png')
            ),
          ),
        ),
      );

  Image _buildImage(path) =>
      Image.asset(path, width: 14, height: 14);
}