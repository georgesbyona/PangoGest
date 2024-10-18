import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

import '../../../../../controllers/controllers.dart';
import 'bottomsheet/event_type_bottom_sheet.dart';
import '../../../../shared/shared.dart';

class EventType extends StatelessWidget {
  const EventType({super.key, required this.calendar});

  final CalendarController calendar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Icon(AppIcons.eventType),
          const Gap(15),
          Expanded(
            child: GestureDetector(
              onTap: () {
                showBottomSheet(
                  context: context,
                  backgroundColor: theme.highlightColor,
                  builder: (context) {
                    return EventTypeBottomSheet(calendar: calendar);
                  },
                );
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Type de l'événement",
                      style: theme.textTheme.labelMedium,
                    ),
                    const Gap(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          margin: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            color: EventsTools.eventsTypes[calendar.eventType],
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Text(
                          calendar.eventType,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
