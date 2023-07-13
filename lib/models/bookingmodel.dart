class Booking{
  String id;
  dynamic price;
  String description;
  String companyId;
  String truckId;
  String serviceProviderId;
  bool serviceProviderCode;
  bool booked;
  double startLocationLa ;
  double startLocationLo ;
  double deliveryLocationLa ;
  double deliveryLocationLo ;

  Booking({
    required this.id,
    required this.description,
    required this.truckId,
    required this.booked,
    required this.companyId,
    required this.price,
    required this.serviceProviderCode,
    required this.serviceProviderId,
    required this.startLocationLa,
    required this.startLocationLo,
    required this.deliveryLocationLa,
    required this.deliveryLocationLo,
  });

  factory Booking.fromJson(Map<String,dynamic> json) =>
      Booking(
        id: json["_id"],
        price: json["price"],
        description: json["description"],
        companyId: json["customerId"],
        truckId: json["truckId"],
        serviceProviderId: json["service_providerId"],
        serviceProviderCode: json["service_providerCode"],
        booked: json["booked"],
        startLocationLa:  json['startLocation']['coordinates'][0],
        startLocationLo:  json['startLocation']['coordinates'][1],
        deliveryLocationLa:  json['deliveryLocation']['coordinates'][0],
        deliveryLocationLo:  json['deliveryLocation']['coordinates'][1],
      );

}