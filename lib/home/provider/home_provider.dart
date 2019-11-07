import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  Map _data = Map();
  Map get data => _data;

  void setData(Map content) {
    _data = content['data'];
    notifyListeners();
  }
}
