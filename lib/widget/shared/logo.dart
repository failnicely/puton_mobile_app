import 'package:flutter/material.dart';

enum LogoSize {
  SMALL, NORMAL, BIG,
}

enum LogoColor {
  NORMAL, WHITE,
}

class Logo extends StatelessWidget {
  final LogoSize size;
  final LogoColor logoColor;

  Logo({
    this.size = LogoSize.SMALL,
    this.logoColor = LogoColor.NORMAL,
  });

  @override
  Widget build(BuildContext context) {
    final multiplier = size == LogoSize.BIG ? 2.4 : size == LogoSize.NORMAL ? 2 : 1;

    return Image.asset(
      'image/logo/${logoColor == LogoColor.WHITE ? 'puton_logo_white.png' : 'puton_logo.png'}',
      width: 54.0 * multiplier,
      height: 20.0 * multiplier,
    );
  }
}
