import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../data/data.dart';
import '../../../../shared/shared.dart';
import '../../../views.dart';

Container tenantDialogBody(BuildContext context, double width) {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController keyWordController = TextEditingController();
  return Container(
    padding: const EdgeInsets.only(
      top: 10,
      bottom: 20,
    ),
    width: width * 0.8,
    height: 290,
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
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              CustomTextField(
                labelText: "Email (qui a reçu le mail)",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              CustomTextField(
                labelText: "Mot clé (envoyé par mail)",
                controller: keyWordController,
                keyboardType: TextInputType.text,
                maxLength: 10,
              ),
              const Gap(15),
              bottomDialogButtonView(
                context,
                isCenter: true,
                confirmText: "Confirmer",
                onTap: () async {
                  if (keyWordController.text.length != 10) {
                    myCustomSnackBar(
                        context: context, text: 'Mot clé trop court');
                  } else {
                    final success = await ContractAPI.verificationMotCle(
                      emailController.text.trim(),
                      keyWordController.text.trim(),
                    );
                    if (success) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TenantInscription(),
                        ),
                      );
                    } else {
                      myCustomSnackBar(
                        context: context,
                        text: 'Contrat inexistant',
                      );
                    }
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
