import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../controllers/controllers.dart';
import 'start_end_date_picker.dart';

class EventSchedule extends StatelessWidget {
  const EventSchedule({super.key, required this.calendar});

  final CalendarController calendar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Date & Heure du début - ",
            style: theme.textTheme.labelMedium,
          ),
          Text(
            "Cliquer dessus pour modifier : ",
            style: GoogleFonts.indieFlower(fontWeight: FontWeight.normal),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const Gap(5),
          StartDatePickView(
            calendar: calendar,
            onTapD: () async {
              await calendar.pickStartDate(context);
            },
            onTapT: () async {
              await calendar.pickStartTime(context);
            },
          ),
          const Gap(10),
          Text(
            "Date & Heure de la fin - ",
            style: theme.textTheme.labelMedium,
          ),
          Text(
            "Cliquer dessus pour modifier : ",
            style: GoogleFonts.indieFlower(fontWeight: FontWeight.normal),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const Gap(5),
          EndDatePickView(
            calendar: calendar,
            onTapD: () async {
              await calendar.pickStartDate(context);
            },
            onTapT: () async {
              await calendar.pickStartTime(context);
            },
          ),
        ],
      ),
    );
  }
}
