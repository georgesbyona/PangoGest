import '../data.dart';

class UserModel {
  final String names;
  final String? imgUrl;
  final AdresseModel? adresse;
  final String? email;
  final String num;
  final String passwords;
  final String keywords;
  final String userType;
  final List<UserModel> tenants;

  UserModel({
    this.email,
    this.imgUrl,
    this.adresse,
    this.tenants = const [],
    required this.names,
    required this.num,
    required this.passwords,
    required this.keywords,
    required this.userType,
  });
}
