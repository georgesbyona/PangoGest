class AddressModel {
  final int id;
  final String ville;
  final String commune;
  final String quartier;
  final String cellule;
  final String avenue;
  final String num;

  AddressModel({
    required this.id,
    required this.commune,
    required this.quartier,
    required this.avenue,
    this.ville = "Bukavu",
    this.num = "N° 0000",
    this.cellule = "",
  });

  factory AddressModel.fromJson(dynamic json) {
    return AddressModel(
      id: json["id"] as int,
      ville: json["ville"] as String,
      commune: json["commune"] as String,
      quartier: json["quartier"] as String,
      cellule: json["cellule"] == null ? "" : json["cellule"] as String,
      avenue: json['avenue'] as String,
      num: json["num_av"] as String,
      // adresseID: json['adresse'] as String,
    );
  }
}
