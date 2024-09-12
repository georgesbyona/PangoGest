class AdresseModel {
  final String ville;
  final String commune;
  final String quartier;
  final String cellule;
  final String avenue;
  final String num;

  AdresseModel({
    required this.commune,
    required this.quartier,
    required this.avenue,
    this.ville = "Bukavu",
    this.num = "N° 0000",
    this.cellule = "",
  });
}
