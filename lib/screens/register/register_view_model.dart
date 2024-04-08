import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kwangsaeng_seller/models/store.dart';
import 'package:kwangsaeng_seller/screens/menu/menu_update_view_model.dart';
import 'package:kwangsaeng_seller/services/store_service.dart';
import 'package:kwangsaeng_seller/utils.dart/phone_formatter.dart';
import 'package:kwangsaeng_seller/utils.dart/time_formatter.dart';

enum StoreUpdateViewType {
  register("등록"),
  edit("수정");

  const StoreUpdateViewType(this.str);
  final String str;
}

enum TimeType { open, close }

class RegisterViewModel with ChangeNotifier {
  final StoreService _service = StoreService();
  final formKey = GlobalKey<FormState>();
  late StoreUpdateViewType _viewMode;
  StoreDetail? _initialStore;

  /* ViewMode edit 에서만 사용 */
  String? _storeImg;
  ImgType _imgType = ImgType.empty;
  final TextEditingController _descriptionController = TextEditingController();
  StoreDetail? get initialStore => _initialStore;
  String? get storeImg => _storeImg;
  ImgType get imgType => _imgType;
  TextEditingController get descriptionController => _descriptionController;

  /* 텍스트 컨트롤러 */
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _businessNumberController =
      TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _detailAddressController =
      TextEditingController();

  TextEditingController get nameController => _nameController;
  TextEditingController get storeNameController => _storeNameController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get businessNumberController =>
      _businessNumberController;
  TextEditingController get categoryController => _categoryController;
  TextEditingController get addressController => _addressController;
  TextEditingController get detailAddressController => _detailAddressController;

  /* 입력값 */
  late final List<StoreCategory> _categories;
  late List<bool> _isSelectedCategory;
  int _cookingTime = 0;
  TimeType _selectedTime = TimeType.open;
  TimeOfDay _openTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _closeTime = const TimeOfDay(hour: 0, minute: 0);
  final List<String> _areaNumbers = [
    "02",
    "031",
    "032",
    "033",
    "041",
    "042",
    "043",
    "051",
    "052",
    "053",
    "054",
    "055",
    "061",
    "062",
    "063",
    "064"
  ];
  String _selectedAreaNumber = "02";

  List<StoreCategory> get categories => _categories;
  List<bool> get isSelectedCategory => _isSelectedCategory;
  int get cookingTime => _cookingTime;
  TimeType get selectedTime => _selectedTime;
  TimeOfDay get openTime => _openTime;
  TimeOfDay get closeTime => _closeTime;
  List<String> get areaNumbers => _areaNumbers;
  String get selectedAreaNumber => _selectedAreaNumber;

  /* 유효성 검사  */
  bool _isLoading = true;
  bool _isRegistering = false;
  bool _areValidRegister = false;
  bool _areValidModify = false;
  bool _isValidName = false;
  bool _isValidStoreName = false;
  bool _isValidPhone = false;
  bool _isValidBusinessNumber = false;
  bool _isValidCategory = false;
  bool _isValidAddress = false;
  bool _isValidOperationTime = false;

  bool get isLoading => _isLoading;
  bool get isRegistering => _isRegistering;
  bool get areValidRegister => _areValidRegister;
  bool get areValidModify => _areValidModify;
  bool get isValidName => _isValidName;
  bool get isValidStoreName => _isValidStoreName;
  bool get isValidPhone => _isValidPhone;
  bool get isValidBusinessNumber => _isValidBusinessNumber;
  bool get isValidCategory => _isValidCategory;
  bool get isValidAddress => _isValidAddress;
  bool get isValidOperationTime => _isValidOperationTime;

  /* validator 작동 여부 */
  bool _isPhoneValidated = false;
  bool _isOperationTimeValidated = false;

  bool get isPhoneValidated => _isPhoneValidated;
  bool get isOperationTimeValidated => _isOperationTimeValidated;

  RegisterViewModel({type = StoreUpdateViewType.register}) {
    if (type == StoreUpdateViewType.edit) {
      _viewMode = StoreUpdateViewType.edit;
    }
    init();
  }

  void init() async {
    initListener();
    getCategories();
    if (_viewMode == StoreUpdateViewType.edit) {
      initStore();
    } else {
      _isLoading = false;
    }
  }

  void initStore() async {
    _initialStore = await _service.getStoreDetail();
    initImg();
    _storeNameController.text = _initialStore!.name;
    initSelectedCategory();
    updateCookingTime(_initialStore!.cookingTime);
    updateOpenTime(timeParser(_initialStore!.openTime));
    updateCloseTime(timeParser(_initialStore!.closeTime));
    _selectedAreaNumber = _initialStore!.phone.split("-")[0];
    _phoneController.text =
        _initialStore!.phone.split("-")[1] + _initialStore!.phone.split("-")[2];
    _addressController.text = _initialStore!.address;
    _detailAddressController.text = _initialStore!.addressDetail ?? "";
    _descriptionController.text = _initialStore!.description ?? "";
    _isLoading = false;
    notifyListeners();
  }

  void initImg() {
    if (_initialStore!.imgUrl != null) {
      updateImgUrl(_initialStore!.imgUrl, ImgType.url);
    } else {
      updateImgUrl(_initialStore!.imgUrl, ImgType.empty);
    }
  }

  void initListener() {
    _nameController.addListener(() {
      checkAreValidRegister();
      checkAreValidModify();
    });
    _storeNameController.addListener(() {
      checkAreValidRegister();
      checkAreValidModify();
    });
    _phoneController.addListener(() {
      checkAreValidRegister();
      checkAreValidModify();
    });
    _businessNumberController.addListener(() {
      checkAreValidRegister();
      checkAreValidModify();
    });
    _addressController.addListener(() {
      checkAreValidRegister();
      checkAreValidModify();
    });
    _categoryController.addListener(() {
      checkAreValidRegister();
      checkAreValidModify();
    });
  }

  void getCategories() {
    // [TODO] 서버에서 카테고리 받아오기
    _categories = [
      StoreCategory(id: 3, name: "도시락"),
      StoreCategory(id: 4, name: "뷔페"),
      StoreCategory(id: 5, name: "디저트"),
      StoreCategory(id: 6, name: "반찬"),
      StoreCategory(id: 7, name: "과일/야채"),
    ];
    _isSelectedCategory = List.generate(_categories.length, (index) => false);
    notifyListeners();
  }

  void initSelectedCategory() {
    for (var category in _initialStore!.categories) {
      _isSelectedCategory[_categories.indexWhere((e) => e.name == category)] =
          true;
    }
    updateCategoryController();
  }

  /* 값 업데이트 */
  void updateSelectedCategories(int idx) {
    if (_isSelectedCategory[idx]) {
      _isSelectedCategory[idx] = false;
    } else {
      _isSelectedCategory[idx] = true;
    }
    updateCategoryController();
    checkAreValidRegister();
    checkAreValidModify();
  }

  void updateCategoryController() {
    _categoryController.text = _categories
        .where((e) => _isSelectedCategory[_categories.indexOf(e)])
        .map((e) => e.name)
        .toList()
        .join(", ");
  }

  void updateAddress(String address) {
    _addressController.text = address;
    checkAreValidRegister();
    checkAreValidModify();
  }

  void updateCookingTime(int cookingTime) {
    _cookingTime = cookingTime;
    checkAreValidRegister();
    checkAreValidModify();
  }

  void updateSelectTime(TimeType type) {
    if (type == TimeType.open) {
      _selectedTime = TimeType.open;
    } else {
      _selectedTime = TimeType.close;
    }
    checkAreValidRegister();
    checkAreValidModify();
  }

  void updateOpenTime(TimeOfDay time) {
    validateOperationTime();
    _openTime = time;
    checkAreValidRegister();
    checkAreValidModify();
  }

  void updateCloseTime(TimeOfDay time) {
    validateOperationTime();
    _closeTime = time;
    checkAreValidRegister();
    checkAreValidModify();
  }

  void updateAreaNumber(String areaNumber) {
    _selectedAreaNumber = areaNumber;
    checkAreValidRegister();
    checkAreValidModify();
  }

  /* validated 여부 변경 */
  void validatePhone() {
    _isPhoneValidated = true;
    notifyListeners();
  }

  void validateOperationTime() {
    _isOperationTimeValidated = true;
    notifyListeners();
  }

  void validateAll() {
    _isPhoneValidated = true;
    _isOperationTimeValidated = true;
    notifyListeners();
  }

  /* 유효성 검증 */
  void checkValidName() {
    _isValidName = _nameController.text.isNotEmpty;
    notifyListeners();
  }

  void checkValidStoreName() {
    _isValidStoreName = _storeNameController.text.isNotEmpty;
    notifyListeners();
  }

  void checkValidPhone() {
    _isValidPhone =
        _phoneController.text.isNotEmpty && _phoneController.text.length >= 7;
    notifyListeners();
  }

  void checkValidBusinessNumber() {
    _isValidBusinessNumber = _businessNumberController.text.isNotEmpty &&
        _businessNumberController.text.length == 10;
    notifyListeners();
  }

  void checkValidCategory() {
    _isValidCategory = _isSelectedCategory.contains(true);
    notifyListeners();
  }

  void checkValidAddress() {
    _isValidAddress = _addressController.text.isNotEmpty;
    notifyListeners();
  }

  void checkValidOperationTime() {
    _isValidOperationTime =
        !(_openTime == const TimeOfDay(hour: 0, minute: 0) &&
            _closeTime == const TimeOfDay(hour: 0, minute: 0));
    notifyListeners();
  }

  void checkAreValidRegister() {
    checkValidName();
    checkValidStoreName();
    checkValidCategory();
    checkValidPhone();
    checkValidBusinessNumber();
    checkValidAddress();
    checkValidOperationTime();

    if (_isValidName == true &&
        _isValidStoreName == true &&
        _isValidCategory == true &&
        _isValidPhone == true &&
        _isValidBusinessNumber == true &&
        _isValidAddress == true &&
        _isValidOperationTime == true) {
      _areValidRegister = true;
    } else {
      _areValidRegister = false;
    }
    notifyListeners();
  }

  void checkAreValidModify() {
    checkValidStoreName();
    checkValidCategory();
    checkValidPhone();
    checkValidAddress();
    checkValidOperationTime();

    if (_isValidStoreName == true &&
        _isValidCategory == true &&
        _isValidPhone == true &&
        _isValidAddress == true &&
        _isValidOperationTime == true) {
      _areValidModify = true;
    } else {
      _areValidModify = false;
    }
    notifyListeners();
  }

  /* 가게 등록 및 수정 */
  Future<bool> register() async {
    if (await _service.registerStore(
        _nameController.text,
        _storeNameController.text,
        _addressController.text,
        '${_businessNumberController.text.substring(0, 3)}-${_businessNumberController.text.substring(3, 5)}-${_businessNumberController.text.substring(5)}',
        "$_selectedAreaNumber-${phoneFormatter(_phoneController.text)}",
        _isSelectedCategory.indexed
            .where((e) => e.$2 == false)
            .map((e) => _categories[e.$1].id)
            .toList(),
        _cookingTime,
        timeFormatter(_openTime, TimeFormat.timeTo24Str),
        timeFormatter(_closeTime, TimeFormat.timeTo24Str),
        addressDetail: _detailAddressController.text)) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> modify() async {
    if (_imgType != ImgType.empty) {
      try {
        updateImgUrl(await _service.uploadStoreImg(storeImg!), ImgType.url);
      } catch (e) {
        showToast("이미지 업로드에 실패했습니다.");
      }
    }

    if (await _service.modifyStore(
      _storeNameController.text,
      _addressController.text,
      "$_selectedAreaNumber-${phoneFormatter(_phoneController.text)}",
      _isSelectedCategory.indexed
          .where((e) => e.$2 == false)
          .map((e) => _categories[e.$1].id)
          .toList(),
      _cookingTime,
      timeFormatter(_openTime, TimeFormat.timeTo24Str),
      timeFormatter(_closeTime, TimeFormat.timeTo24Str),
      _storeImg,
      _descriptionController.text,
      _detailAddressController.text,
    )) {
      return true;
    } else {
      return false;
    }
  }

  /* 이미지 업로드 */
  Future<void> uploadImg() async {
    final picker = ImagePicker();
    final pickedImg = await picker.pickImage(source: ImageSource.gallery);
    try {
      if (pickedImg != null) {
        updateImgUrl(pickedImg.path, ImgType.file);
      } else {
        showToast("이미지를 가져오는데 실패했습니다.");
      }
    } catch (e) {
      throw Exception("이미지를 가져오는데 실패했습니다.");
    }
    notifyListeners();
  }

  void updateImgUrl(dynamic imgUrl, ImgType imgType) {
    _imgType = imgType;
    _storeImg = imgUrl;
    notifyListeners();
  }

  void changeIsRegistering(bool isRegistering) {
    _isRegistering = isRegistering;
    notifyListeners();
  }
}
