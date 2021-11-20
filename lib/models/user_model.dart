class UserModel {
  String? name;
  String? email;
  String? password;

  UserModel({this.name, this.email, this.password});

  get getName {
    return name;
  }

  Map toJson() => {
        "name": name,
        "email": email,
        "password": password,
      };
}
