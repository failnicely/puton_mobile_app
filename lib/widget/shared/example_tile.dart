import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:puton/const/color.dart';

class Tile extends StatelessWidget {
  final Uint8List image;
  final double height;

  const Tile(this.image, this.height);


  @override
  Widget build(BuildContext context) =>
      Container(
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.all(0),
        height: this.height,
        child: _buildCard(context),
      );

  Widget _buildCard(context) =>
      Material(
        color: PColor.gray6,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        child: InkWell(
          onTap: () => Scaffold.of(context).showSnackBar(SnackBar(content: Text('준비 중입니다.'))),
          splashColor: PColor.white,
          highlightColor: PColor.primary,
          child: Card(
            margin: EdgeInsets.all(0),
            elevation: 0,
            child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.memory(this.image, fit: BoxFit.cover),
                )
            ),
          ),
        ),
      );
}