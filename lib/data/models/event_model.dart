import '../data.dart';

class EventModel {
  final String title;
  final String type;
  final String description;
  final String? imgUrl;
  final TenantModel? tenant;
  final OwnerModel owner;
  final String place;
  final String time;

  EventModel({
    required this.title,
    required this.type,
    required this.owner,
    required this.time,
    this.description = "",
    this.place = "A domicile",
    this.tenant,
    this.imgUrl,
  });
}
