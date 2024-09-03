class ContractModel {
  final String id;
  final String dateDebut;
  final String dateFin;
  final String duree;
  final String price;
  final bool inProgress;
  ContractModel({
    required this.id,
    required this.dateDebut,
    required this.dateFin,
    required this.duree,
    required this.price,
    this.inProgress = false,
  });
}
