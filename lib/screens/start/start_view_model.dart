import 'package:flutter/material.dart';
import 'package:kwangsaeng_seller/services/auth_service.dart';

enum StoreRegisterStatus { before, waiting, done }

class StartViewModel with ChangeNotifier {
  final AuthService _service = AuthService();
  final formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _isSubmitted = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isEmailValid = false;

  bool get isLoading => _isLoading;
  bool get isSubmitted => _isSubmitted;

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  bool get isEmailValid => _isEmailValid;
  String? Function(dynamic) get emailValidator => (input) {
        if (input.isEmpty) {
          _isEmailValid = false;
          return "이메일을 입력해주세요";
        } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
            .hasMatch(input)) {
          _isEmailValid = false;
          return "이메일 형식이 올바르지 않습니다";
        } else {
          _isEmailValid = true;
          return null;
        }
      };

  StartViewModel() {
    _emailController.addListener(() {
      notifyListeners();
    });
    _passwordController.addListener(() {
      notifyListeners();
    });
  }

  void changeLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void switchIsSubmitted() {
    _isSubmitted = true;
    notifyListeners();
  }

  Future<bool> login() async {
    return await _service.login(
        _emailController.text, _passwordController.text);
  }

  Future<StoreRegisterStatus> getStoreRegisterStatus() async {
    final storeRegisterStatus = await _service.getStoreRegisterStatus();
    print("[LOG] $storeRegisterStatus");
    return storeRegisterStatus;
  }
}
