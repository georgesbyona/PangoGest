import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/shared.dart';
import '../../views.dart';

class WrapperInscriptionConnexion extends StatelessWidget {
  const WrapperInscriptionConnexion({
    super.key,
    this.canPop = false,
    required this.fromConnexion,
  });

  final bool fromConnexion;
  final bool canPop;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        canPop
            ? Navigator.pop(context)
            : fromConnexion
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProprioInscription(
                        fromConnexion: true,
                      ),
                    ),
                  )
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ConnexionPage(
                        fromInscription: true,
                      ),
                    ),
                  );
      },
      child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: !fromConnexion
              ? Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Avez-vous un compte ? ",
                        style: GoogleFonts.raleway(
                          fontWeight: FontWeight.normal,
                          color: AppColors.white,
                          letterSpacing: 1,
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text: "Connectez-vous ici",
                        style: GoogleFonts.poiretOne(
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
                          letterSpacing: 1,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                )
              : Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "N'avez-vous pas un compte ? ",
                        style: GoogleFonts.raleway(
                          fontWeight: FontWeight.normal,
                          color: AppColors.white,
                          letterSpacing: 1,
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text: "Créez en un ici",
                        style: GoogleFonts.poiretOne(
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
                          letterSpacing: 1,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }
}
