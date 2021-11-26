import 'package:flutter/material.dart';
import 'package:vao_ra/shares/shares.dart';

import '../main.dart';

class CustomTheme extends StatelessWidget {
  Widget child;

  CustomTheme({this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appStore.isDarkModeOn
          ? ThemeData.dark().copyWith(
//        accentColor: appColorPrimary,
//        accentColor: itime_main_color,
//        primaryColor: itime_main_color,
//        cardColor: itime_main_color,
//        highlightColor: itime_main_color,
//        splashColor: itime_main_color,
//        backgroundColor: itime_main_color,
        accentColor: appColorPrimary,
        backgroundColor: appStore.scaffoldBackground,
      )
          : ThemeData.light(),
      child: child,
    );
  }
}