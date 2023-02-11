class SignupModel {
  late String status ;
  late String token;
  NewUser? newUser ;
  late String message ;

  SignupModel({
    required this.status,
    required this.token,
    required this.message,
    required this.newUser
});

  factory SignupModel.fromJson(Map<String,dynamic> json) =>
      SignupModel(
        status: json['status'],
        token: json['token'] ?? '',
        newUser: json['newUser'] == null ? null : NewUser.fromJson(json['newUser']),
        message: json['message']?? '',

      );
}

class NewUser {
  late String id ;

  NewUser({
    required this.id,
  });

  factory NewUser.fromJson(Map<String,dynamic> json) =>
      NewUser(
        id: json['_id'],
      );
}