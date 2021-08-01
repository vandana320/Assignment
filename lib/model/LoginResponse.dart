///
/// User Model
///
///
class LoginResponse {
  String email = "", password = "";

  LoginResponse(this.email, this.password);

  LoginResponse.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }
}
