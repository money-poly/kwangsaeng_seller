import 'package:flutter/material.dart';
import 'package:kwangsaeng_seller/screens/home/home_view.dart';

enum NavItems {
  home("홈"),
  menu("메뉴 관리"),
  setting("설정");

  const NavItems(this.label);
  final String label;
}

class NavViewModel with ChangeNotifier {
  int _currIdx = 0;
  final List<Widget> _pages = [
    const HomeView(),
    const MenuMainView(),
    const SettingMainView(),
  ];

  int get currIdx => _currIdx;
  Widget get currPages => _pages[currIdx];

  bool canChangeIdx(int idx) {
    switch (idx) {
      default:
        return true;
    }
  }

  void changeIdx(int idx) {
    if (canChangeIdx(idx)) {
      _currIdx = idx;
    }
    notifyListeners();
  }
}
