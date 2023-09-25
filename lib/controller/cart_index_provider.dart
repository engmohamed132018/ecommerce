import 'package:flutter/material.dart';

class IndexProvider with ChangeNotifier {
  int index = 0;
  void changeIndex(int index) {
    this.index = index;
    notifyListeners();
  }
}
