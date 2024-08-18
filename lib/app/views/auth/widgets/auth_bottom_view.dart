import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/shared.dart';
import '../../views.dart';

class AuthBottomView extends StatelessWidget {
  const AuthBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TermsAndConditions(),
            ),
          ),
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Trouver ",
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.normal,
                      color: AppColors.white,
                      fontSize: 13,
                    ),
                  ),
                  TextSpan(
                    text: "les termes et conditions ici",
                    style: GoogleFonts.poiretOne(
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Text(
          "©copyright2k24",
          style: GoogleFonts.poiretOne(
            fontWeight: FontWeight.bold,
            color: theme.primaryColor,
            fontSize: 12,
            height: 3,
          ),
        ),
      ],
    );
  }
}
