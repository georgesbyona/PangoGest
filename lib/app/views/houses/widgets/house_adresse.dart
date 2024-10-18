import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

import '../../../shared/shared.dart';

class HouseAdresse extends StatelessWidget {
  const HouseAdresse({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
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
              //   "Av. ${houses[index].adresse.avenue} ${houses[index].adresse.num}",
              //   style: GoogleFonts.indieFlower(
              //     fontWeight: FontWeight.normal,
              //     letterSpacing: 0.5,
              //   ),
              //   overflow: TextOverflow.ellipsis,
              //   maxLines: 1,
              // ),
              // Text(
              //   "Q. ${houses[index].adresse.quartier}",
              //   style: GoogleFonts.indieFlower(
              //     fontWeight: FontWeight.normal,
              //     letterSpacing: 0.5,
              //   ),
              //   overflow: TextOverflow.ellipsis,
              //   maxLines: 1,
              // ),
              // Text(
              //   "C. ${houses[index].adresse.commune}",
              //   style: GoogleFonts.indieFlower(
              //     fontWeight: FontWeight.normal,
              //     letterSpacing: 0.5,
              //   ),
              //   overflow: TextOverflow.ellipsis,
              //   maxLines: 1,
              // ),
              // Text(
              //   "Ville : ${houses[index].adresse.ville}",
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
    );
  }
}
