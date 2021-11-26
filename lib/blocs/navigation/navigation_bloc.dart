import 'dart:async';

enum NavBarItem { TASK, NOTIFICATION, CALENDAR, PROFILE }

class NavigationBloc {
  final StreamController<NavBarItem> _navBarController =
  StreamController<NavBarItem>.broadcast();

  NavBarItem defaultItem = NavBarItem.TASK;

  Stream<NavBarItem> get itemStream => _navBarController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarController.sink.add(NavBarItem.TASK);
        break;
      case 1:
        _navBarController.sink.add(NavBarItem.NOTIFICATION);
        break;
      case 2:
        _navBarController.sink.add(NavBarItem.CALENDAR);
        break;
      case 3:
        _navBarController.sink.add(NavBarItem.PROFILE);
        break;
    }
  }

  close() {
    _navBarController?.close();
  }
}
