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
  List<dynamic> images;
  int ratingCount;
  String id;
  String name;
  String description;
  String locationFrom;
  String locationTo;
  dynamic price;
  dynamic priceAfterDiscount;
  String brand;
  String subcategory;
  String category;
  DateTime createdAt;
  DateTime updatedAt;
  String imageCover;
  String truckId;
  String userId ;

  Equipment({
    required this.images,
    required this.ratingCount,
    required this.id,
    required this.name,
    required this.description,
    required this.locationFrom,
    required this.locationTo,
    required this.price,
    required this.priceAfterDiscount,
    required this.brand,
    required this.subcategory,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.imageCover,
    required this.truckId,
    required this.userId
  });

  factory Equipment.fromJson(Map<String,dynamic> json) =>
      Equipment(
        images: List<dynamic>.from(json["images"].map((x) => x)),
        ratingCount: json["ratingCount"],
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        locationFrom: json["locationFrom"],
        locationTo: json["locationTo"],
        price: json["price"],
        priceAfterDiscount: json["priceAfterDiscount"],
        brand: json["brand"],
        subcategory: json["subcategory"],
        category: json["category"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        imageCover: json["imageCover"],
        truckId: json["id"],
        userId: json["userId"] ?? "",
      );

}

class DetailsEquipment{
  List<dynamic> images;
  int ratingCount;
  String id;
  String name;
  String description;
  String locationFrom;
  String locationTo;
  int price;
  double priceAfterDiscount;
  String brand;
  String subcategory;
  String category;
  DateTime createdAt;
  DateTime updatedAt;
  String imageCover;
  String truckId;
  List<Review> reviews;
  String userId ;

  DetailsEquipment({
    required this.images,
    required this.ratingCount,
    required this.id,
    required this.name,
    required this.description,
    required this.locationFrom,
    required this.locationTo,
    required this.price,
    required this.priceAfterDiscount,
    required this.brand,
    required this.subcategory,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.imageCover,
    required this.truckId,
    required this.reviews,
    required this.userId
  });

  factory DetailsEquipment.fromJson(Map<String,dynamic> json) =>
      DetailsEquipment(
        images: List<dynamic>.from(json["images"].map((x) => x)),
        ratingCount: json["ratingCount"],
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        locationFrom: json["locationFrom"],
        locationTo: json["locationTo"],
        price: json["price"],
        priceAfterDiscount: json["priceAfterDiscount"]?.toDouble(),
        brand: json["brand"],
        subcategory: json["subcategory"],
        category: json["category"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        imageCover: json["imageCover"],
        truckId: json["id"],
        userId: json["userId"] ?? "",
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
  String locationFrom;
  String locationTo;
  dynamic price;
  dynamic priceAfterDiscount;
  String brand;
  String subcategory;
  String category;
  String imageCover;
  String userId ;

  PostEquipment({
    required this.name,
    required this.description,
    required this.locationFrom,
    required this.locationTo,
    required this.price,
    required this.priceAfterDiscount,
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
        locationFrom: json["locationFrom"],
        locationTo: json["locationTo"],
        price: json["price"],
        priceAfterDiscount: json["priceAfterDiscount"],
        brand: json["brand"],
        subcategory: json["subcategory"],
        category: json["category"],
        imageCover: json["imageCover"],
        userId: json["userId"],
      );

}
