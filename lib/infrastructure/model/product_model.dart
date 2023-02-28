


class ProductModel {
  final String? name;
  final String? desc;
  final String? image;
  final num? price;
  final String? category;
  final String? type;
  final int? discount;
  final String? id;
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
