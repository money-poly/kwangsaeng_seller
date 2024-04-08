import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:kwangsaeng_seller/utils.dart/custom_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum HttpMethod {
  get,
  post,
  put,
  patch,
  delete,
}

enum UrlType { dummy, dev }

class API {
  final String dummyUrl = dotenv.env['DUMMY_URL']!;
  final String devUrl = dotenv.env['DEV_URL']!;

  Future<http.Response> req(String url, HttpMethod method,
      {body, UrlType type = UrlType.dummy, bool needToken = false}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (needToken &&
        prefs.getString("accessTokenExp") != null &&
        prefs.getString("accessToken") != null) {
      final DateTime accessTokenExp =
          DateTime.parse(prefs.getString("accessTokenExp")!);
      final DateTime refreshTokenExp =
          DateTime.parse(prefs.getString("refreshTokenExp")!);
      if (refreshTokenExp.isBefore(DateTime.now())) {
        throw CustomException(ErrorCode.tokenExpired);
      } else if (accessTokenExp.isBefore(DateTime.now())) {
        await renewTokens();
      }
    }

    final reqUrl = Uri.parse(switch (type) {
      UrlType.dev => devUrl + url,
      UrlType.dummy => dummyUrl + url,
    });

    final header = {
      if (method != HttpMethod.get) 'Content-Type': 'application/json',
      if (needToken) 'Authorization': 'Bearer ${prefs.getString("accessToken")}'
    };

    switch (method) {
      case HttpMethod.get:
        return await http.get(reqUrl, headers: header);
      case HttpMethod.post:
        return await http.post(reqUrl, headers: header, body: body);
      case HttpMethod.put:
        return await http.put(reqUrl, headers: header, body: body);
      case HttpMethod.patch:
        return await http.patch(reqUrl, headers: header, body: body);
      case HttpMethod.delete:
        return await http.delete(reqUrl, headers: header, body: body);
      default:
        throw Exception("Invalid http method");
    }
  }

  Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("accessToken")!;
  }

  Future<void> renewTokens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final res = await req(
      '/auth/reissue',
      HttpMethod.post,
      body: jsonEncode(
        {
          'accessToken': prefs.getString("accessToken"),
          'refreshToken': prefs.getString("refreshToken")
        },
      ),
      type: UrlType.dev,
    );
    if (res.statusCode == 201) {
      await saveToken(res);
    } else {
      throw Exception("http Exception");
    }
  }

  Future<void> saveToken(res) async {
    final body = jsonDecode(res.body)["data"];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("accessToken", body["accessToken"]);
    prefs.setString("refreshToken", body["refreshToken"]);
    prefs.setString("accessTokenExp", body["accessTokenExp"]);
    prefs.setString("refreshTokenExp", body["refreshTokenExp"]);
  }
}
