import '../shared/resources/asset_manager.dart';

class CategoryModel {
  String? image;
  String? category;

  CategoryModel({this.image, this.category});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['image'] = image;
    data['category'] = category;
    return data;
  }
}

final categoryList = [
  CategoryModel(
    image: ImageAssets.kTruck,
    category: "Truck",
  ),
  CategoryModel(
    image: ImageAssets.kLoader,
    category: "Loader",
  ),
  CategoryModel(
    image: ImageAssets.kDigger,
    category: "Digger",
  ),
  CategoryModel(
    image: ImageAssets.kCrane,
    category: "Crane",
  ),
  CategoryModel(
    image: ImageAssets.kCompactor,
    category: "Compactor",
  ),
  CategoryModel(
    image: ImageAssets.kLoader,
    category: "Loader",
  ),
  CategoryModel(
    image: ImageAssets.kDigger,
    category: "Digger",
  ),
  CategoryModel(
    image: ImageAssets.kLoader,
    category: "Loader",
  ),
  CategoryModel(
    image: ImageAssets.kLoader,
    category: "Loader",
  ),
  CategoryModel(
    image: ImageAssets.kDigger,
    category: "Digger",
  ),
  CategoryModel(
    image: ImageAssets.kCrane,
    category: "Crane",
  ),
  CategoryModel(
    image: ImageAssets.kCrane,
    category: "Crane",
  ),
  CategoryModel(
    image: ImageAssets.kTruck,
    category: "Truck",
  ),
];