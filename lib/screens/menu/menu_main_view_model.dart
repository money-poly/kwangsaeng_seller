import 'package:flutter/material.dart';
import 'package:kwangsaeng_seller/models/menu.dart';
import 'package:kwangsaeng_seller/services/menu_service.dart';

class MenuMainViewModel with ChangeNotifier {
  final _service = MenuService();

  bool _isLoading = true;
  List<Menu> _menus = [];

  List<Menu> get menus => _menus;
  bool get isLoading => _isLoading;

  MenuMainViewModel() {
    init();
  }

  Future<void> init() async {
    _menus = await _service.getMenus();
    _isLoading = false;
    notifyListeners();
  }
}
