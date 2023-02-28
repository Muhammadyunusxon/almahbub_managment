class CategoryModel {
  CategoryModel({this.name, this.image, this.id});

  String? name;
  String? image;
  String? id;

  factory CategoryModel.fromJson(Map<String, dynamic> json, String id) =>
      CategoryModel(name: json["name"], image: json["image"], id: id);

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
      };
}
