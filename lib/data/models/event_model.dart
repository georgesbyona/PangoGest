class EventModel {
  final String title;
  final String type;
  final String description;
  final String tenant;
  final String ownerID;
  final String place;
  final String time;

  EventModel({
    required this.title,
    required this.type,
    required this.ownerID,
    required this.time,
    required this.tenant,
    this.description = "",
    this.place = "A domicile",
  });
}
