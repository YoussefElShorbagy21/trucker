class ReviewModel{
  String id;
  String title;
  String customerId;
  String truck;
  String serviceProviderId;
  dynamic ratingAverage ;


  ReviewModel({
    required this.id,
    required this.truck,
    required this.customerId,
    required this.serviceProviderId,
    required this.title,
    required this.ratingAverage
  });

  factory ReviewModel.fromJson(Map<String,dynamic> json) =>
      ReviewModel(
        id: json["_id"],
        title: json["title"],
        customerId: json["customerId"],
        truck: json["truck"],
        serviceProviderId: json["service_providerId"],
        ratingAverage: json["ratingAverage"],
      );

}