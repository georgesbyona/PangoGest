class ContractModel {
  final int? id;
  final String dateDebut;
  final String dateContrat;
  final int duree;
  final String price;
  final String tenantEmail;
  final String docUrl;
  final bool inProgress;
  final int? ownerID;
  final int? tenantID;
  final int houseID;

  ContractModel({
    this.id,
    required this.dateDebut,
    required this.dateContrat,
    required this.duree,
    required this.price,
    required this.tenantEmail,
    this.docUrl = "",
    this.ownerID,
    this.tenantID,
    this.inProgress = false,
    required this.houseID,
  });

  factory ContractModel.fromJson(json) => ContractModel(
        id: json['id'] as int,
        dateDebut: json['date_debut'] as String,
        dateContrat: json['date_contrat'] as String,
        docUrl: json['fichier'] as String,
        duree: json['duree_moi'] as int,
        price: json['prix'] as String,
        inProgress: json['encours'] as bool,
        houseID: json['bien'] as int,
        tenantEmail: json['email'] as String,
        tenantID: json['locataire'],
      );
}
