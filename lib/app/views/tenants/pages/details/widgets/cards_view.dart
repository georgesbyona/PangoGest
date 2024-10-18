import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../data/data.dart';

class CardsView extends StatelessWidget {
  const CardsView({super.key, required this.house});

  final Iterable<HouseModel> house;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final size = width > height ? height : width;
    int garantie = 6;
    int total = 100;
    final List<String> titles = ["Garantie", "Total", "Rappel"];
    final List<int> datas = [garantie, total, 15];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        titles.length,
        (index) {
          return Container(
            width: size * 0.27,
            height: size * 0.27,
            margin: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: theme.colorScheme.inverseSurface,
                width: 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  titles[index],
                  style: GoogleFonts.indieFlower(),
                ),
                const Gap(2),
                Text(
                  index == 0
                      ? "${datas[index]} mois"
                      : index == 1
                          ? "${datas[index]}\$"
                          : "${datas[index]} jrs",
                  style: GoogleFonts.indieFlower(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
