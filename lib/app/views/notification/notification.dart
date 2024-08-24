import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

import '../../../data/data.dart';
import '../../shared/shared.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        children: [
          Text(
            "Système",
            style: theme.textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const Gap(15),
          for (var notificationData in notificationsData.where(
              (notificationData) => notificationData.category == "system")) ...{
            Container(
              color: Colors.transparent,
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    margin: const EdgeInsets.only(right: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: notificationData.color,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      notificationData.icon,
                      color: AppColors.black,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notificationData.title),
                        Text(
                          notificationData.content,
                          style: theme.textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  Text(
                    notificationData.time,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: theme.unselectedWidgetColor,
                      fontWeight: FontWeight.bold,
                      height: 2,
                    ),
                  ),
                ],
              ),
            ),
          },
          Text(
            "Autres",
            style: theme.textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const Gap(15),
          for (var notificationData in notificationsData.where(
              (notificationData) => notificationData.category == "autres")) ...{
            Container(
              color: Colors.transparent,
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    margin: const EdgeInsets.only(right: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: notificationData.color.withOpacity(0.7),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      notificationData.icon,
                      color: AppColors.black,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notificationData.title),
                        Text(
                          notificationData.content,
                          style: theme.textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  Text(
                    notificationData.time,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: theme.unselectedWidgetColor,
                      fontWeight: FontWeight.bold,
                      height: 2,
                    ),
                  ),
                ],
              ),
            ),
          },
        ],
      ),
    );
  }
}
