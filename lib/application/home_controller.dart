import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../infrastructure/firebase/firebase_repo.dart';
import '../infrastructure/model/banner_model.dart';
import '../infrastructure/model/category_model.dart';
import '../infrastructure/model/product_model.dart';
import '../infrastructure/model/user_model.dart';
import '../infrastructure/service/local_store/local_store.dart';
import '../presentation/utils/constants.dart';

class HomeController extends ChangeNotifier {
  FirebaseRepo firebaseRepo = FirebaseRepo();

  UserModel? user;
  List<BannerModel> listOfBanners = [];
  List<ProductModel> listOfProduct = [];
  List<ProductModel> listOfFavouriteProduct = [];
  List<ProductModel> listOfCategoryProduct = [];
  List<CategoryModel> listOfCategory = [];
  bool _isLoading = true;
  bool setFilter = false;
  bool isCategoryLoading = true;
  bool isProductLoading = true;
  List<CategoryModel> listOfSelectCategory = [];
  bool isSingleProductLoading = false;
  ProductModel? singleProduct;

  List<String> listOfPrice = [
    "\$",
    "\$\$",
    "\$\$\$",
  ];
  int selectPrice = -1;

  // ignore: prefer_typing_uninitialized_variables
  var productDocument;
  bool isLoadingProduct = false;

  checkInternet() {
    InternetConnectionChecker().onStatusChange.listen((event) {});
  }

  getUser() async {
    user = await firebaseRepo.getUser();
    notifyListeners();
  }

  changeLike(
      {required int index,
      bool isFav = false,
      bool isCategory = false,
      ProductModel? product}) async {
    if (product != null) {
      index = listOfProduct.indexOf(product);
      isFav = false;
      isCategory = false;
      notifyListeners();
    }
    if (isFav) {
      listOfFavouriteProduct[index].isLike =
          !listOfFavouriteProduct[index].isLike;
      if (listOfFavouriteProduct[index].isLike) {
        LocalStore.setLikes(listOfFavouriteProduct[index].id ?? " ");
      } else {
        LocalStore.removeLikes(listOfFavouriteProduct[index].id ?? " ");
      }
    } else if (isCategory) {
      listOfCategoryProduct[index].isLike =
          !listOfCategoryProduct[index].isLike;
      if (listOfCategoryProduct[index].isLike) {
        LocalStore.setLikes(listOfCategoryProduct[index].id ?? " ");
      } else {
        LocalStore.removeLikes(listOfCategoryProduct[index].id ?? " ");
      }
    } else {
      listOfProduct[index].isLike = !listOfProduct[index].isLike;
      if (listOfProduct[index].isLike) {
        LocalStore.setLikes(listOfProduct[index].id ?? " ");
      } else {
        LocalStore.removeLikes(listOfProduct[index].id ?? " ");
      }
    }
    notifyListeners();
  }

  changePriceIndex(int index) {
    if (selectPrice == index) {
      selectPrice = -1;
    } else {
      selectPrice = index;
    }
    notifyListeners();
  }

  getSingleProduct(String docId) async =>
      await firebaseRepo.getSingleProduct(docId);

  changeCategoryIndex(CategoryModel model) async {
    if (listOfSelectCategory.contains(model)) {
      listOfSelectCategory.remove(model);
      getProduct();
    } else {
      setFilter = true;
      listOfSelectCategory.add(model);
      listOfProduct.clear();
      List<String> listOfLikes = await LocalStore.getLikes();
      for (int i = 0; i < listOfSelectCategory.length; i++) {
        listOfProduct.add(firebaseRepo.getChangeCategory(
            docId: listOfSelectCategory[i].id, listOfLikes: listOfLikes));
      }
    }
    if (listOfSelectCategory.isEmpty) {
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
    listOfBanners = await firebaseRepo.getBanners();
    _isLoading = false;
    notifyListeners();
  }

  getCategory() async {
    isCategoryLoading = true;
    notifyListeners();
    listOfCategory = await firebaseRepo.getCategory();
    isCategoryLoading = false;
    notifyListeners();
  }

  searchCategory(String name) async {
    listOfCategory = await firebaseRepo.searchCategory(name);
    notifyListeners();
  }

  searchProduct(String name) async {
    listOfProduct = await firebaseRepo.searchProduct(name);
    notifyListeners();
  }

  getProduct({bool isRefresh = false}) async {
    if (!isRefresh) {
      isProductLoading = true;
      notifyListeners();
    }

    productDocument = await firebaseRepo.getProductDocument();

    listOfProduct =
        await firebaseRepo.getProduct(productDocument: productDocument);

    isProductLoading = false;
    notifyListeners();
  }

  getPageProduct(RefreshController controller) async {
    var res =
        await firebaseRepo.getProductNew(productDocument: productDocument);
    if (res == null) {
      controller.loadNoData();
    } else if (res.docs != null && res.docs.isNotEmpty) {
      productDocument = res;
      for (var element in productDocument.docs) {
        List<String> listOfLikes = await LocalStore.getLikes();
        ProductModel product = ProductModel.fromJson(
            data: element.data(),
            isLike: listOfLikes.contains(element.id),
            id: element.id);
        listOfProduct.add(product);
      }
      controller.loadComplete();
    } else {
      controller.loadNoData();
    }
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

  deleteProduct({required String docId, required String image}) async {
    print(docId);
    print(image);
    print(image.substring(
        image.indexOf("productImage") + 13, image.indexOf("?alt")));

    //  LocalStore.removeLikes(docId);
    //  listOfProduct.removeWhere((element) => element.id == docId);
    var store = FirebaseStorage.instance.ref().child("productImage/$image");

    print(store.name);
    notifyListeners();
  }

  changeSingleProduct(ProductModel newProduct) {
    singleProduct = newProduct;
    notifyListeners();
  }

  getOneCategory(CategoryModel model) async {
    isCategoryLoading = true;
    notifyListeners();
    firebaseRepo.getOneCategoryProduct(docId: model.id);
    isCategoryLoading = false;
    notifyListeners();
  }

  createDynamicLink(ProductModel productModel) async {
    Fluttertoast.showToast(
        msg: "Ulashilmoqda",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: kMediumColor,
        textColor: kTextDarkColor,
        fontSize: 16.0);
    firebaseRepo.createDynamicLink(productModel);
    Fluttertoast.cancel();
  }

  initDynamicLinks(ValueChanged onSuccess) async {
    firebaseRepo.initDynamicLinks(onSuccess);
  }

  bool get isTotalLoading =>
      _isLoading || isCategoryLoading || isProductLoading;
}
