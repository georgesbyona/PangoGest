import '../data.dart';

class EventModel {
  final String title;
  final String type;
  final String description;
  final String? imgUrl;
  final UserModel? tenant;
  final UserModel owner;
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
