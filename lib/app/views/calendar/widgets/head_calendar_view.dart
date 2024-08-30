import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class HeadCalendarView extends StatefulWidget {
  const HeadCalendarView({super.key});

  @override
  State<HeadCalendarView> createState() => _HeadCalendarViewState();
}

class _HeadCalendarViewState extends State<HeadCalendarView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final isLarge = width > height ? true : false;
    final theme = Theme.of(context);
    return EasyDateTimeLine(
      locale: "fr_FR",
      initialDate: DateTime.now(),
      headerProps: EasyHeaderProps(
        monthPickerType: MonthPickerType.dropDown,
        dateFormatter: const DateFormatter.fullDateDMonthAsStrY(),
        monthStyle: GoogleFonts.indieFlower(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.inversePrimary,
        ),
        selectedDateStyle: GoogleFonts.indieFlower(),
        showHeader: true,
      ),
      dayProps: EasyDayProps(
        landScapeMode: isLarge,
        dayStructure: DayStructure.dayStrDayNum,
        inactiveDayStyle: DayStyle(
          splashBorder: const BorderRadius.all(Radius.circular(50)),
          monthStrStyle: GoogleFonts.indieFlower(),
          dayNumStyle: GoogleFonts.indieFlower(),
          dayStrStyle: GoogleFonts.raleway(),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                theme.highlightColor,
                theme.scaffoldBackgroundColor,
              ],
            ),
          ),
        ),
        activeDayStyle: DayStyle(
          splashBorder: const BorderRadius.all(Radius.circular(50)),
          monthStrStyle: GoogleFonts.indieFlower(),
          dayNumStyle: GoogleFonts.indieFlower(),
          dayStrStyle: GoogleFonts.raleway(),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                theme.primaryColor,
                theme.primaryColor.withOpacity(0.5),
                theme.scaffoldBackgroundColor,
              ],
              stops: const [0.1, 0.5, 0.9],
            ),
          ),
        ),
        todayStyle: DayStyle(
          splashBorder: const BorderRadius.all(Radius.circular(50)),
          monthStrStyle: GoogleFonts.indieFlower(),
          dayNumStyle: GoogleFonts.indieFlower(),
          dayStrStyle: GoogleFonts.raleway(),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(
              color: Colors.blue.shade300,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
