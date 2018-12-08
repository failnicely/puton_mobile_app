import 'package:flutter/material.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color color;

  EmptyAppBar({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(color: this.color));
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}
