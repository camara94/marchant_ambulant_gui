class User {
  String avatar;
  String firstname;
  String lastname;
  String username;
  String email;
  String phone;
  String gender;
  String password;
  bool admin;
  User(
      {this.avatar = '',
      this.firstname,
      this.lastname,
      this.email,
      this.phone,
      this.gender,
      this.admin,
      this.username,
      this.password});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        avatar: json['avatar'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        email: json['email'],
        phone: json['phone'],
        gender: json['gender'],
        username: json['username'],
        password: json['password']);
  }
}

class UserCredential {
  String usernameOrEmail;
  String password;
  UserCredential({this.usernameOrEmail, this.password});
}
