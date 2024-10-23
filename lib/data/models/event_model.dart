class EventModel {
  final String title;
  final String type;
  final String description;
  final String dateDebut;
  final String dateFin;
  final bool vuOwner;
  final bool vuTenant;
  final int contractID;

  EventModel({
    required this.description,
    required this.type,
    required this.contractID,
    required this.dateDebut,
    required this.dateFin,
    required this.vuOwner,
    required this.vuTenant,
    this.title = "",
  });
}
