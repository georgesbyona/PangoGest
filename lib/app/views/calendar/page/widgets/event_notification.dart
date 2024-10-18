import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

import '../../../../../controllers/controllers.dart';
import '../../../../shared/shared.dart';

class EventNotification extends StatelessWidget {
  const EventNotification({super.key, required this.calendar});

  final CalendarController calendar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
            child: Icon(AppIcons.notification),
          ),
          const Gap(15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (calendar.updatedNotifications.isNotEmpty)
                  Column(
                    children: List.generate(
                      calendar.updatedNotifications.length,
                      (index) => SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              calendar.updatedNotifications[index],
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => calendar.removeNotifications(index),
                              child: Container(
                                color: Colors.transparent,
                                child: const Icon(AppIcons.close),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (calendar.notifications.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return NotificationsDialogView(calendar: calendar);
                        },
                      );
                    },
                    child: Container(
                      height: 40,
                      color: Colors.transparent,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Taper ici pour ajouter une notification ...",
                        style: theme.textTheme.labelMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationsDialogView extends StatelessWidget {
  const NotificationsDialogView({super.key, required this.calendar});

  final CalendarController calendar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SimpleDialog(
      backgroundColor: theme.highlightColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 30),
      children: [
        Text(
          "Créneaux de notification",
          style: theme.textTheme.titleSmall,
          textAlign: TextAlign.center,
        ),
        const Gap(20),
        Column(
          children: List.generate(
            calendar.notifications.length,
            (index) => GestureDetector(
              onTap: () {
                calendar.addNotifications(index);
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Text(
                      calendar.notifications[index],
                      style: const TextStyle(
                        fontSize: 16,
                        letterSpacing: 2,
                      ),
                    ),
                    if (index != calendar.notifications.length - 1)
                      const CustomDivider(
                        marginTop: 10,
                        marginBottom: 10,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Gap(5),
      ],
    );
  }
}
