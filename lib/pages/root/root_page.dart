import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vao_ra/blocs/blocs.dart';
import 'package:vao_ra/blocs/navigation_bloc_a.dart';
import 'package:vao_ra/models/models.dart';
import 'package:vao_ra/models/notification_user.dart';
import 'package:vao_ra/routes/router.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:vao_ra/shares/GeneralColors.dart';
import '../pages.dart';
import 'root_page.i18n.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<NavigationBlocA>();
    final countNotify = context.watch<NotificationGlobalCount>();

    return BlocBuilder<NavigationBlocA, int>(
      cubit: bloc,
      builder: (context, state) {
        return WillPopScope(
          onWillPop: bloc.onWillPop,
          child: Scaffold(
              body: IndexedStack(
                index: state,
                children: List.generate(bloc.tabs.length, (index) {
                  final tab = bloc.tabs[index];
                  return TickerMode(
                    enabled: index == state,
                    child: Offstage(
                      offstage: index != state,
                      child: ExtendedNavigator(
                        initialRoute: tab.initialRoute,
                        name: tab.name,
                        router: AppRouter(),
                      ),
                    ),
                  );
                }),
              ),
            bottomNavigationBar: CustomNavigationBar(
              iconSize: 25.0,
              selectedColor: Color(0xffff5722),
              strokeColor: Color(0xffff5722),
              unSelectedColor: Color(0xffacacac),
              backgroundColor: Colors.white,
              items: bloc.tabs.map((tab) {
                return CustomNavigationBarItem(
                  icon: Icon(tab.iconData),
                  selectedIcon: Icon(tab.iconDataSelected),
                  title: Text(tab.name.toString().i18n),
                  selectedTitle: Text(tab.name,
                      style: TextStyle(color: Color(0xffff5722))),
                  badgeCount: countNotify.num_unread_notify != null
                      ? countNotify.num_unread_notify
                      : 0,
                  // showBadge: true
                  showBadge: (countNotify.num_unread_notify != null &&
                      countNotify.num_unread_notify > 0 &&
                      tab.index == 2)
                      ? true
                      : false,
                );
              }).toList(),
              currentIndex: state,
              onTap: bloc.add,
            )
          ),
        );
      },
    );
  }
}
