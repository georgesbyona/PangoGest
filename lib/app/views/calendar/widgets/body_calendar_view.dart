import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

import '../../../../controllers/controllers.dart';
import '../../../shared/shared.dart';
import 'event_card.dart';

class BodyCalendarView extends StatelessWidget {
  const BodyCalendarView({
    super.key,
    required this.calendar,
    required this.scrollController,
  });

  final ScrollController scrollController;
  final CalendarController calendar;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final isLarge = width > height ? true : false;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              calendar.events.isNotEmpty && calendar.events.length == 1
                  ? "Evénement du jour :"
                  : "Evénements du jour :",
              style: const TextStyle(height: 3),
            ),
            if (calendar.events.isEmpty) ...{
              Expanded(
                child: isLarge
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(AppIcons.addEvent),
                          Text(
                            "Pas d'événements",
                            style: TextStyle(height: 3),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(AppIcons.addEvent),
                          const Text(
                            "Pas d'événements",
                            style: TextStyle(height: 3),
                          ),
                          Gap(height * 0.1),
                        ],
                      ),
              ),
            } else ...{
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: scrollController,
                  itemCount: calendar.events.length,
                  itemBuilder: (context, index) {
                    return EventCard(
                      title: calendar.events[index].title,
                      description: calendar.events[index].description,
                      tenant: calendar.events[index].tenant,
                      where: calendar.events[index].place,
                      time: calendar.events[index].time,
                    );
                  },
                ),
              ),
            },
          ],
        ),
      ),
    );
  }
}
