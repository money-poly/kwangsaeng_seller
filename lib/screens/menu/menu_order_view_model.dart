import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kwangsaeng_seller/models/menu.dart';
import 'package:kwangsaeng_seller/services/menu_service.dart';

class MenuOrderViewModel with ChangeNotifier {
  MenuOrderViewModel(menus) {
    initMenus(menus);
  }

  final MenuService _service = MenuService();
  bool _isWorking = false;
  List<Menu>? _menus;
  List<Menu>? _modifiedMenus;
  bool _isChangedOrder = false;

  bool get isWorking => _isWorking;
  List<Menu>? get menus => _menus;
  List<Menu>? get modifiedMenus => _modifiedMenus;
  bool get isChangedOrder => _isChangedOrder;

  void initMenus(List<Menu> initMenus) {
    _menus = [...initMenus];
    _modifiedMenus = [...?menus];
    notifyListeners();
  }

  void changeOrder(int oldIdx, int newIdx) {
    if (oldIdx < newIdx) {
      newIdx -= 1;
    }
    final Menu menu = _modifiedMenus!.removeAt(oldIdx);
    _modifiedMenus!.insert(newIdx, menu);
    if (!listEquals(_menus, _modifiedMenus)) {
      _isChangedOrder = true;
    } else {
      _isChangedOrder = false;
    }
    notifyListeners();
  }

  Future<void> saveOrder() async {
    await _service.updateMenuOrder(menus!.map((e) => e.id).toList());
    notifyListeners();
  }
}
