import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kwangsaeng_seller/models/menu.dart';
import 'package:kwangsaeng_seller/services/menu_service.dart';

class MenuDetailViewModel with ChangeNotifier {
  final _service = MenuService();
  MenuDetail? _menu;
  BitmapDescriptor? _markerOffIcon;

  MenuDetail? get menu => _menu;
  BitmapDescriptor? get markerOffIcon => _markerOffIcon;

  MenuDetailViewModel(int id) {
    initMarkerIcon();
    getDetailMenu(id);
  }

  void initMarkerIcon() async {
    await getBytesFromAsset("assets/imgs/img_30_marker_off.png", 90)
        .then((value) => _markerOffIcon = BitmapDescriptor.fromBytes(value));
    notifyListeners();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    final data = await rootBundle.load(path);
    final codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    final frameInfo = await codec.getNextFrame();
    return (await frameInfo.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> getDetailMenu(int id) async {
    _menu = null;
    _menu = await _service.getMenuDetail(id);
    notifyListeners();
  }
}
