import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

callNext(var className, var context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => className),
  );
}

back(var context) {
  // Navigator.pop(context);
  ExtendedNavigator.of(context).pop();
}

void finish(context) {
  // Navigator.pop(context);
  ExtendedNavigator.of(context).pop();
}

void hideKeyboard(context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

launchScreen(context, String tag, {Object arguments}) {
  if (arguments == null) {
    // Navigator.pushNamed(context, tag);
    ExtendedNavigator.of(context).push(tag);
  } else {
    // Navigator.pushNamed(context, tag, arguments: arguments);
    ExtendedNavigator.of(context).push(tag, arguments: arguments);
  }
}

void launchScreenWithNewTask(context, String tag) {
  Navigator.pushNamedAndRemoveUntil(context, tag, (r) => false);
}

Color hexStringToHexInt(String hex) {
  hex = hex.replaceFirst('#', '');
  hex = hex.length == 6 ? 'ff' + hex : hex;
  int val = int.parse(hex, radix: 16);
  return Color(val);
}
/*
String parseHtmlString(String htmlString) {
  return parse(parse(htmlString).body.text).documentElement.text;
}*/
