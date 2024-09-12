class ContractModel {
  final String id;
  final String dateDebut;
  final String dateFin;
  final String duree;
  final String price;
  final bool inProgress;
  final String ownerID;
  final String tenantID;

  ContractModel({
    required this.id,
    required this.dateDebut,
    required this.dateFin,
    required this.duree,
    required this.price,
    required this.ownerID,
    required this.tenantID,
    this.inProgress = false,
  });
}
