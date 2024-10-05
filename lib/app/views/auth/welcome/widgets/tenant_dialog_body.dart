import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/shared.dart';
import '../../../views.dart';

Container tenantDialogBody(BuildContext context, double width) {
  final TextEditingController controller = TextEditingController();
  return Container(
    padding: const EdgeInsets.only(
      top: 10,
      left: 10,
      right: 10,
      bottom: 20,
    ),
    width: width * 0.7,
    height: 225,
    child: Column(
      children: [
        const Gap(15),
        Text(
          "Entrer votre mot clé du contrat",
          style: GoogleFonts.raleway(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: width * 0.04,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              CustomTextField(
                controller: controller,
                keyboardType: TextInputType.number,
                maxLength: 8,
              ),
              const Gap(15),
              bottomDialogButtonView(
                context,
                isCenter: true,
                confirmText: "Confirmer",
                onTap: () {
                  if (int.parse(controller.text) == 00000000) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TenantInscription(),
                      ),
                    );
                  } else if (controller.text.length != 8) {
                    myCustomSnackBar(context: context, text: 'Trop court');
                  } else {
                    myCustomSnackBar(
                      context: context,
                      text: 'Mot de passe incorrect',
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
