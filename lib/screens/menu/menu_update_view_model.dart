import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kwangsaeng_seller/models/menu.dart';
import 'package:kwangsaeng_seller/models/origin.dart';
import 'package:kwangsaeng_seller/services/menu_service.dart';
import 'package:tuple/tuple.dart';

enum MenuUpdateViewType {
  register("등록"),
  edit("수정");

  const MenuUpdateViewType(this.str);
  final String str;
}

enum ImgType { empty, file, url }

class MenuUpdateViewModel with ChangeNotifier {
  final MenuService _service = MenuService();
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  late MenuUpdateViewType _viewMode;
  MenuDetail? _initialMenu;
  int? _initialMenuId;

  MenuUpdateViewModel({int? menuId}) {
    init(menuId: menuId);
  }

  /* 텍스트 컨트롤러 */
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _expireController = TextEditingController();
  final TextEditingController _regularPriceController = TextEditingController();
  final TextEditingController _discountPriceController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  /* 기타 입력 값 */
  dynamic _imgUrl;
  ImgType _imgType = ImgType.empty;
  final List<Tuple2<TextEditingController, TextEditingController>> _origins = [
    Tuple2(TextEditingController(), TextEditingController())
  ];
  double _discountRate = 0;
  /* validated 값 */
  bool _areValidatedPrices = false;
  /* 유효값 검증 */
  bool _areValidPrices = false;
  final List<bool> _areValidOrigins = [true];

  MenuUpdateViewType get viewMode => _viewMode;
  TextEditingController get nameController => _nameController;
  TextEditingController get expireController => _expireController;
  TextEditingController get regularPriceController => _regularPriceController;
  TextEditingController get discountPriceController => _discountPriceController;
  TextEditingController get descriptionController => _descriptionController;
  dynamic get imgUrl => _imgUrl;
  ImgType get imgType => _imgType;
  List<Tuple2<TextEditingController, TextEditingController>> get origins =>
      _origins;
  double get discountRate => _discountRate;
  bool get areValidatedPrices => _areValidatedPrices;
  bool get areValidPrices => _areValidPrices;
  List<bool> get areValidOrigins => _areValidOrigins;

  void init({int? menuId}) {
    _initialMenuId = menuId;
    initListener();
    if (menuId == null) {
      _viewMode = MenuUpdateViewType.register;
    } else {
      _viewMode = MenuUpdateViewType.edit;
      initMenu(menuId);
    }
  }

  void initListener() {
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

  void initMenu(int menuId) async {
    changeIsLoading(true);
    _initialMenu = await _service.getMenuDetail(menuId);
    initImg();
    _nameController.text = _initialMenu!.name;
    _expireController.text =
        DateFormat("yyyyMMdd").format(_initialMenu!.expiredDate);
    _regularPriceController.text = _initialMenu!.regularPrice.toString();
    _discountPriceController.text = _initialMenu!.discountPrice.toString();
    _descriptionController.text = _initialMenu!.description ?? "";

    if (_initialMenu!.origins.isNotEmpty) {
      for (var origin in _initialMenu!.origins) {
        _origins.clear();
        _origins.add(Tuple2(TextEditingController(), TextEditingController()));
        _origins[_origins.length - 1].item1.text = origin.ingredient;
        _origins[_origins.length - 1].item2.text = origin.country;
        _areValidOrigins.add(true);
        origins[origins.length - 1].item1.addListener(() {
          checkAreValidOrigins();
        });
        origins[origins.length - 1].item2.addListener(() {
          checkAreValidOrigins();
        });
      }
    }
    // setDiscountRate();
    changeIsLoading(false);
    notifyListeners();
  }

  void initImg() {
    if (_initialMenu!.menuPictureUrl != null) {
      _imgType = ImgType.url;
      _imgUrl = _initialMenu!.menuPictureUrl;
    } else {
      _imgType = ImgType.empty;
    }
  }

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

  Future<void> uploadImg() async {
    final picker = ImagePicker();
    final pickedImg = await picker.pickImage(source: ImageSource.gallery);
    try {
      if (pickedImg != null) {
        updateImgUrl(pickedImg.path, imgType: ImgType.file);
      } else {
        showToast("이미지를 가져오는데 실패했습니다.");
      }
    } catch (e) {
      throw Exception("이미지를 가져오는데 실패했습니다.");
    }
    notifyListeners();
  }

  void updateImgUrl(dynamic imgUrl, {ImgType imgType = ImgType.url}) {
    if (imgUrl == null) {
      _imgType = ImgType.empty;
    } else {
      _imgType = imgType;
    }
    _imgUrl = imgUrl;
    notifyListeners();
  }

  /* 유효성 검사 */
  bool checkAreAllValid() {
    if (formKey.currentState!.validate() &&
        _areValidPrices &&
        !_areValidOrigins.contains(false)) {
      return true;
    } else {
      return false;
    }
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

  /* 메뉴 등록 및 수정 */
  Future<bool> register() async {
    changeIsLoading(true);

    if (imgUrl != null) {
      updateImgUrl(await _service.uploadMenuImg(imgUrl), imgType: ImgType.url);
    } else {
      showToast("이미지 업로드에 실패했습니다.");
    }

    if (await _service.registerMenu(
        _nameController.text,
        _descriptionController.text,
        int.parse(regularPriceController.text),
        int.parse(discountPriceController.text),
        _discountRate,
        origins
            .where((e) => e.item1.text.isNotEmpty && e.item2.text.isNotEmpty)
            .map((e) => Origin(ingredient: e.item1.text, country: e.item2.text))
            .toList(),
        expireController.text,
        imgUrl)) {
      showToast("메뉴를 등록했습니다.");
      changeIsLoading(false);
      return true;
    } else {
      showToast("메뉴 등록에 실패했습니다.");
      changeIsLoading(false);
      return false;
    }
  }

  Future<bool> modify() async {
    changeIsLoading(true);
    if (imgType == ImgType.file) {
      try {
        updateImgUrl(await _service.uploadMenuImg(imgUrl),
            imgType: ImgType.url);
      } catch (e) {
        showToast("이미지 업로드에 실패했습니다.");
      }
    }

    if (await _service.modifyMenu(
        _initialMenuId!,
        _nameController.text,
        _descriptionController.text,
        int.parse(regularPriceController.text),
        int.parse(discountPriceController.text),
        _discountRate,
        origins
            .where((e) => e.item1.text.isNotEmpty && e.item2.text.isNotEmpty)
            .map((e) => Origin(ingredient: e.item1.text, country: e.item2.text))
            .toList(),
        expireController.text,
        imgUrl)) {
      showToast("메뉴를 수정했습니다.");
      changeIsLoading(false);
      return true;
    } else {
      showToast("메뉴 수정에 실패했습니다.");
      changeIsLoading(false);
      return false;
    }
  }

  void changeIsLoading(bool isRegistering) {
    _isLoading = isRegistering;
    notifyListeners();
  }
}
