import 'package:flutter/material.dart';

@immutable
class NavigationTab {
  const NavigationTab({
    this.name,
    this.index,
    this.icon,
    this.iconData,
    this.iconDataSelected,
    this.initialRoute,
  });

  final int index;
  final String name;
  final Widget icon;
  final IconData iconData;
  final IconData iconDataSelected;
  final String initialRoute;
}