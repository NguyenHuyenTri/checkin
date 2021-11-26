import 'package:ant_icons/ant_icons.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:vao_ra/models/models.dart';
import 'package:vao_ra/models/tab.dart';
import 'package:vao_ra/routes/router.dart';

class NavigationBlocA extends Bloc<int, int> {
  NavigationBlocA() : super(NavigationTabs.first);

  @override
  Stream<int> mapEventToState(int event) async* {
    yield event;
  }

  final tabs = <NavigationTab>[
    NavigationTab(
      index: 0,
      name: "Làm việc",
      iconData: Icons.list,
      iconDataSelected: Icons.view_list_rounded,
      initialRoute: Routes.itimeTaskScreen,
    ),
    NavigationTab(
      index: 1,
      name: "Lịch",
      iconData: AntIcons.calendar_outline,
      iconDataSelected: AntIcons.calendar,
      initialRoute: Routes.itimeCalendarScreen,
    ),
    NavigationTab(
      index: 2,
      name: "Thông báo",
      iconData: Icons.notifications_none_outlined,
      iconDataSelected: Icons.notifications,
      initialRoute: Routes.itimeNotificationScreen,
    ),
    NavigationTab(
      index: 3,
      name: "Cá nhân",
      iconData: Icons.supervised_user_circle_outlined,
      iconDataSelected: Icons.supervised_user_circle,
      initialRoute: Routes.itimeProfileScreen,
    ),
  ];


  Future<bool> onWillPop() async {
    final currentNavigatorState = ExtendedNavigator.named(tabs[state].name);

    if (currentNavigatorState.canPop()) {
      currentNavigatorState.pop();
    } else {
      if (state == NavigationTabs.first) {
        return true;
      } else {
        add(NavigationTabs.first);
      }
    }

    return false;
  }
}

class NavigationTabs {
  /// Default constructor is private because this class will be only used for
  /// static fields and you should not instantiate it.
  NavigationTabs._();

  static const first = 0;
  static const second = 1;
  static const third = 2;
  static const fourth = 3;
}
