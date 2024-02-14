import 'package:kwangsaeng_seller/models/origin.dart';

String originFormatter(List<Origin> origins) {
  Map<String, List<String>> resultMap = {};
  for (var i = 0; i < origins.length; i++) {
    if (resultMap[origins[i].ingredient] == null) {
      resultMap[origins[i].ingredient] = [origins[i].country];
    } else {
      if (!resultMap[origins[i].ingredient]!.contains(origins[i].country)) {
        resultMap[origins[i].ingredient]!.add(origins[i].country);
      }
    }
  }
  
  return resultMap.entries
      .map((e) => "${e.key}(${e.value.join("ㆍ")})")
      .toList()
      .join(", ");
}
