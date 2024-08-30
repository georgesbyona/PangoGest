import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/shared.dart';
import 'event_card.dart';

class BodyCalendarView extends StatelessWidget {
  const BodyCalendarView({
    super.key,
    required this.isEmpty,
    required this.scrollController,
  });

  final bool isEmpty;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final isLarge = width > height ? true : false;
    final theme = Theme.of(context);
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
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              !isEmpty && eventLists.length == 1
                  ? "Evénement du jour :"
                  : "Evénements du jour :",
              style: GoogleFonts.indieFlower(height: 3),
            ),
            if (isEmpty) ...{
              Expanded(
                child: isLarge
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(AppIcons.addEvent),
                          const Gap(10),
                          Text(
                            "Pas d'événements",
                            style:
                                theme.textTheme.bodySmall!.copyWith(height: 3),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(AppIcons.addEvent),
                          Text(
                            "Pas d'événements",
                            style:
                                theme.textTheme.bodySmall!.copyWith(height: 3),
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
                  itemCount: eventLists.length,
                  itemBuilder: (context, index) {
                    return eventLists[index];
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
