import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

import '../../../../controllers/controllers.dart';
import 'widgets/event_notification.dart';
import 'widgets/event_description.dart';
import 'widgets/event_schedule.dart';
import '../../../shared/shared.dart';
import 'widgets/event_details.dart';
import 'widgets/title_field.dart';
import 'widgets/event_type.dart';

class AddNewEventPage extends StatefulWidget {
  const AddNewEventPage({
    super.key,
    required this.user,
    required this.calendar,
  });

  final CalendarController calendar;
  final UserDataController user;

  @override
  State<AddNewEventPage> createState() => _AddNewEventPageState();
}

class _AddNewEventPageState extends State<AddNewEventPage> {
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController descptTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          CustomSaveFormButton(
            onTap: () {
              if (widget.calendar.startDate == widget.calendar.endDate &&
                  widget.calendar.startTime == widget.calendar.endTime) {
                myCustomSnackBar(
                  context: context,
                  text: "Date & Heure ne doivent pas être idem",
                  backgroundColor: AppColors.red,
                );
              } else if (titleTextController.text.isEmpty) {
                myCustomSnackBar(
                  context: context,
                  text: "Entrez un titre à l'événement",
                  backgroundColor: AppColors.red,
                );
              } else {
                widget.calendar.addNewEvent(
                  titleTextController.text,
                  descptTextController.text,
                  widget.user,
                );
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Nouvel Evénement",
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const Gap(5),
            Expanded(
              child: ListView(
                shrinkWrap: false,
                children: [
                  TitleField(titleTextController: titleTextController),
                  const CustomDivider(marginTop: 5),
                  EventType(calendar: widget.calendar),
                  const CustomDivider(),
                  EventSchedule(calendar: widget.calendar),
                  const CustomDivider(marginBottom: 10),
                  EventDetails(user: widget.user, calendar: widget.calendar),
                  const CustomDivider(marginTop: 10, marginBottom: 10),
                  EventNotification(calendar: widget.calendar),
                  const CustomDivider(marginTop: 15, marginBottom: 5),
                  EventDescription(
                    calendar: widget.calendar,
                    descptTextController: descptTextController,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// const List<EventCard> eventLists = [
//   EventCard(
//     title: "VISITE",
//     content:
//         "Rendre visite aux maisons de l'Hyppodrome pour s'assurer leur état et rappeler aux locataires le paiement de ce mois.",
//     tenant: "John L. ",
//     where: "Chez John ",
//     time: "13h00 ",
//   ),
//   EventCard(
//     title: "CONVOCATION",
//     content:
//         "Rencontrer Georges pour l'incident qui est arrivé la semaine passée entre lui et le voisin d'à côté.",
//     tenant: "Georges ",
//     where: "A la maison ",
//     time: "11h30 ",
//   ),
//   EventCard(
//     title: "RAPPEL - Paiement",
//     content:
//         "Percevoir le paiement du mois de Septembre de Kévin, et rappeler à Faith pour sa régularisation du paiement de mois d'Août.",
//     tenant: "Kevin ",
//     where: "",
//     time: "",
//   ),
//   EventCard(
//     title: "FIN DU CONTRAT",
//     content:
//         "15 jours restant avant la fin du contrat de Hervé, prendre un moment pour lui faire signe et commencer à régulariser les affaires pour sa sortie de la maison.",
//     tenant: " John ",
//     where: "",
//     time: "",
//   ),
// ];
