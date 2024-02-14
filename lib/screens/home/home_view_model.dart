import 'package:flutter/material.dart';
import 'package:kwangsaeng_seller/models/store.dart';
import 'package:kwangsaeng_seller/models/tag.dart';
import 'package:kwangsaeng_seller/services/home_service.dart';

enum StoreStatus {
  open(true),
  closed(false);

  const StoreStatus(this.isOpen);
  final bool isOpen;
}

class HomeViewModel with ChangeNotifier {
  final service = HomeService();

  HomeViewModel() {
    init();
  }

  bool _isLoading = true;
  bool _isChangeLoading = false;
  StoreHome? _store;
  StoreStatus? _status;
  int? _selectedTag;
  List<Tag> _tags = [];

  bool get isLoading => _isLoading;
  bool get isChangeLoading => _isChangeLoading;
  StoreStatus? get status => _status;
  StoreHome? get store => _store;
  int? get selectedTag => _selectedTag;
  List<Tag> get tags => _tags;

  Future<void> init() async {
    _store = await service.getStoreInfo();
    _status = _store!.status == "open" ? StoreStatus.open : StoreStatus.closed;
    _selectedTag = _store!.tag == null ? null : _store!.tag!.id;
    _tags = await service.getTags();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> switchStoreStatus() async {
    _isChangeLoading = true;
    notifyListeners();
    _status = await service.updateStoreStatus(_status!);
    _isChangeLoading = false;
    notifyListeners();
  }

  Future<void> selectTag(int tagId) async {
    _isChangeLoading = true;
    notifyListeners();
    _selectedTag = tagId;
    await service.updateStoreTag(tagId);
    _store = await service.getStoreInfo();
    _isChangeLoading = false;
    notifyListeners();
  }
}
