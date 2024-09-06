import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/data.dart';
import 'house_adresse.dart';

class HouseDescription extends StatelessWidget {
  const HouseDescription({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(children: [
              const TextSpan(text: "Maison : "),
              TextSpan(
                text: houses[index].id,
                style: GoogleFonts.indieFlower(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ]),
            style: theme.textTheme.bodyMedium,
          ),
          Text(
            houses[index].description,
            style: theme.textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
          ),
          const Gap(5),
          Text.rich(
            TextSpan(children: [
              const TextSpan(text: "Prix : "),
              TextSpan(
                text: houses[index].price,
                style: GoogleFonts.indieFlower(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ]),
            style: theme.textTheme.bodyMedium,
          ),
          const Gap(5),
          HouseAdresse(index: index),
        ],
      ),
    );
  }
}
