import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

import '../../../../../controllers/controllers.dart';
import '../../../../shared/shared.dart';

class EventDescription extends StatelessWidget {
  const EventDescription({
    super.key,
    required this.calendar,
    required this.descptTextController,
  });

  final TextEditingController descptTextController;
  final CalendarController calendar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 13),
            child: Icon(AppIcons.description),
          ),
          const Gap(15),
          Expanded(
            child: TextField(
              maxLines: null,
              controller: descptTextController,
              cursorColor: theme.colorScheme.inversePrimary,
              onTapOutside: (event) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              style: TextStyle(
                color: theme.colorScheme.inverseSurface,
                fontWeight: FontWeight.normal,
                letterSpacing: 1.5,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: "Entrer une description de l'événement ici ...",
                hintStyle: TextStyle(
                  color: theme.colorScheme.inverseSurface,
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
