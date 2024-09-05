import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

import '../../../../../controllers/controllers.dart';
import '../../../../shared/shared.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key, required this.user, required this.calendar});

  final CalendarController calendar;
  final UserDataController user;

  @override
  Widget build(BuildContext context) {
    List<String> tenants = [
      "Georges Byona",
      "Meschack Njuci",
      "Johanna MJ",
      "Toussaint",
      "Moïse Will",
    ];
    List<String> places = ["A domicile", "Chez le locataire"];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(AppIcons.profile),
              const Gap(15),
              CustomDropDownButton(
                datas: tenants,
                hitnText: "Locataire ciblé",
                displayValue: calendar.eventTenant,
                onChanged: (data) => calendar.pickEventTenant(data),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(AppIcons.adresse),
              const Gap(15),
              CustomDropDownButton(
                datas: places,
                hitnText: "Lieu de l'événement",
                displayValue: calendar.eventPlace,
                onChanged: (data) => calendar.pickEventPlace(data),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
