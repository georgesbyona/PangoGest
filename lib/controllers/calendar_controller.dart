import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../data/data.dart';
import 'user_controller.dart';

class CalendarController extends ChangeNotifier {
  String startDayString = convertWeekDayToString(DateTime.now().weekday);
  String startDay = DateTime.now().day.toString();
  String startMonth = convertMonthToString(DateTime.now().month);
  String startYear = DateTime.now().year.toString();
  String startHour = convertSmallHour(TimeOfDay.now().hour);
  String startMin = convertSmallMin(TimeOfDay.now().minute);

  String endDayString = convertWeekDayToString(DateTime.now().weekday);
  String endDay = DateTime.now().day.toString();
  String endMonth = convertMonthToString(DateTime.now().month);
  String endYear = DateTime.now().year.toString();
  String endHour = convertSmallHour(TimeOfDay.now().hour);
  String endMin = convertSmallMin(TimeOfDay.now().minute);

  DateTime? _startDate;
  TimeOfDay? _startTime;
  DateTime? _endDate;
  TimeOfDay? _endTime;

  dynamic get startDate =>
      _startDate ?? DateFormat('yyyy-MM-dd').format(DateTime.now());
  TimeOfDay get startTime => _startTime ?? TimeOfDay.now();
  dynamic get endDate =>
      _endDate ?? DateFormat('yyyy-MM-dd').format(DateTime.now());
  TimeOfDay get endTime => _endTime ?? TimeOfDay.now();

  void resetScheduleData() {
    startDayString = convertWeekDayToString(DateTime.now().weekday);
    startDay = DateTime.now().day.toString();
    startMonth = convertMonthToString(DateTime.now().month);
    startYear = DateTime.now().year.toString();
    startHour = convertSmallHour(TimeOfDay.now().hour);
    startMin = convertSmallMin(TimeOfDay.now().minute);

    endDayString = convertWeekDayToString(DateTime.now().weekday);
    endDay = DateTime.now().day.toString();
    endMonth = convertMonthToString(DateTime.now().month);
    endYear = DateTime.now().year.toString();
    endHour = convertSmallHour(TimeOfDay.now().hour);
    endMin = convertSmallMin(TimeOfDay.now().minute);
    notifyListeners();
  }

  Future<void> pickStartDate(BuildContext context) async {
    _startDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );
    if (_startDate != null) {
      startDayString = convertWeekDayToString(_startDate!.weekday);
      startDay = _startDate!.day.toString();
      startMonth = convertMonthToString(_startDate!.month);
      startYear = _startDate!.year.toString();
    }
    notifyListeners();
  }

  Future<void> pickStartTime(BuildContext context) async {
    _startTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (_startTime != null) {
      startHour = convertSmallHour(_startTime!.hour);
      startMin = convertSmallMin(_startTime!.minute);
    }
    notifyListeners();
  }

  Future<void> pickEndDate(BuildContext context) async {
    _endDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );
    if (_endDate != null) {
      endDayString = convertWeekDayToString(_endDate!.weekday);
      endDay = _endDate!.day.toString();
      endMonth = convertMonthToString(_endDate!.month);
      endYear = _endDate!.year.toString();
    }
    notifyListeners();
  }

  Future<void> pickEndTime(BuildContext context) async {
    _endTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (_endTime != null) {
      endHour = convertSmallHour(_endTime!.hour);
      endMin = convertSmallMin(_endTime!.minute);
    }
    notifyListeners();
  }

  String eventType = "Paiement";
  void pickEventType(String label) {
    eventType = label;
    notifyListeners();
  }

  String? eventTenant;
  void pickEventTenant(String? tenant) {
    eventTenant = tenant;
    notifyListeners();
  }

  String? eventPlace;
  void pickEventPlace(String? place) {
    eventPlace = place;
    notifyListeners();
  }

  List<String> notifications = [
    "30 minutes avant",
    "1 heure avant",
    "1 jour avant",
    "5 jours avant",
    "10 jours avant",
  ];
  List<String> updatedNotifications = ["15 minutes avant"];

  void addNotifications(int index) {
    final newNotification = notifications[index];
    updatedNotifications.add(newNotification);
    notifications.removeAt(index);
    notifyListeners();
  }

  void removeNotifications(int index) {
    final oldNotification = updatedNotifications[index];
    notifications.add(oldNotification);
    updatedNotifications.removeAt(index);
    notifyListeners();
  }

  List<EventModel> events = [];

  void addNewEvent(
    String title,
    String description,
    UserDataController user,
    // UserModel tenant,
  ) {
    // events.add(
    // EventModel(
    //   title: title,
    //   type: eventType,
    //   description: description,
    //   tenant: eventTenant!,
    //   time: "$endHour:$endMin",
    //   ownerID: user.email ?? user.num!,
    //   place: eventPlace!,
    // ),
    // );
    notifyListeners();
  }
}

String convertWeekDayToString(int weekdayInt) {
  String weekDayString = "";
  switch (weekdayInt) {
    case 1:
      weekDayString = "Lundi";
      break;
    case 2:
      weekDayString = "Mardi";
      break;
    case 3:
      weekDayString = "Mercredi";
      break;
    case 4:
      weekDayString = "Jeudi";
      break;
    case 5:
      weekDayString = "Vendredi";
      break;
    case 6:
      weekDayString = "Samedi";
      break;
    case 7:
      weekDayString = "Dimanche";
      break;
    default:
      weekDayString = "";
      break;
  }
  return weekDayString;
}

String convertMonthToString(int monthInt) {
  String monthString = "";
  switch (monthInt) {
    case 1:
      monthString = "Janvier";
      break;
    case 2:
      monthString = "Février";
      break;
    case 3:
      monthString = "Mars";
      break;
    case 4:
      monthString = "Avril";
      break;
    case 5:
      monthString = "Mai";
      break;
    case 6:
      monthString = "Juin";
      break;
    case 7:
      monthString = "Juillet";
      break;
    case 8:
      monthString = "Août";
      break;
    case 9:
      monthString = "Septembre";
      break;
    case 10:
      monthString = "Octobre";
      break;
    case 11:
      monthString = "Novembre";
      break;
    case 12:
      monthString = "Décembre";
      break;
    default:
      monthString = "";
      break;
  }
  return monthString;
}

String convertSmallMin(int minInt) {
  if (minInt < 10) {
    String newSmallMin;
    switch (minInt) {
      case 0:
        newSmallMin = "00";
        break;
      case 1:
        newSmallMin = "01";
        break;
      case 2:
        newSmallMin = "02";
        break;
      case 3:
        newSmallMin = "03";
        break;
      case 4:
        newSmallMin = "04";
        break;
      case 5:
        newSmallMin = "05";
        break;
      case 6:
        newSmallMin = "06";
        break;
      case 7:
        newSmallMin = "07";
        break;
      case 8:
        newSmallMin = "08";
        break;
      case 9:
        newSmallMin = "09";
        break;
      default:
        newSmallMin = minInt.toString();
        break;
    }
    return newSmallMin;
  }
  return minInt.toString();
}

String convertSmallHour(int hourInt) {
  if (hourInt < 10) {
    String newSmallHour;
    switch (hourInt) {
      case 0:
        newSmallHour = "00";
        break;
      case 1:
        newSmallHour = "01";
        break;
      case 2:
        newSmallHour = "02";
        break;
      case 3:
        newSmallHour = "03";
        break;
      case 4:
        newSmallHour = "04";
        break;
      case 5:
        newSmallHour = "05";
        break;
      case 6:
        newSmallHour = "06";
        break;
      case 7:
        newSmallHour = "07";
        break;
      case 8:
        newSmallHour = "08";
        break;
      case 9:
        newSmallHour = "09";
        break;
      default:
        newSmallHour = hourInt.toString();
        break;
    }
    return newSmallHour;
  }
  return hourInt.toString();
}
