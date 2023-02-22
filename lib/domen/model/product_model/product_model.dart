import 'package:hive_flutter/hive_flutter.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends HiveObject {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? desc;
  @HiveField(2)
  final String? image;
  @HiveField(3)
  final num? price;
  @HiveField(4)
  final String? category;
  @HiveField(5)
  final String? type;
  @HiveField(6)
  final int? discount;
  @HiveField(7)
  final String? id;
  @HiveField(8)
  bool isLike;

  ProductModel(
      {required this.name,
      required this.desc,
      required this.image,
      required this.price,
      required this.category,
      required this.type,
      required this.isLike,
      required this.id,
      required this.discount});

  factory ProductModel.fromJson(
      {required Map? data, required bool? isLike, required String? id}) {
    return ProductModel(
      name: data?["name"],
      desc: data?["desc"],
      image: data?["image"],
      price: data?["price"],
      category: data?["category"],
      type: data?["type"],
      discount: data?["discount"],
      isLike: isLike ?? false,
      id: id,
    );
  }

  toJson() {
    return {
      "name": name,
      "desc": desc,
      "image": image,
      "price": price,
      "category": category,
      "type": type,
      "discount": discount
    };
  }
}
