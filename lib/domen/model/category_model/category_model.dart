import 'package:hive/hive.dart';

part 'category_model.g.dart';

@HiveType(typeId: 2)
class CategoryModel extends HiveObject {
  CategoryModel({
    
    this.name,
    this.image,
    this.id,
  });
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? image;
  @HiveField(2)
  String? id;

  factory CategoryModel.fromJson( Map<String, dynamic> json,String id) => CategoryModel(
      name: json["name"],
      image: json["image"],
      id: id
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
  };
}
