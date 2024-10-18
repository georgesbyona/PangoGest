import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../shared/shared.dart';
import '../../../../../../data/data.dart';

class DetailsPartView extends StatelessWidget {
  const DetailsPartView({super.key, required this.house});

  final Iterable<HouseModel> house;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: 'Maison : '),
                      TextSpan(
                        text: "N° ${house.first.id}",
                        style: GoogleFonts.indieFlower(),
                      ),
                    ],
                  ),
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: 'Prix : '),
                      TextSpan(
                        text: "${house.first.price}\$",
                        style: GoogleFonts.indieFlower(),
                      ),
                    ],
                  ),
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  AppIcons.adresse,
                  size: 15,
                ),
                const Gap(5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   "Av. ${house.first.adresse.avenue} ${house.first.adresse.num}",
                      //   style: GoogleFonts.indieFlower(
                      //     fontWeight: FontWeight.normal,
                      //     letterSpacing: 0.5,
                      //   ),
                      //   overflow: TextOverflow.ellipsis,
                      //   maxLines: 1,
                      // ),
                      // Text(
                      //   "Q. ${house.first.adresse.quartier}",
                      //   style: GoogleFonts.indieFlower(
                      //     fontWeight: FontWeight.normal,
                      //     letterSpacing: 0.5,
                      //   ),
                      //   overflow: TextOverflow.ellipsis,
                      //   maxLines: 1,
                      // ),
                      // Text(
                      //   "C. ${house.first.adresse.commune}",
                      //   style: GoogleFonts.indieFlower(
                      //     fontWeight: FontWeight.normal,
                      //     letterSpacing: 0.5,
                      //   ),
                      //   overflow: TextOverflow.ellipsis,
                      //   maxLines: 1,
                      // ),
                      // Text(
                      //   "Ville : ${house.first.adresse.ville}",
                      //   style: GoogleFonts.indieFlower(
                      //     fontWeight: FontWeight.normal,
                      //     letterSpacing: 0.5,
                      //   ),
                      //   overflow: TextOverflow.ellipsis,
                      //   maxLines: 1,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
