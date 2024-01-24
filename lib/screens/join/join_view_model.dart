import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kwangsaeng_seller/screens/join/widgets/auth_number_btn.dart';
import 'package:kwangsaeng_seller/services/auth_service.dart';

class JoinViewModel with ChangeNotifier {
  final AuthService _service = AuthService();
  final formKey = GlobalKey<FormState>();

  /* 컨트롤러 */
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _domainController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  /* 이메일 */
  final List<String> domains = [
    "gmail.com",
    "naver.com",
    "kakao.com",
    "hanmail.com",
    "daum.net",
    "nate.com"
  ];
  String? _selDomain;

  /* 휴대폰 인증 */
  AuthNumberBtnType _authStatus = AuthNumberBtnType.before;
  int _authTime = 180;
  bool? _authSuccess;

  // bool _isSubmitted = false;
  bool _areValidJoin = false;
  bool _isLoading = false;

  TextEditingController get phoneController => _phoneController;
  TextEditingController get codeController => _codeController;
  TextEditingController get idController => _idController;
  TextEditingController get domainController => _domainController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get rePasswordController => _rePasswordController;
  String? get selDomain => _selDomain;

  AuthNumberBtnType get authStatus => _authStatus;
  int get authTime => _authTime;
  bool? get authSuccess => _authSuccess;

  // bool get isSubmitted => _isSubmitted;
  bool get areValidJoin => _areValidJoin;
  bool get isLoading => _isLoading;

  JoinViewModel() {
    _phoneController.addListener(() {
      checkAreValid();
    });
    _codeController.addListener(() {
      notifyListeners();
    });
    _passwordController.addListener(() {
      checkAreValid();
    });
    _rePasswordController.addListener(() {
      checkAreValid();
    });
    _idController.addListener(() {
      checkAreValid();
    });
    _domainController.addListener(() {
      if (_selDomain != domainController.text) {
        _selDomain = null;
      }
      checkAreValid();
    });
  }

  // void switchIsSubmitted() {
  //   _isSubmitted = true;
  //   notifyListeners();
  // }

  void changeAuthStatus(AuthNumberBtnType status) {
    switch (status) {
      case AuthNumberBtnType.before:
        break;
      case AuthNumberBtnType.wait:
        requestAuthCode();
        break;
      case AuthNumberBtnType.after:
        break;
    }
    _authStatus = status;
    checkAreValid();
    notifyListeners();
  }

  void countAuthTime() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_authTime == 0) {
        timer.cancel();
      } else {
        _authTime--;
        notifyListeners();
      }
    });
  }

  void requestAuthCode() async {
    if (await _service.requestAuthCode(phoneController.text)) {
      countAuthTime();
    }
    notifyListeners();
  }

  Future<bool> verifyAuthCode() async {
    _authSuccess = await _service.verifyAuthCode(
        phoneController.text, codeController.text);
    notifyListeners();
    return _authSuccess!;
  }

  void selectDomain(String domain) {
    _domainController.text = domain;
    _selDomain = domain;
    notifyListeners();
  }

  void checkAreValid() {
    if ( //[수정] authSuccess == true &&
        idController.text.isNotEmpty &&
            domainController.text.isNotEmpty &&
            passwordController.text.isNotEmpty &&
            passwordController.text == rePasswordController.text &&
            RegExp(r'[!@#%^&*(),.?":{}|<>]')
                .hasMatch(passwordController.text)) {
      _areValidJoin = true;
    } else {
      _areValidJoin = false;
    }
    notifyListeners();
  }

  void changeLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<bool> join() async {
    changeLoading(true);
    final isJoinSuccess = await _service.join(
        "${idController.text}@${domainController.text}",
        passwordController.text,
        phoneController.text);
    changeLoading(false);
    return isJoinSuccess;
  }
}
