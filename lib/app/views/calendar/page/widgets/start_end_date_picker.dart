import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

import '../../../../../controllers/controllers.dart';
import '../../../../shared/shared.dart';

class StartDatePickView extends StatelessWidget {
  const StartDatePickView({
    super.key,
    required this.onTapD,
    required this.onTapT,
    required this.calendar,
  });

  final CalendarController calendar;
  final VoidCallback onTapD, onTapT;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTapD,
            child: Container(
              alignment: Alignment.centerLeft,
              color: Colors.transparent,
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(AppIcons.calendarEdit, size: 14),
                      const Gap(5),
                      Text(
                        "${calendar.startDayString}, ${calendar.startDay} ${calendar.startMonth} ${calendar.startYear}",
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  const Icon(AppIcons.edit, size: 14),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: onTapT,
            child: Container(
              alignment: Alignment.centerLeft,
              color: Colors.transparent,
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(AppIcons.clock, size: 15),
                      const Gap(5),
                      Text(
                        "${calendar.startHour}:${calendar.startMin}",
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  const Icon(AppIcons.edit, size: 14),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EndDatePickView extends StatelessWidget {
  const EndDatePickView({
    super.key,
    required this.onTapD,
    required this.onTapT,
    required this.calendar,
  });

  final CalendarController calendar;
  final VoidCallback onTapD, onTapT;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTapD,
            child: Container(
              alignment: Alignment.centerLeft,
              color: Colors.transparent,
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(AppIcons.calendarEdit, size: 14),
                      const Gap(5),
                      Text(
                        "${calendar.endDayString}, ${calendar.endDay} ${calendar.endMonth} ${calendar.endYear}",
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  const Icon(AppIcons.edit, size: 14),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: onTapT,
            child: Container(
              alignment: Alignment.centerLeft,
              color: Colors.transparent,
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(AppIcons.clock, size: 15),
                      const Gap(5),
                      Text(
                        "${calendar.endHour}:${calendar.endMin}",
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  const Icon(AppIcons.edit, size: 14),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
