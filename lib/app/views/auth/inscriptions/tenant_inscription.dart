import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pangogest/data/data.dart';

import '../widgets/auth_bottom_view.dart';
import '../../../shared/shared.dart';
import 'inscription_form.dart';

class TenantInscription extends StatefulWidget {
  const TenantInscription({super.key});

  @override
  State<TenantInscription> createState() => _TenantInscriptionState();
}

class _TenantInscriptionState extends State<TenantInscription> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController numController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordCtr = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    lightCustomSystemChrome();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final size = width > height ? height : width;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.blackB,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Création d'un compte",
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: AppColors.white,
                        fontSize: size * 0.06,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      "Veuillez prendre un petit moment\npour compléter les informations ci-après\nqui nous serons utiles pour une\nmeilleure expérience avec ",
                      style: GoogleFonts.raleway(
                        color: Colors.grey.shade300,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 1.2,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "PangoGest ! ",
                          style: GoogleFonts.raleway(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 25,
                          height: 25,
                          child: Image.asset(AppImages.logo),
                        ),
                      ],
                    ),
                    const Gap(10),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: InscriptionForm(
                          firstNameController: firstNameController,
                          lastNameController: lastNameController,
                          mailController: mailController,
                          numController: numController,
                          passwordController: passwordController,
                          confirmPasswordCtr: confirmPasswordCtr,
                        ),
                      ),
                    ),
                    const Gap(15),
                    CustomMainButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          FireStoreDB().registerUser(
                            UserModel(
                              firstName: firstNameController.text.trim(),
                              lastName: lastNameController.text.trim(),
                              email: mailController.text.trim(),
                              num: numController.text.trim(),
                              password: passwordController.text.trim(),
                              userType: "tenant",
                            ),
                            "georgesbyona@gmail.com",
                          );
                        }
                      },
                      text: "Continuer",
                    ),
                  ],
                ),
              ),
              const Gap(20),
              const AuthBottomView(),
            ],
          ),
        ),
      ),
    );
  }
}
