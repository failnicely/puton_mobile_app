import 'package:flutter/material.dart';
import 'package:puton/const/color.dart';
import 'package:puton/const/style.dart';

class PButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final double radius;
  final Function onPressed;
  final TextStyle textStyle;

  PButton(this.text, {
    this.width = 35,
    this.height = 20,
    this.radius,
    @required this.onPressed,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) =>
      MaterialButton(
        minWidth: width - 5,
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: _buildGradientBorderContainer(),
      );

  Widget _buildGradientBorderContainer() =>
      Container(
          decoration: _buildDecoration(),
          width: width,
          height: height,
          child: Container(
            margin: EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: PColor.white,
            ),
            child: _buildContent(),
          ));

  BoxDecoration _buildDecoration() =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? height / 2),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment
              .bottomRight, // 10% of the width, so there are ten blinds.
          colors: [PColor.secondary, PColor.primary], // whitish to gray
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      );

  Widget _buildContent() =>
      Center(child: Text(text, style: textStyle ?? PStyle.drawerPtn));

}
