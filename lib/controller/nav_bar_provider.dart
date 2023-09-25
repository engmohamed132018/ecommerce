import 'package:flutter/material.dart';

class NavBarProvider with ChangeNotifier {
  int index = 0;
  changvalue({required int index}) {
    this.index = index;
    notifyListeners();
  }
}
