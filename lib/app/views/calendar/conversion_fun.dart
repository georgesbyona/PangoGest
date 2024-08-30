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
