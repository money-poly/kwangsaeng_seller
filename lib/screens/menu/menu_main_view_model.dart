import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:kwangsaeng_seller/models/menu.dart';
import 'package:kwangsaeng_seller/services/menu_service.dart';

class MenuMainViewModel with ChangeNotifier {
  final _service = MenuService();

  bool _isLoading = true;
  bool _isWorking = false;
  List<Menu> _menus = [];

  List<Menu> get menus => _menus;
  bool get isLoading => _isLoading;
  bool get isWorking => _isWorking;

  MenuMainViewModel() {
    init();
  }

  Future<void> init() async {
    _menus = await _service.getMenus();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> changeMenuStatus(int idx, MenuStatus updateStatus) async {
    if (await _service.changeMenuStatus(
        _menus[idx].id, _menus[idx].status!, updateStatus)) {
      _menus[idx].status = updateStatus;
      showToast("메뉴 상태가 변경 되었습니다.");
    } else {
      showToast("메뉴 상태 변경에 실패했습니다.");
    }
    notifyListeners();
  }
}
