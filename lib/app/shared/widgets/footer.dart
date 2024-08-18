import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shared.dart';

class CustomFooter extends StatelessWidget {
  final bool isWhite;
  const CustomFooter({super.key, this.isWhite = false});

  @override
  Widget build(BuildContext context) {
    dynamic sizeWidth = MediaQuery.sizeOf(context).width;
    return Container(
      width: sizeWidth,
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Gap(10),
          isWhite
              ? Text(
                  'Designated by LosingTech®',
                  style: GoogleFonts.raleway(
                    fontSize: sizeWidth * 0.023,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                  textAlign: TextAlign.center,
                )
              : Text(
                  'Designated by LosingTech®',
                  style: GoogleFonts.raleway(
                    fontSize: sizeWidth * 0.023,
                    color: Theme.of(context).primaryColorLight,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
          const Gap(5),
          Text(
            '©LosingDynasty 2k24',
            style: GoogleFonts.raleway(
              fontSize: sizeWidth * 0.02,
              color: Theme.of(context).primaryColor,
              letterSpacing: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
