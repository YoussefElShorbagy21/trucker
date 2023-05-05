class GetEquipment{
  List<Equipment> equipment;
  int results ;
  GetEquipment({
    required this.equipment,
    required this.results,
  });

  factory GetEquipment.fromJson(Map<String,dynamic> json) =>
      GetEquipment(
        results: json['results'],
          equipment : List<Equipment>.from(json["equipment"].map((e) => Equipment.fromJson(e))),
      );

}

class PostEquipment{
  Equipment equipment;
  String status ;

  PostEquipment({
    required this.equipment,
    required this.status,
  });

  factory PostEquipment.fromJson(Map<String,dynamic> json) =>
      PostEquipment(
          status: json['status'],
          equipment : Equipment.fromJson(json['newEquipment']),
      );
}

class GetDetailsEquipment{
  Equipment equipment;
  GetDetailsEquipment({
    required this.equipment,
  });

  factory GetDetailsEquipment.fromJson(Map<String,dynamic> json) =>
      GetDetailsEquipment(
        equipment : Equipment.fromJson(json['oneEquipment']),
      );

}

class Equipment{
  String id;
  String title ;
  String description;
  String photo;
  dynamic price ;
  String category ;
  String government;
  String userId;

  Equipment({
    required this.id,
    required  this.description,
    required this.photo,
    required  this.price,
    required  this.title,
    required  this.category,
    required  this.government,
    required  this.userId,
  });

  factory Equipment.fromJson(Map<String,dynamic> json) =>
      Equipment(
        id: json['_id']?? '',
        title: json['title']?? '',
        description: json['description']?? '',
        photo: json['photo']?? '',
        price: json['price']?? '',
        government: json['government']?? '',
        userId: json['userId'] ?? '',
        category: json['category'] ?? '',
      );

}