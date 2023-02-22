
import 'package:almahbub_managment/domen/model/product_model/product_model.dart';
import 'package:hive/hive.dart';

part 'banner_model.g.dart';

@HiveType(typeId: 1)
class BannerModel extends HiveObject {
  @HiveField(0)
  final String image;
  @HiveField(1)
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