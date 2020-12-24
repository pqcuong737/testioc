class Login {
  String email;
  String password;
  Login({this.email, this.password});

  Map toJson() => {
    "email": email,
    "password": password
  };
}