import '../data.dart';

class UserModel {
  final String names;
  final String? imgUrl;
  final AdresseModel adresse;
  final String? email;
  final String num;
  final String password;
  final String? maisonID;
  final String userType;

  UserModel({
    required this.names,
    required this.num,
    required this.password,
    required this.adresse,
    required this.userType,
    this.imgUrl = "https://iconscout.com/icons/person",
    this.maisonID,
    this.email,
  });
}
