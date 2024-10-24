import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../shared/shared.dart';
import '../../views.dart';

class BottomBoxesView extends StatelessWidget {
  const BottomBoxesView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
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
            width: width * 0.45,
            height: width * 0.45,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icons[index], size: 30),
                  const Gap(15),
                  Text(
                    labels[index],
                    style: GoogleFonts.raleway(),
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

class TenantBottomBoxesView extends StatelessWidget {
  const TenantBottomBoxesView({
    super.key,
    required this.surface,
    required this.price,
  });
  final String surface, price;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    List<IconData> icons = [Iconsax.box_2_outline, AppIcons.price];
    List<String> labels = ["Surface", "Prix"];
    List<String> content = [surface, price];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        icons.length,
        (index) => GestureDetector(
          onTap: () {},
          child: SizedBox(
            width: width * 0.45,
            height: width * 0.40,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    labels[index],
                    style: GoogleFonts.raleway(fontSize: 13),
                  ),
                  Text(
                    content[index],
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Gap(8),
                  Icon(icons[index], size: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
