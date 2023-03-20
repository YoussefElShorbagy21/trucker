class SignupModel {
  late String status ;
  late String token;
  UserSignupModel userSignupModel;

  SignupModel({
    required this.status,
    required this.token,
    required this.userSignupModel,
});

  factory SignupModel.fromJson(Map<String,dynamic> json) =>
      SignupModel(
        status: json['status'],
        token: json['token'] ?? '',
        userSignupModel: UserSignupModel.fromJson(json["user"]),
      );
}

class UserSignupModel {
  late String id ;
  late String token;

  UserSignupModel({
    required this.id,

  });

  factory UserSignupModel.fromJson(Map<String,dynamic> json) =>
      UserSignupModel(
        id: json['_id'],
      );
}