import 'package:flutter/material.dart';

class IndexController {
  static IndexController? _instance;

  static IndexController get instance {
    _instance ??= IndexController._();
    return _instance!;
  }

  IndexController._() {
    debugPrint("==== IndexController =====");
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ValueNotifier<int> selectedIndexNotifier = ValueNotifier<int>(0);

  void onItemTapped(int index) {
    selectedIndexNotifier.value = index;
    scaffoldKey.currentState?.closeDrawer();
  }
}
