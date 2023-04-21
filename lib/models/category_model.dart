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