import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/shared.dart';
import '../../../../data/data.dart';

class SystemView extends StatelessWidget {
  const SystemView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Système",
          style: theme.textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const Gap(15),
        for (var notificationData in notificationsData.where(
          (notificationData) => notificationData.category == "system",
        )) ...{
          Card(
            margin: const EdgeInsets.only(bottom: 15),
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    margin: const EdgeInsets.only(right: 10),
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
                        const Gap(3),
                        Text(
                          notificationData.content,
                          style: theme.textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  Text(
                    notificationData.time,
                    style: GoogleFonts.indieFlower(
                      color: theme.unselectedWidgetColor,
                      height: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        },
      ],
    );
  }
}
