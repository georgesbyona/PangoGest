class ContractModel {
  final int id;
  final String dateDebut;
  final String dateFin;
  final String duree;
  final String price;
  final bool inProgress;
  final int? ownerID;
  final int? tenantID;

  ContractModel({
    required this.id,
    required this.dateDebut,
    required this.dateFin,
    required this.duree,
    required this.price,
    this.ownerID,
    this.tenantID,
    this.inProgress = false,
  });

  factory ContractModel.fromJson(json) => ContractModel(
        id: json['id'] as int,
        dateDebut: json['date_debut'] as String,
        dateFin: json['date_contrat'] as String,
        duree: json['date_contrat'] as String,
        price: json['prix'] as String,
        inProgress: json['encours'] as bool,
      );
}
