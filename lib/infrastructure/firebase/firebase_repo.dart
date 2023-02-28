import 'dart:convert';

import 'package:almahbub_managment/infrastructure/model/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

import '../model/banner_model.dart';
import '../model/product_model.dart';
import '../model/user_model.dart';
import '../service/local_store/local_store.dart';
import 'package:http/http.dart' as http;

class FirebaseRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  checkUser({required String phone, required String password}) async {
    try {
      var res = await firestore
          .collection("users")
          .where("phone", isEqualTo: phone)
          .get();
      if (res.docs.first["password"] == password) {
        LocalStore.setDocId(res.docs.first.id);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('$e');
      return false;
    }
  }

  getUser() async {
    String? docId = await LocalStore.getDocId();
    var res = await firestore.collection("users").doc(docId).get();
    return UserModel.fromJson(res.data());
  }

  getSingleProduct(String docId) async {
    var res = await firestore.collection("products").doc(docId).get();
    return res.data();
  }

  getBanners() async {
    try {
      var response = await firestore.collection("banner").get();
      List<BannerModel> list = [];
      List<String> listOfLikes = await LocalStore.getLikes();
      for (int i = 0; i < response.docs.length; i++) {
        list.add(BannerModel.fromJson(
          data: response.docs[i].data(),
          dataProduct:
              await getSingleProduct(response.docs[i].data()["productId"]),
          isLike: listOfLikes.contains(response.docs[i].id),
          id: response.docs[i].id,
        ));
        return list;
      }
    } catch (e) {
      debugPrint("$e");
      return null;
    }
  }

  getCategory() async {
    dynamic res;

    res = await firestore.collection("category").get();
    List<CategoryModel> list = [];
    for (var element in res.docs) {
      list.add(CategoryModel.fromJson(element.data(), element.id));
    }
    return list;
  }

  searchProduct(String name) async {
    List<ProductModel> list = [];
    var res = await firestore.collection("products").orderBy("name").startAt(
        [name.toLowerCase()]).endAt(["${name.toLowerCase()}\uf8ff"]).get();
    for (var element in res.docs) {
      List<String> listOfLikes = await LocalStore.getLikes();
      list.add(ProductModel.fromJson(
          data: element.data(),
          isLike: listOfLikes.contains(element.id),
          id: element.id));
    }
    return list;
  }

  searchCategory(String name) async {
    List<CategoryModel> list = [];
    var res = await firestore.collection("category").orderBy("name").startAt(
        [name.toLowerCase()]).endAt(["${name.toLowerCase()}\uf8ff"]).get();
    for (var element in res.docs) {
      list.add(CategoryModel.fromJson(element.data(), element.id));
    }
    return list;
  }

  getChangeCategory(
      {required String? docId, required List<String> listOfLikes}) async {
    var res = await firestore
        .collection("products")
        .where("category", isEqualTo: docId)
        .get();
    for (var element in res.docs) {
      return ProductModel.fromJson(
          data: element.data(),
          id: element.id,
          isLike: listOfLikes.contains(element.id));
    }
  }

  getOneCategoryProduct({required String? docId}) async {
    try {
      var res = await firestore
          .collection("products")
          .where("category", isEqualTo: docId)
          .get();
      List<ProductModel> list = [];
      List listOfLikes = await LocalStore.getLikes();
      for (var element in res.docs) {
        list.add(ProductModel.fromJson(
            data: element.data(),
            id: element.id,
            isLike: listOfLikes.contains(element.id)));
      }
      return list;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getProductDocument({required bool isLimit}) async {
    try {
      if (isLimit) {
        return await firestore.collection("products").limit(8).get();
      } else {
        return await firestore.collection("products").get();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getProduct({required var productDocument}) async {
    List<ProductModel> list = [];
    for (var element in productDocument!.docs) {
      List<String> listOfLikes = await LocalStore.getLikes();
      ProductModel product = ProductModel.fromJson(
          data: element.data(),
          isLike: listOfLikes.contains(element.id),
          id: element.id);
      list.add(product);
    }
    return list;
  }

  getProductNew({required productDocument}) async {
    try {
      var endVisible = (productDocument?.docs as List).last;
      final res = await firestore
          .collection("products")
          .startAfterDocument(endVisible)
          .limit(4)
          .get();
      if (endVisible.id == res.docs[(res.size) - 1].id) {
        return null;
      }
      return res;
    } catch (e) {
      return null;
    }
  }

  createDynamicLink(ProductModel productModel) async {
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
}
