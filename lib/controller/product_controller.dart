import 'dart:io';

import 'package:almahbub_managment/controller/local_store/local_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../model/product_model.dart';

class ProductController extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ImagePicker _image = ImagePicker();

  List<String> listOfCategory = [];
  List<String> listOfType = [];
  bool isLoading = true;
  bool isSaveLoading = false;
  bool isSaveCategoryLoading = false;
  String docId = '';
  String imagePath = "";
  String categoryImagePath = "";
  QuerySnapshot? res;
  int selectCategoryIndex = 0;
  int selectTypeIndex = 0;
  bool addError=false;

  getCategory() async {
    isLoading = true;
    notifyListeners();
    res = await firestore.collection("category").get();
    listOfCategory.clear();
    if (res != null) {
      for (var element in res!.docs) {
        listOfCategory.add(element["name"]);
      }
    }
    listOfType = await LocalStore.getType();
    isLoading = false;
    notifyListeners();
  }
  Future<Uint8List?> testCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 800,
      minHeight: 800,
      quality: 70,
      rotate: 60,
    );
    print(file.lengthSync());
    print(result?.length);
    return result;
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
        testCompressFile(File(imagePath));
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
      required String discount,
      required VoidCallback onSuccess}) async {
    isSaveLoading = true;
    notifyListeners();
    if(imagePath.isNotEmpty && name.isNotEmpty && price.isNotEmpty && int.tryParse(discount) !=null ){
      final storageRef = FirebaseStorage.instance
          .ref()
          .child("productImage/${DateTime.now().toString()}");
      await storageRef.putFile(File(imagePath));
      String url = await storageRef.getDownloadURL();
      await firestore.collection("products").add(ProductModel(
          name: name.toLowerCase(),
          desc: desc,
          image: url,
          price: double.tryParse(price) ?? 0,
          category: res?.docs[selectCategoryIndex].id,
          type: listOfType[selectTypeIndex],
          isLike: false, discount: int.tryParse(discount))
          .toJson());
      onSuccess();
      clearImage();
      addError=false;
    }else{
      addError=true;
    }
    isSaveLoading = false;
    notifyListeners();
  }

  addCategory({required String name, required VoidCallback onSuccess}) async {
    isSaveCategoryLoading = true;
    notifyListeners();
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("categoryImage/${DateTime.now().toString()}");
    await storageRef.putFile(File(categoryImagePath));
    String url = await storageRef.getDownloadURL();
      debugPrint(url);
    await firestore.collection("category").add({"name": name, "image": url});
    onSuccess();
    clearCategoryImage();
    isSaveCategoryLoading = false;
    notifyListeners();
  }

  addType({required String name, required VoidCallback onSuccess}) async {
    isSaveCategoryLoading = true;
    notifyListeners();
    listOfType.add(name);
    LocalStore.setType(name);
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
