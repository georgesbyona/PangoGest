import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controllers/controllers.dart';
import '../../../shared/shared.dart';
import '../widgets/event_card.dart';

class AddNewEventPage extends StatefulWidget {
  const AddNewEventPage({
    super.key,
    required this.user,
    required this.calendar,
  });

  final UserDataController user;
  final CalendarController calendar;

  @override
  State<AddNewEventPage> createState() => _AddNewEventPageState();
}

class _AddNewEventPageState extends State<AddNewEventPage> {
  final TextEditingController titleTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          CustomSaveFormButton(
            onTap: () {},
          ),
        ],
      ),
      body: Column(
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    autocorrect: false,
                    controller: titleTextController,
                    onTapOutside: (event) {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    cursorColor: theme.colorScheme.inversePrimary,
                    cursorErrorColor: AppColors.red,
                    maxLines: 1,
                    style: GoogleFonts.raleway(
                      color: theme.colorScheme.inverseSurface,
                      fontWeight: FontWeight.normal,
                      fontSize: 25,
                    ),
                    decoration: InputDecoration(
                      hintText: "Taper un titre",
                      hintStyle: GoogleFonts.raleway(
                        color: theme.colorScheme.inverseSurface,
                        fontWeight: FontWeight.normal,
                        fontSize: 25,
                      ),
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: theme.colorScheme.inverseSurface,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      ),
                      errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.red,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez remplir ce champ !';
                      }
                      return null;
                    },
                  ),
                ),
                const CustomDivider(marginTop: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Icon(AppIcons.eventType),
                      const Gap(15),
                      Column(
                        children: [
                          Text(
                            "Type de l'événement",
                            style: theme.textTheme.labelMedium,
                          ),
                          const Gap(5),
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                margin: const EdgeInsets.only(right: 5),
                                decoration: const BoxDecoration(
                                  color: Colors.amber,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Text(
                                'Rappel-Paiement',
                                style: theme.textTheme.bodySmall,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const CustomDivider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const List<EventCard> eventLists = [
  EventCard(
    title: "VISITE",
    content:
        "Rendre visite aux maisons de l'Hyppodrome pour s'assurer leur état et rappeler aux locataires le paiement de ce mois.",
    tenant: "John L. ",
    where: "Chez John ",
    time: "13h00 ",
  ),
  EventCard(
    title: "CONVOCATION",
    content:
        "Rencontrer Georges pour l'incident qui est arrivé la semaine passée entre lui et le voisin d'à côté.",
    tenant: "Georges ",
    where: "A la maison ",
    time: "11h30 ",
  ),
  EventCard(
    title: "RAPPEL - Paiement",
    content:
        "Percevoir le paiement du mois de Septembre de Kévin, et rappeler à Faith pour sa régularisation du paiement de mois d'Août.",
    tenant: "Kevin ",
    where: "",
    time: "",
  ),
  EventCard(
    title: "FIN DU CONTRAT",
    content:
        "15 jours restant avant la fin du contrat de Hervé, prendre un moment pour lui faire signe et commencer à régulariser les affaires pour sa sortie de la maison.",
    tenant: " John ",
    where: "",
    time: "",
  ),
];
