import '../data.dart';

class OwnerModel {
  final String names;
  final String? imgUrl;
  final AdresseModel adresse;
  final String? email;
  final String num;
  final String passwords;
  final String keywords;
  final String userType;
  final List<TenantModel> tenants;

  OwnerModel({
    required this.names,
    required this.num,
    required this.passwords,
    required this.keywords,
    required this.adresse,
    this.userType = "propriétaire",
    this.email,
    this.imgUrl,
    this.tenants = const [],
  });
}
