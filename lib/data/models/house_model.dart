import '../data.dart';

class HouseModel {
  final String id;
  final AdresseModel adresse;
  final String surface;
  final String description;
  final String price;
  List<String> photos = [];

  HouseModel({
    required this.id,
    required this.adresse,
    required this.surface,
    required this.description,
    required this.price,
    this.photos = const [],
  });
}
