class UserData{
  String name;
  String email;
  String phone;
  bool verified;
  String avatar ;

  UserData({
    required this.name,
    required this.email,
    required this.phone,
    required this.verified,
    required this.avatar,
  });

  factory UserData.fromJson(Map<String,dynamic> json) =>
      UserData(
        name: json['user']['name'],
        email: json['user']['email'],
        phone:json['user']['phone'] ,
        verified: json['user']['verified'],
        avatar: json['user']['avatar']
      );
}