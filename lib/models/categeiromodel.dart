class GetEquipment{
  List<Equipment> equipment;
  GetEquipment({
    required this.equipment,
  });

  factory GetEquipment.fromJson(Map<String,dynamic> json) =>
      GetEquipment(
        equipment : List<Equipment>.from(json["trucks"].map((e) => Equipment.fromJson(e))),
      );

}

class CategoryModel{
  String id;
  String name;

  CategoryModel({
    required this.id,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String,dynamic> json) =>
      CategoryModel(
        id: json["_id"],
        name: json["name"],
      );
}

class SubCategory{
  String id;
  String name;


  SubCategory({
    required this.id,
    required this.name,
  });

  factory SubCategory.fromJson(Map<String,dynamic> json) =>
      SubCategory(
        id: json["_id"],
        name: json["name"],
      );
}

class Brand{
  String id;
  String name;


  Brand({
    required this.id,
    required this.name,
  });

  factory Brand.fromJson(Map<String,dynamic> json) =>
      Brand(
        id: json["_id"],
        name: json["name"],
      );
}

class Equipment{
  String id;
  String name;
  String description;
  String currentLocation;
  String brand;
  String category;
  DateTime createdAt;
  DateTime updatedAt;
  String imageCover;
  String userId ;

  Equipment({
    required this.id,
    required this.name,
    required this.description,
    required this.currentLocation,
    required this.brand,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.imageCover,
    required this.userId
  });

  factory Equipment.fromJson(Map<String,dynamic> json) =>
      Equipment(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        currentLocation: json["currentLocation"],
        brand: json["brand"],
        category: json["category"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        imageCover: json["imageCover"],
        userId: json["service_providerId"],
      );

}

class DetailsEquipment{
  List<dynamic> images;
  String name;
  String description;
  String currentLocation ;
  String brand;
  String category;
  DateTime createdAt;
  DateTime updatedAt;
  String imageCover;
  String truckId;
  List<Review> reviews;
  String userId ;

  DetailsEquipment({
    required this.images,
    required this.name,
    required this.description,
    required this.brand,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.imageCover,
    required this.truckId,
    required this.reviews,
    required this.userId,
    required this.currentLocation
  });

  factory DetailsEquipment.fromJson(Map<String,dynamic> json) =>
      DetailsEquipment(
        images: List<dynamic>.from(json["images"].map((x) => x)),
        name: json["name"],
        description: json["description"],
        currentLocation: json["currentLocation"],
        brand: json["brand"],
        category: json["category"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        imageCover: json["imageCover"],
        truckId: json["id"],
        userId: json["service_providerId"] ?? "",
        reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
      );
}

class Review {
  String id;
  String truck;

  Review({
    required this.id,
    required this.truck,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["_id"],
    truck: json["truck"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "truck": truck,
  };
}


class PostEquipment{
  String name;
  String description;
  String currentLocation;
  dynamic price;
  String brand;
  String subcategory;
  String category;
  String imageCover;
  String userId ;

  PostEquipment({
    required this.name,
    required this.description,
    required this.currentLocation,
    required this.price,
    required this.brand,
    required this.subcategory,
    required this.category,
    required this.imageCover,
    required this.userId
  });

  factory PostEquipment.fromJson(Map<String,dynamic> json) =>
      PostEquipment(
        name: json["name"],
        description: json["description"],
        currentLocation: json["currentLocation"],
        price: json["price"],
        brand: json["brand"],
        subcategory: json["subcategory"],
        category: json["category"],
        imageCover: json["imageCover"],
        userId: json["service_providerId"],
      );

}