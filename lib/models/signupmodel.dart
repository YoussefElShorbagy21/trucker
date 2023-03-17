class SignupModel {
  late String status ;
  late String token;

  SignupModel({
    required this.status,
    required this.token,
});

  factory SignupModel.fromJson(Map<String,dynamic> json) =>
      SignupModel(
        status: json['status'],
        token: json['token'] ?? '',
      );
}