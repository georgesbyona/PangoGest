import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../controllers/controllers.dart';
import '../../../../../shared/shared.dart';

class EventTypeBottomSheet extends StatelessWidget {
  const EventTypeBottomSheet({super.key, required this.calendar});

  final CalendarController calendar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final eventsLabels = EventsTools.eventsTypes.keys.toList();
    final eventsColors = EventsTools.eventsTypes.values.toList();
    return Container(
      height: 400,
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            height: 5,
            width: 110,
            margin: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: theme.colorScheme.inverseSurface,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          Text(
            "Choisissez un type\nd'événement",
            style: theme.textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          const Gap(15),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: EventsTools.eventsTypes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    calendar.pickEventType(eventsLabels[index]);
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 15,
                              height: 15,
                              margin: const EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                color: eventsColors[index],
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            Text(
                              eventsLabels[index],
                              style: GoogleFonts.indieFlower(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const CustomDivider(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
