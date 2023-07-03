class LoginModel {
  late String status ;
  late String message;
  late String token  ;
  late String id ;
  late bool verified ;

    LoginModel.fromJson(Map<String,dynamic> json) {
      status = json['status'];
      message = json['message'];
      token = json['token'] ?? '';
      id = json['id'] ?? '';
      verified = json['user']['verified'] ?? '' ;
    }
}