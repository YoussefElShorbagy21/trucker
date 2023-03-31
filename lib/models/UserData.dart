class UserData{
  String name;
  String email;
  bool verified;

  UserData({
    required this.name,
    required this.email,
    required this.verified,
  });

  factory UserData.fromJson(Map<String,dynamic> json) =>
      UserData(
        name: json['user']['name'],
        email: json['user']['email'],
        verified: json['user']['verified'],
      );
}