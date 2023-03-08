import 'package:flutter/material.dart';

class AppController extends ChangeNotifier {
  bool? isOnline;
  bool isReverse=false;

  changeOnline(bool? isOnline){
      this.isOnline=isOnline;
      notifyListeners();
  }

  changeReverse(bool isReverse){
    this.isReverse=isReverse;
    notifyListeners();
  }
}