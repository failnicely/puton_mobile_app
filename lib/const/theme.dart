import 'package:flutter/material.dart';
import 'package:puton/const/color.dart';

class PTheme {
  static get theme {
    return ThemeData.light().copyWith(
      primaryColor: PColor.white,
//        accentColor: Colors.cyan[300],
//        buttonColor: Colors.grey[800],
//        textSelectionColor: Colors.cyan[100],
//        backgroundColor: Colors.grey[800],
//        textTheme: originalTextTheme.copyWith(
//            body1: originalBody1.copyWith(decorationColor: Colors.transparent)
//        )
    );
  }
}
