import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String image;
  final double size;

  ProfileImage(this.image, {this.size = 24});

  @override
  Widget build(BuildContext context) =>
      Container(
          width: size,
          height: size,
          decoration: _buildCircleImage()
      );

  BoxDecoration _buildCircleImage() =>
      BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(image),
          )
      );
}
