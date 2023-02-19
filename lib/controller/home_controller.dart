import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../model/banner_model.dart';
import '../model/category_model.dart';
import '../model/product_model.dart';

import '../model/user_model.dart';
import 'local_store/local_store.dart';

class HomeController extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserModel? user;
  List<BannerModel> listOfBanners = [];
  List<ProductModel> listOfProduct = [];
  List<ProductModel> listOfFavouriteProduct = [];
  List<CategoryModel> listOfCategory = [];
  bool _isLoading = true;
  bool setFilter = false;
  bool _isCategoryLoading = true;
  bool _isProductLoading = true;
  List<CategoryModel> listOfSelectIndex = [];

  getUser() async {
    String? docId = await LocalStore.getDocId();
    var res = await firestore.collection("users").doc(docId).get();
    user = UserModel.fromJson(res.data());
  }

  changeLike({required int index, bool isFav = false}) async {
    if (isFav) {
      listOfFavouriteProduct[index].isLike =
          !listOfFavouriteProduct[index].isLike;
    } else {
      listOfProduct[index].isLike = !listOfProduct[index].isLike;
    }
    notifyListeners();
    if (isFav
        ? listOfFavouriteProduct[index].isLike
        : listOfProduct[index].isLike) {
      LocalStore.setLikes(listOfFavouriteProduct[index].id ?? " ");
    } else {
      LocalStore.removeLikes(listOfProduct[index].id ?? " ");
    }
    notifyListeners();
  }

  changeIndex(CategoryModel model) async {
    if (listOfSelectIndex.contains(model)) {
      listOfSelectIndex.remove(model);
      getProduct(isLimit: false);
    } else {
      setFilter = true;
      listOfSelectIndex.add(model);
      listOfProduct.clear();
      List<String> listOfLikes = await LocalStore.getLikes();
      for (int i = 0; i < listOfSelectIndex.length; i++) {
        var res = await firestore
            .collection("products")
            .where("category", isEqualTo: listOfSelectIndex[i].id)
            .get();
        for (var element in res.docs) {
          listOfProduct.add(ProductModel.fromJson(
              data: element.data(),
              id: element.id,
              isLike: listOfLikes.contains(element.id)));
        }
      }
    }
    if (listOfSelectIndex.isEmpty) {
      setFilter = false;
    }

    notifyListeners();
  }

  setFilterChange() {
    setFilter = !setFilter;
    notifyListeners();
  }

  getBanners() async {
    _isLoading = true;
    notifyListeners();
    var res = await firestore.collection("banner").get();
    List<String> listOfLikes = await LocalStore.getLikes();
    listOfBanners.clear();
    for (var element in res.docs) {
      String docId = element.data()["productId"];
      var res = await firestore.collection("products").doc(docId.replaceAll(" ", "")).get();
      listOfBanners.add(BannerModel.fromJson(
        data: element.data(),
        dataProduct: res.data(),
        isLike: listOfLikes.contains(element.id),
        id: element.id,
      ));
    }
    _isLoading = false;
    notifyListeners();
  }

  getCategory({bool isLimit = true}) async {
    _isCategoryLoading = true;
    notifyListeners();
    dynamic res;
    if (isLimit) {
      res = await firestore.collection("category").limit(7).get();
    } else {
      res = await firestore.collection("category").get();
    }
    listOfCategory.clear();
    for (var element in res.docs) {
      listOfCategory.add(CategoryModel.fromJson(element.data(), element.id));
    }
    _isCategoryLoading = false;
    notifyListeners();
  }

  searchCategory(String name) async {
    var res = await firestore.collection("category").orderBy("name").startAt(
        [name.toLowerCase()]).endAt(["${name.toLowerCase()}\uf8ff"]).get();
    listOfCategory.clear();
    for (var element in res.docs) {
      listOfCategory.add(CategoryModel.fromJson(element.data(), element.id));
    }
    notifyListeners();
  }

  searchProduct(String name) async {
    var res = await firestore.collection("products").orderBy("name").startAt(
        [name.toLowerCase()]).endAt(["${name.toLowerCase()}\uf8ff"]).get();
    listOfProduct.clear();
    for (var element in res.docs) {
      List<String> listOfLikes = await LocalStore.getLikes();
      listOfProduct.add(ProductModel.fromJson(
          data: element.data(),
          isLike: listOfLikes.contains(element.id),
          id: element.id));
    }
    notifyListeners();
  }

  getProduct({bool isLimit = true}) async {
    _isProductLoading = true;
    notifyListeners();
    QuerySnapshot<Map<String, dynamic>> res;
    if (isLimit) {
      res = await firestore.collection("products").limit(40).get();
    } else {
      res = await firestore.collection("products").get();
    }
    listOfProduct.clear();
    for (var element in res.docs) {
      List<String> listOfLikes = await LocalStore.getLikes();
      listOfProduct.add(ProductModel.fromJson(
          data: element.data(),
          isLike: listOfLikes.contains(element.id),
          id: element.id));
    }
    _isProductLoading = false;
    notifyListeners();
  }

  getFavourites() {
    // ignore: avoid_function_literals_in_foreach_calls
    listOfFavouriteProduct.clear();
    for (var element in listOfProduct) {
      element.isLike == true
          ? listOfFavouriteProduct.add(element)
          : element.isLike = false;
    }
    notifyListeners();
  }



  bool get isTotalLoading =>
      _isLoading || _isCategoryLoading || _isProductLoading;
}
