
import 'package:almahbub_managment/domen/model/product_model.dart';
import 'package:hive/hive.dart';


class BannerModel extends HiveObject {
  final String image;
  final ProductModel product;

  BannerModel({required this.image, required this.product});

  factory BannerModel.fromJson({required Map<String,
      dynamic> data, required Map? dataProduct, required bool isLike, required String id}) {
    return BannerModel(
        image: data["image"],
        product: ProductModel.fromJson(
            data: dataProduct, isLike: isLike, id: id));
  }
}