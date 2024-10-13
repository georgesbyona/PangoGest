import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../controllers/controllers.dart';
import '../../../../shared/shared.dart';
import 'tenant_dialog_body.dart';
import '../../../views.dart';

Container dialogBody(
  BuildContext context,
  double width,
  UserDataController userData,
) {
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
          "Continuer en tant que",
          style: GoogleFonts.raleway(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: width * 0.04,
          ),
        ),
        const Gap(15),
        accountView(
          width,
          text: "Propriétaire",
          icon: AppIcons.owner,
          onTap: () {
            if (userData.isRegister && userData.userExist) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConnexionPage(),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProprioInscription(),
                ),
              );
            }
          },
        ),
        const Gap(10),
        accountView(
          width,
          text: "Locataire",
          icon: AppIcons.tenant,
          onTap: () {
            const bckgroundColor = AppColors.blackOver;
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return Dialog(
                  alignment: Alignment.center,
                  backgroundColor: bckgroundColor,
                  child: tenantDialogBody(context, width),
                );
              },
            );
          },
        ),
      ],
    ),
  );
}

Widget accountView(
  double width, {
  String? text,
  IconData? icon,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.white),
          Text(
            "   $text",
            style: GoogleFonts.raleway(
              color: AppColors.white,
              fontWeight: FontWeight.normal,
              fontSize: width * 0.035,
              letterSpacing: 1,
              height: 1.5,
            ),
          ),
        ],
      ),
    ),
  );
}
