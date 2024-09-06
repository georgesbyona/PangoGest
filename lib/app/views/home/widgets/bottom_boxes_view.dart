import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/shared.dart';
import '../../views.dart';

class BottomBoxesView extends StatelessWidget {
  const BottomBoxesView({super.key});

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [AppIcons.tenants, AppIcons.houses];
    List<String> labels = ["Locataires", "Maisons"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        icons.length,
        (index) => GestureDetector(
          onTap: () {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TenantsList(),
                ),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HousesList(),
                ),
              );
            }
          },
          child: SizedBox(
            width: 200,
            height: 200,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icons[index], size: 30),
                  const Gap(15),
                  Text(
                    labels[index],
                    style: GoogleFonts.indieFlower(),
                  ),
                  const Icon(Icons.format_list_bulleted_rounded, size: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
