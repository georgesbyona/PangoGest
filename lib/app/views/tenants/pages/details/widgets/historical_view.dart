import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoricalView extends StatelessWidget {
  const HistoricalView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Historiques :",
          style: theme.textTheme.bodyMedium!.copyWith(fontSize: 16),
        ),
        const Gap(15),
        Text(
          "--- Aucun historique pour l'instant ---",
          style: GoogleFonts.indieFlower(fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
