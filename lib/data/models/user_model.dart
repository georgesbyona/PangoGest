class UserModel {
  final int? id;
  final String firstName;
  final String lastName;
  final String? imgUrl;
  final String email;
  final String num;
  final String password;
  final String userType;
  final int? maisonID;
  final int? adresseID;

  UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.num,
    required this.password,
    required this.userType,
    this.imgUrl = "https://iconscout.com/icons/person",
    this.adresseID,
    this.maisonID,
  });

  factory UserModel.fromJson(dynamic json) {
    return UserModel(
      id: json["id"] as int,
      firstName: json["first_name"] as String,
      lastName: json["last_name"] as String,
      email: json["email"] as String,
      num: json["telephone"] as String,
      password: json["password"] as String,
      imgUrl: json["photo_url"] as String,
      userType: json['user_type'] as String,
      adresseID: json['id_adresse'],
    );
  }
}
