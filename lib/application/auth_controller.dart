import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import '../infrastructure/firebase/firebase_repo.dart';
import '../infrastructure/model/user_model.dart';

class AuthController extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseRepo firebaseRepo = FirebaseRepo();
  UserModel? userModel;
  String docId = '';
  String phone = "";
  String? errorText;
  bool isLoading = false;

  login(String phone, String password, VoidCallback onSuccess) async {
    isLoading = true;
    errorText = null;
    notifyListeners();
    bool? check =
        await firebaseRepo.checkUser(phone: phone, password: password);
    if (check == true) {
      onSuccess();
    } else {
      errorText = "login_error".tr();
      isLoading = false;
      notifyListeners();
    }
  }
}
