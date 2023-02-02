import 'package:almahbub_managment/model/product_model.dart';

class BannerModel {
  final String image;
  final ProductModel product;

  BannerModel({required this.image, required this.product});

  factory BannerModel.fromJson(
      {required Map<String, dynamic> data, required Map? dataProduct}) {
    return BannerModel(
        image: data["image"], product: ProductModel.fromJson(dataProduct));
  }
}