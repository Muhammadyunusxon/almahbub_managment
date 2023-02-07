import 'package:flutter/material.dart';

class AppController extends ChangeNotifier {
  bool? isOnline;

  changeOnline(bool? isOnline){
      this.isOnline=isOnline;
      notifyListeners();
  }
}