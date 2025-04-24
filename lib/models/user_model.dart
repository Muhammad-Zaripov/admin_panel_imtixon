class UserModel {
  String id;
  DateTime birthday;
  String email;
  String gender;
  String name;
  String password;
  String phone;
  String surname;

  
  UserModel({
    required this.id,
    required this.birthday,
    required this.email,
    required this.gender,
    required this.name,
    required this.password,
    required this.phone,
    required this.surname,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      birthday: DateTime.parse(json["birthday"]),
      email: json["email"],
      gender: json["gender"],
      name: json["name"],
      password: json["password"],
      phone: json["phone"],
      surname: json["surname"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "birthday": birthday.toIso8601String(),
      "email": email,
      "gender": gender,
      "name": name,
      "password": password,
      "phone": phone,
      "surname": surname,
    };
  }
}
