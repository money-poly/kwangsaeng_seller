import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kwangsaeng_seller/models/menu.dart';

class MenuOrderViewModel with ChangeNotifier {
  MenuOrderViewModel() {
    getMenus();
  }

  List<Menu>? _menus;
  List<Menu>? _modifiedMenus;
  bool _isChangedOrder = false;

  List<Menu>? get menus => _menus;
  List<Menu>? get modifiedMenus => _modifiedMenus;
  bool get isChangedOrder => _isChangedOrder;

  void getMenus() {
    List<Menu> tempMenus = [
      Menu(
          id: 1,
          name: "돈까스",
          discountRate: 10,
          discountPrice: 9000,
          regularPrice: 10000,
          imgUrl: null,
          status: MenuStatus.sale),
      Menu(
          id: 2,
          name: "오렌지 치킨 샐러드",
          discountRate: 10,
          discountPrice: 9000,
          regularPrice: 10000,
          imgUrl: null,
          status: MenuStatus.sale),
      Menu(
          id: 4,
          name: "돈까스세트메밀국수우동",
          discountRate: 40,
          discountPrice: 10200,
          regularPrice: 17000,
          imgUrl: null,
          status: MenuStatus.soldout),
    ];
    _menus = [...tempMenus];
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
}
