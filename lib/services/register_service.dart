import 'dart:convert';

import 'package:kwangsaeng_seller/services/api.dart';

class RegisterService {
  final _api = API();

  Future<bool> registerStore(
      String name,
      String storeName,
      String address,
      String businessNumber,
      String phone,
      List<int> categories,
      int cookingTime,
      String openTime,
      String closeTime,
      {String? addressDetail}) async {
    final res = await _api.req("/stores", HttpMethod.post,
        body: jsonEncode(
          {
            "businessLeaderName": name,
            "name": storeName,
            "address": address,
            if (addressDetail != null) "addressDetail": addressDetail,
            "phone": phone,
            "businessNum": businessNumber,
            "categories": categories,
            "cookingTime": cookingTime,
            "operationTimes": {
              "startedAt": openTime,
              "endedAt": closeTime,
            }
          },
        ),
        type: UrlType.dev,
        needToken: true);
    if (res.statusCode == 201) {
      return true;
    } else {
      throw Exception("http Exception");
    }
  }
}
