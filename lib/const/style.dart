import 'package:flutter/material.dart';
import 'package:puton/const/color.dart';

class PStyle {
  static final appBar = TextStyle(color: PColor.black);
  static final appBarTitle = TextStyle(color: PColor.black, fontSize: 15, fontWeight: FontWeight.w500);
  static final appBarCancel = TextStyle(color: PColor.blackText, fontSize: 14);
  static final appBarDone = TextStyle(color: PColor.primary, fontSize: 14);

  static final splashInformation = TextStyle(color: PColor.white, fontSize: 14, fontWeight: FontWeight.w300);

  static final drawerId = TextStyle(color: PColor.blackText, fontSize: 14);
  static final drawerMenu = TextStyle(color: PColor.blackText, fontSize: 14, fontWeight: FontWeight.w300);
  static final drawerLogout = TextStyle(color: PColor.primary, fontSize: 14, fontWeight: FontWeight.w300);
  static final drawerPtn = TextStyle(color: PColor.secondary, fontSize: 10);

  static final username = TextStyle(color: PColor.blackText, fontSize: 12);
  static final nickname = TextStyle(color: PColor.blackText, fontSize: 14, fontWeight: FontWeight.w700);
  static final id = TextStyle(color: PColor.gray2, fontSize: 12);
  static final profile = TextStyle(color: PColor.blackText, fontSize: 12);
  static final follow = TextStyle(color: PColor.purpleText, fontSize: 12);
  static final time = TextStyle(color: PColor.gray2, fontSize: 10);
  static final metaInfo = TextStyle(color: PColor.gray2, fontSize: 10);
  static final content = TextStyle(color: PColor.blackText, fontSize: 12);
  static final search = TextStyle(color: PColor.gray2, fontSize: 12);
  static final count = TextStyle(color: PColor.black, fontSize: 12, fontWeight: FontWeight.w500);
  static final countDescription = TextStyle(color: PColor.gray2, fontSize: 11);
  static final ptn = TextStyle(color: PColor.secondary, fontSize: 12);

  static final normalLight = TextStyle(color: PColor.blackText, fontSize: 14, fontWeight: FontWeight.w300);
  static final normal = TextStyle(color: PColor.blackText, fontSize: 14);
  static final normalWhite = TextStyle(color: PColor.white, fontSize: 14);
  static final bigWhite = TextStyle(color: PColor.white, fontSize: 16, fontWeight: FontWeight.w700);

  static final error = TextStyle(color: PColor.red, fontSize: 14);
  static final formHint = TextStyle(color: PColor.gray4, fontSize: 14);
  static final primary = TextStyle(color: PColor.primary, fontSize: 12, fontWeight: FontWeight.w300);
}