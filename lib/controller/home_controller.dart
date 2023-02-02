import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


import '../model/banner_model.dart';
import '../model/category_model.dart';
import '../model/product_model.dart';

class HomeController extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<BannerModel> listOfBanners = [];
  List<ProductModel> listOfProduct = [];
  List<CategoryModel> listOfCategory = [];
  bool _isLoading = true;
  bool _isCategoryLoading = true;
  bool _isProductLoading = true;

  getBanners() async {
    _isLoading = true;
    notifyListeners();
    var res = await firestore.collection("banner").get();
    listOfBanners.clear();
    for (var element in res.docs) {
      String docId = element.data()["productId"];
      var res = await firestore
          .collection("products")
          .doc(docId.replaceAll(" ", ""))
          .get();
      listOfBanners.add(
          BannerModel.fromJson(data: element.data(), dataProduct: res.data()));
    }
    _isLoading = false;
    notifyListeners();
  }

  getCategory({bool isLimit = true}) async {
    _isCategoryLoading = true;
    notifyListeners();
    dynamic res;
    if (isLimit) {
      res = await firestore.collection("category").limit(5).get();
    } else {
      res = await firestore.collection("category").get();
    }
    listOfCategory.clear();
    for (var element in res.docs) {
      listOfCategory.add(CategoryModel.fromJson(element.data()));
    }
    _isCategoryLoading = false;
    notifyListeners();
  }

  searchCategory(String name) async {
    var res = await firestore.collection("category").orderBy("name").startAt(
        [name.toLowerCase()]).endAt(["${name.toLowerCase()}\uf8ff"]).get();
    listOfCategory.clear();
    for (var element in res.docs) {
      listOfCategory.add(CategoryModel.fromJson(element.data()));
    }
    notifyListeners();
  }

  getProduct() async {
    _isProductLoading = true;
    notifyListeners();
    var res = await firestore.collection("products").get();
    listOfProduct.clear();
    for (var element in res.docs) {
      listOfProduct.add(ProductModel.fromJson(element.data()));
    }
    _isProductLoading = false;
    notifyListeners();
  }

  bool get isTotalLoading =>
      _isLoading || _isCategoryLoading || _isProductLoading;
}