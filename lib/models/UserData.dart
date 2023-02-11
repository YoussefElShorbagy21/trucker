class UserData{
  String name;
  String email;

  UserData({
    required this.name,
    required this.email,
  });

  factory UserData.fromJson(Map<String,dynamic> json) =>
      UserData(
        name: json['user']['name'],
        email: json['user']['email'],
      );
}