import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kwangsaeng_seller/models/store.dart';
import 'package:kwangsaeng_seller/services/store_service.dart';

class StorePreviewViewModel with ChangeNotifier {
  final _service = StoreService();

  StorePreviewViewModel() {
    init();
  }

  bool _isLoading = true;
  BitmapDescriptor? _markerIcon;
  StoreDetail? _store;

  bool get isLoading => _isLoading;
  BitmapDescriptor? get markerIcon => _markerIcon;
  StoreDetail? get store => _store;

  void init() async {
    _store = await _service.getStoreDetail();
    await initMarkerIcon();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> initMarkerIcon() async {
    await getBytesFromAsset("assets/imgs/img_30_marker_off.png", 90)
        .then((value) => _markerIcon = BitmapDescriptor.fromBytes(value));
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
}
