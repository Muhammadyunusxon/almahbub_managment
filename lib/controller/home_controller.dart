import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../domen/model/banner_model/banner_model.dart';
import '../domen/model/category_model/category_model.dart';
import '../domen/model/product_model/product_model.dart';

import '../domen/model/user_model.dart';
import '../view/utils/constants.dart';
import 'local_store/local_store.dart';
import 'package:http/http.dart' as http;

class HomeController extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
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
  var lastVisible;

  checkInternet() {
    InternetConnectionChecker().onStatusChange.listen((event) {
      print(event.name);
      print(event.index);
    });
  }

  getUser() async {
    String? docId = await LocalStore.getDocId();
    var res = await firestore.collection("users").doc(docId).get();
    user = UserModel.fromJson(res.data());
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
        var res = await firestore
            .collection("products")
            .where("category", isEqualTo: listOfSelectCategory[i].id)
            .get();
        for (var element in res.docs) {
          listOfProduct.add(ProductModel.fromJson(
              data: element.data(),
              id: element.id,
              isLike: listOfLikes.contains(element.id)));
        }
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
    var response = await firestore.collection("banner").get();
    List<String> listOfLikes = await LocalStore.getLikes();
    listOfBanners.clear();
    for (int i = 0; i < response.docs.length; i++) {
      listOfBanners.add(BannerModel.fromJson(
        data: response.docs[i].data(),
        dataProduct:
            await getSingleProduct(response.docs[i].data()["productId"]),
        isLike: listOfLikes.contains(response.docs[i].id),
        id: response.docs[i].id,
      ));
    }
    _isLoading = false;
    notifyListeners();
  }

  getSingleProduct(String docId) async {
    var res = await firestore.collection("products").doc(docId).get();
    return res.data();
  }

  getCategory({bool isLimit = true}) async {
    isCategoryLoading = true;
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
    isCategoryLoading = false;
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

  getProduct({bool isLimit = true, bool isRefresh = false}) async {
    if (!isRefresh) {
      isProductLoading = true;
      notifyListeners();
    }
    if (isLimit) {
      productDocument = await firestore.collection("products").limit(8).get();
    } else {
      productDocument = await firestore.collection("products").get();
    }
    listOfProduct.clear();
    for (var element in productDocument!.docs) {
      List<String> listOfLikes = await LocalStore.getLikes();
      ProductModel product = ProductModel.fromJson(
          data: element.data(),
          isLike: listOfLikes.contains(element.id),
          id: element.id);
      listOfProduct.add(product);
    }
    isProductLoading = false;
    notifyListeners();
  }

  getProductNew() async {
    try {
      var endVisible = (productDocument?.docs as List).last;
      final res = await firestore
          .collection("products")
          .startAfterDocument(endVisible)
          .limit(4)
          .get();
      if (endVisible.id == res.docs[(res.size ?? 1) - 1].id) {
        return null;
      }
      return res;
    } catch (e) {
      return null;
    }
  }

  getPageProduct(RefreshController controller) async {
    var res = await getProductNew();
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
      ;
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
    listOfCategoryProduct.clear();
    var res = await firestore
        .collection("products")
        .where("category", isEqualTo: model.id)
        .get();
    List listOfLikes = await LocalStore.getLikes();
    for (var element in res.docs) {
      listOfCategoryProduct.add(ProductModel.fromJson(
          data: element.data(),
          id: element.id,
          isLike: listOfLikes.contains(element.id)));
    }
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
    var productLink = 'https://almahbub.uz/${productModel.id}';

    const dynamicLink =
        'https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=AIzaSyCXcimBLVVJlM1gR-tagukC_A9iwq4MidQ';

    final dataShare = {
      "dynamicLinkInfo": {
        "domainUriPrefix": 'https://almahbub.page.link',
        "link": productLink,
        "androidInfo": {
          "androidPackageName": 'uz.demos.almahbub_managment',
        },
        "iosInfo": {
          "iosBundleId": "uz.demos.almahbub_managment",
        },
        "socialMetaTagInfo": {
          "socialTitle":
              (productModel.name?.substring(0, 1).toUpperCase() ?? "") +
                  (productModel.name?.substring(1) ?? ""),
          "socialDescription": "Description: ${productModel.desc}",
          "socialImageLink": "${productModel.image}",
        }
      }
    };

    final res =
        await http.post(Uri.parse(dynamicLink), body: jsonEncode(dataShare));

    var shareLink = jsonDecode(res.body)['shortLink'];
    await FlutterShare.share(
      text: (productModel.name?.substring(0, 1).toUpperCase() ?? "") +
          (productModel.name?.substring(1) ?? ""),
      title: "Description: ${productModel.desc}",
      linkUrl: shareLink,
    );
    Fluttertoast.cancel();
    debugPrint(shareLink);
  }

  initDynamicLinks(ValueChanged onSuccess) async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      debugPrint('dynamic link ${dynamicLinkData.link}');
      String docId = dynamicLinkData.link
          .toString()
          .substring(dynamicLinkData.link.toString().lastIndexOf("/") + 1);
      onSuccess(docId);
    }).onError((error) {
      debugPrint("Dynamic link error${error.message}");
    });

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      String docId = deepLink
          .toString()
          .substring(deepLink.toString().lastIndexOf("/") + 1);
      // ignore: use_build_context_synchronously
      onSuccess(docId);
    }
  }

  bool get isTotalLoading =>
      _isLoading || isCategoryLoading || isProductLoading;
}
