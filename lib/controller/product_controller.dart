import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../model/product_model.dart';

class ProductController extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ImagePicker _image = ImagePicker();

  List<String> listOfCategory = [];
  List<String> listOfType = ["KG", "PC"];
  bool isLoading = true;
  bool isSaveLoading = false;
  bool isSaveCategoryLoading = false;
  String docId = '';
  String imagePath = "";
  String categoryImagePath = "";
  QuerySnapshot? res;
  int selectCategoryIndex = 0;
  int selectTypeIndex = 0;

  getCategory() async {
    isLoading = true;
    notifyListeners();
    res = await firestore.collection("category").get();
    listOfCategory.clear();
    res?.docs.forEach((element) {
      listOfCategory.add(element["name"]);
    });
    isLoading = false;
    notifyListeners();
  }

  getImageCamera() {
    _image.pickImage(source: ImageSource.camera).then((value) async {
      if (value != null) {
        CroppedFile? cropperImage =
            await ImageCropper().cropImage(sourcePath: value.path);
        imagePath = cropperImage?.path ?? "";
        notifyListeners();
      }
    });
    notifyListeners();
  }

  getImageGallery() {
    _image.pickImage(source: ImageSource.gallery).then((value) async {
      if (value != null) {
        CroppedFile? cropperImage =
            await ImageCropper().cropImage(sourcePath: value.path);
        imagePath = cropperImage?.path ?? "";
        notifyListeners();
      }
    });
    notifyListeners();
  }

  clearImage() {
    imagePath = '';
    notifyListeners();
  }

  setCategory(String category) {
    selectCategoryIndex = listOfCategory.indexOf(category);
  }

  setType(String type) {
    selectTypeIndex = listOfType.indexOf(type);
  }

  createProduct(
      {required String name,
      required String desc,
      required String price,
      required VoidCallback onSuccess}) async {
    isSaveLoading = true;
    notifyListeners();
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("productImage/${DateTime.now().toString()}");
    await storageRef.putFile(File(imagePath ?? ""));
    String url = await storageRef.getDownloadURL();

    await firestore.collection("products").add(ProductModel(
            name: name,
            desc: desc,
            image: url,
            price: double.tryParse(price) ?? 0,
            category: res?.docs[selectCategoryIndex].id,
            type: listOfType[selectTypeIndex])
        .toJson());
    onSuccess();
    isSaveLoading = false;
    notifyListeners();
  }

  addCategory({required String name, required VoidCallback onSuccess}) async {
    isSaveCategoryLoading = true;
    notifyListeners();
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("categoryImage/${DateTime.now().toString()}");
    await storageRef.putFile(File(categoryImagePath ?? ""));
    String url = await storageRef.getDownloadURL();
    print(url);
    await firestore.collection("category").add({"name": name, "image": url});
    onSuccess();
    isSaveCategoryLoading = false;
    notifyListeners();
  }

  addType({required String name, required VoidCallback onSuccess}) async {
    isSaveCategoryLoading = true;
    notifyListeners();
    listOfType.add(name);
    onSuccess();
    isSaveCategoryLoading = false;
    notifyListeners();
  }

  getCategoryImageCamera() {
    _image.pickImage(source: ImageSource.camera).then((value) async {
      if (value != null) {
        CroppedFile? cropperImage =
            await ImageCropper().cropImage(sourcePath: value.path);
        categoryImagePath = cropperImage?.path ?? "";
        notifyListeners();
      }
    });
    notifyListeners();
  }

  getCategoryImageGallery() {
    _image.pickImage(source: ImageSource.gallery).then((value) async {
      if (value != null) {
        CroppedFile? cropperImage =
            await ImageCropper().cropImage(sourcePath: value.path);
        categoryImagePath = cropperImage?.path ?? "";
        notifyListeners();
      }
    });
    notifyListeners();
  }

  clearCategoryImage() {
    categoryImagePath = '';
    notifyListeners();
  }
}
