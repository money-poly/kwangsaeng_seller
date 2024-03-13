import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:kwangsaeng_seller/models/origin.dart';
import 'package:kwangsaeng_seller/services/menu_service.dart';
import 'package:tuple/tuple.dart';

class MenuUpdateViewModel with ChangeNotifier {
  final MenuService _service = MenuService();
  final formKey = GlobalKey<FormState>();
  bool _isRegisterLoading = false;
  bool get isRegisterLoading => _isRegisterLoading;

  MenuUpdateViewModel({int? menuId}) {
    if (menuId != null) {}
    _regularPriceController.addListener(() {
      setDiscountRate();
      checkAreValidPrices();
    });
    _discountPriceController.addListener(() {
      setDiscountRate();
      checkAreValidPrices();
    });

    origins[0].item1.addListener(() {
      checkAreValidOrigins();
    });
    origins[0].item2.addListener(() {
      checkAreValidOrigins();
    });
  }

  /* 텍스트 컨트롤러 */
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _regularPriceController = TextEditingController();
  final TextEditingController _discountPriceController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  TextEditingController get nameController => _nameController;
  TextEditingController get regularPriceController => _regularPriceController;
  TextEditingController get discountPriceController => _discountPriceController;
  TextEditingController get descriptionController => _descriptionController;

  /* 기타 입력 값 */
  String? _imgUrl;
  final List<Tuple2<TextEditingController, TextEditingController>> _origins = [
    Tuple2(TextEditingController(), TextEditingController())
  ];
  double _discountRate = 0;

  String? get imgUrl => _imgUrl;
  List<Tuple2<TextEditingController, TextEditingController>> get origins =>
      _origins;
  double get discountRate => _discountRate;

  /* validated 값 */
  bool _areValidatedPrices = false;

  bool get areValidatedPrices => _areValidatedPrices;

  /* 유효값 검증 */
  bool _areValidPrices = false;
  final List<bool> _areValidOrigins = [true];

  bool get areValidPrices => _areValidPrices;
  List<bool> get areValidOrigins => _areValidOrigins;

  void setDiscountRate() {
    var regularPrice = _regularPriceController.text.isEmpty
        ? 0
        : int.parse(_regularPriceController.text);
    var discountPrice = _discountPriceController.text.isEmpty
        ? 0
        : int.parse(_discountPriceController.text);
    if (regularPrice != 0 &&
        discountPrice != 0 &&
        regularPrice > discountPrice) {
      _discountRate = (1 - (discountPrice / regularPrice)) * 100;
    } else {
      _discountRate = 0;
    }
    notifyListeners();
  }

  void addOrigin() {
    _origins.add(Tuple2(TextEditingController(), TextEditingController()));
    _areValidOrigins.add(true);
    origins[origins.length - 1].item1.addListener(() {
      checkAreValidOrigins();
    });
    origins[origins.length - 1].item2.addListener(() {
      checkAreValidOrigins();
    });
    notifyListeners();
  }

  void removeOrigin(int idx) {
    _origins.removeAt(idx);
    _areValidOrigins.removeAt(idx);
    notifyListeners();
  }

  void pickImage() {}

  /* 유효성 검사 */
  bool checkAreAllValid() {
    if (isValidName() && _areValidPrices && !_areValidOrigins.contains(false)) {
      return true;
    } else {
      return false;
    }
  }

  bool isValidName() {
    return _nameController.text.isNotEmpty;
  }

  void validateAll() {
    _areValidatedPrices = true;
    checkAreValidPrices();
    checkAreValidOrigins();
    formKey.currentState!.validate();
    notifyListeners();
  }

  void checkAreValidPrices() {
    if (!arePricesNotEmpty()) {
      _areValidPrices = false;
    } else if (!isRegularBiggerThanDiscount()) {
      _areValidPrices = false;
    } else {
      _areValidPrices = true;
    }
    notifyListeners();
  }

  bool arePricesNotEmpty() {
    return _regularPriceController.text.isNotEmpty &&
        _discountPriceController.text.isNotEmpty;
  }

  bool isRegularBiggerThanDiscount() {
    return int.parse(_regularPriceController.text) >
        int.parse(_discountPriceController.text);
  }

  void checkAreValidOrigins() {
    for (var i = 0; i < _origins.length; i++) {
      if (((origins[i].item1.text.isEmpty && origins[i].item2.text.isEmpty) ||
          origins[i].item1.text.isNotEmpty &&
              origins[i].item2.text.isNotEmpty)) {
        areValidOrigins[i] = true;
      } else {
        areValidOrigins[i] = false;
      }
    }
    notifyListeners();
  }

  /* 메뉴 등록 */
  Future<bool> register() async {
    changeIsRegistering(true);
    if (await _service.registerMenu(
        _nameController.text,
        _descriptionController.text,
        int.parse(regularPriceController.text),
        int.parse(discountPriceController.text),
        _discountRate,
        origins
            .where((e) => e.item1.text.isNotEmpty && e.item2.text.isNotEmpty)
            .map((e) => Origin(ingredient: e.item1.text, country: e.item2.text))
            .toList())) {
      showToast("메뉴를 등록했습니다.");
      changeIsRegistering(false);
      return true;
    } else {
      showToast("메뉴 등록에 실패했습니다.");
      changeIsRegistering(false);
      return false;
    }
  }

  void changeIsRegistering(bool isRegistering) {
    _isRegisterLoading = isRegistering;
    notifyListeners();
  }
}
