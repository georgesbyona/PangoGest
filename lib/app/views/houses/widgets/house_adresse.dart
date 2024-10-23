import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/controllers.dart';
import '../../../shared/shared.dart';

class HouseAdresse extends StatelessWidget {
  const HouseAdresse({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<MainController>(context);
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
              Text(
                "Av. ${controller.housesAddress[index].avenue} ${controller.housesAddress[index].num}",
                style: GoogleFonts.indieFlower(
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                "Q. ${controller.housesAddress[index].quartier}",
                style: GoogleFonts.indieFlower(
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                "C. ${controller.housesAddress[index].commune}",
                style: GoogleFonts.indieFlower(
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                "Ville : ${controller.housesAddress[index].ville}",
                style: GoogleFonts.indieFlower(
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
