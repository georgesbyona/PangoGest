import 'package:flutter/material.dart';

import '../data/data.dart';

class CalendarController extends ChangeNotifier {
  List<EventModel> events = [];

  void addNewEvent(EventModel event) {
    events.add(event);
    notifyListeners();
  }
}
