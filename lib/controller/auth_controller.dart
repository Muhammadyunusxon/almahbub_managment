import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../../controller/local_store/local_store.dart';
import '../../../model/user_model.dart';

class AuthController extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserModel? userModel;
  String docId = '';
  String phone = "";
  String? errorText;
  bool isLoading = false;

  Future<bool> checkPhone(String phone) async {
    try {
      var res = await firestore
          .collection("users")
          .where("phone", isEqualTo: phone)
          .get();
      if (res.docs.first != null) {
        return true;
      } else {
        docId=res.docs.first.id;
        return false;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  login(String phone, String password, VoidCallback onSuccess) async {
    isLoading = true;
    errorText = null;
    notifyListeners();
    try {
      var res = await firestore
          .collection("users")
          .where("phone", isEqualTo: phone)
          .get();
      if (res.docs.first["password"] == password) {
        LocalStore.setDocId(res.docs.first.id);
        onSuccess();
        isLoading = false;
        notifyListeners();
      } else {
        errorText =
        "Telefon raqam yoki parol xato";
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      errorText =
      "Telefon raqam yoki parol xato";
      isLoading = false;
      notifyListeners();
    }
  }





}
