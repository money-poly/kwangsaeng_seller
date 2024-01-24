import 'dart:convert';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:kwangsaeng_seller/screens/start/start_view_model.dart';
import 'package:kwangsaeng_seller/services/api.dart';
import 'package:kwangsaeng_seller/services/fireabase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _api = API();
  final _firebase = FirebaseService();

  Future<bool> requestAuthCode(String phone) async {
    final res = await _api.req('/auth/verification/send', HttpMethod.post,
        body: jsonEncode({'to': phone}), type: UrlType.dev);
    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception("http Exception");
    }
  }

  Future<bool> verifyAuthCode(String phone, String code) async {
    final res = await _api.req('/auth/verification/verify', HttpMethod.post,
        body: jsonEncode({'to': phone, 'code': code}), type: UrlType.dev);
    if (res.statusCode == 201) {
      return jsonDecode(res.body)["verified"];
    } else {
      throw Exception("http Exception");
    }
  }

  Future<bool> join(String email, String password, String phone) async {
    final String fid;
    try {
      fid = await _firebase.join(email, password);
    } catch (e) {
      if (e == FirebaseJoinError.emailAlreadyInUseError) {
        showToast("이미 사용중인 이메일입니다.");
      } else {
        showToast("회원 가입에 실패했습니다. 다시 시도 해주세요");
      }
      return false;
    }
    final res = await _api.req(
      '/auth/register/owner',
      HttpMethod.post,
      body: jsonEncode(
        {'fId': fid, 'phone': phone},
      ),
      type: UrlType.dev,
    );

    if (res.statusCode == 201) {
      _api.saveToken(res);
      return true;
    } else {
      throw Exception("http Exception");
    }
  }

  Future<bool> login(String email, String password) async {
    final String fid;
    try {
      fid = await _firebase.login(email, password);
    } catch (e) {
      showToast("로그인에 실패했습니다. 다시 시도 해주세요");
      return false;
    }
    final res = await _api.req(
      '/auth/login',
      HttpMethod.post,
      body: jsonEncode(
        {'fId': fid},
      ),
      type: UrlType.dev,
    );

    print(res.body);
    if (res.statusCode == 201) {
      await _api.saveToken(res);
      return true;
    } else {
      throw Exception("http Exception");
    }
  }

  Future<bool> getStoreId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final res = await _api.req(
      '/stores/find-using-token',
      HttpMethod.get,
      type: UrlType.dev,
      needToken: true,
    );

    print("[LOG]${res.body}");
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body)["data"] as List;
      if (data.isEmpty) {
        return false; // 가게 등록이 안되어있음
      }
      prefs.setString("storeId", "${data[0]["id"]}");
      return true;
    } else {
      throw Exception("http Exception");
    }
  }

  Future<StoreRegisterStatus> getStoreRegisterStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!await getStoreId()) {
      return StoreRegisterStatus.before;
    }

    final res = await _api.req(
      '/stores/operation/${prefs.getString("storeId")}',
      HttpMethod.get,
      type: UrlType.dev,
    );

    print("[LOG]${res.body}");
    if (res.statusCode == 200) {
      final status = jsonDecode(res.body)["data"]["status"];
      if (status == "before") {
        return StoreRegisterStatus.before;
      } else if (status == "waiting") {
        return StoreRegisterStatus.waiting;
      } else if (status == "done") {
        return StoreRegisterStatus.done;
      }
      return StoreRegisterStatus.before;
    } else {
      throw Exception("http Exception");
    }
  }
}
