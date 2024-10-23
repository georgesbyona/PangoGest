import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/controllers.dart';
import '../../../shared/shared.dart';
import 'house_adresse.dart';

class HouseDescription extends StatelessWidget {
  const HouseDescription({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<MainController>(context);
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(children: [
              const TextSpan(text: "Maison : "),
              TextSpan(
                text: "${controller.houses[index].id}",
                style: GoogleFonts.indieFlower(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ]),
            style: theme.textTheme.bodyMedium,
          ),
          Text(
            controller.houses[index].description,
            style: theme.textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
          ),
          const Gap(5),
          Text.rich(
            TextSpan(children: [
              const TextSpan(text: "Prix : "),
              TextSpan(
                text: "${controller.houses[index].price}\$",
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
          const Gap(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () async {
                  final deleted = await controller.deleteHouse(index);
                  if (deleted) {
                    myCustomSnackBar(
                      context: context,
                      text: "Maison supprimée",
                    );
                  } else {
                    myCustomSnackBar(
                      context: context,
                      text: "Erreur",
                    );
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(5),
                  child: Icon(
                    AppIcons.delete,
                    color: AppColors.red,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
