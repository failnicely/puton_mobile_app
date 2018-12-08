import 'package:flutter/material.dart';
import 'package:puton/const/color.dart';

class Heart extends StatelessWidget {
  final Function onPressed;
  final bool isActive;

  Heart({
    this.onPressed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) =>
      Opacity(
        opacity: 0.8,
        child: Padding(
          padding: EdgeInsets.only(top: 6, right: 18),
          child: Container(
              width: 28,
              height: 28,
              decoration: _buildDecoration(),
              child: Material(
                  color: PColor.transparent,
                  child: InkWell(
                    onTap: onPressed,
                    splashColor: PColor.red,
                    highlightColor: PColor.red,
                    borderRadius: BorderRadius.all(Radius.circular(14.0)),
                    child: _buildHeartImage(),
                  )
              )
          ),
        ),
      );

  BoxDecoration _buildDecoration() =>
      BoxDecoration(
        color: PColor.white,
        borderRadius: BorderRadius.all(Radius.circular(14.0)),
      );

  Widget _buildHeartImage() =>
      Padding(
        padding: EdgeInsets.all(6),
        child: Image.asset(
          'image/icon/heart_${isActive ? 'active' : 'inactive'}.png',
          width: 16,
          height: 16,
        ),
      );
}