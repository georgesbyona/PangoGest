import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controllers/controllers.dart';
import '../widgets/auth_bottom_view.dart';
import '../../../shared/shared.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataController>(context);
    final userName = userData.names!.split(' ')[0];
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth > constraints.maxHeight
            ? constraints.maxHeight
            : constraints.maxWidth;
        return Scaffold(
          backgroundColor: AppColors.blackB,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.1,
                vertical: height * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Mot de passe oublié",
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: AppColors.white,
                            fontSize: size * 0.06,
                          ),
                        ),
                        Gap(height * 0.015),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Oups",
                              style: GoogleFonts.raleway(
                                color: Colors.grey.shade300,
                                fontWeight: FontWeight.w600,
                                fontSize: size * 0.04,
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              "$userName !",
                              style: GoogleFonts.raleway(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.normal,
                                fontSize: size * 0.05,
                              ),
                            ),
                            Text(
                              "Vous avez oublié votre mot de passe !\nPas d'inquiétude, veuillez nous fournir soit votre adresse mail soit votre numéro et nous vous enverrons un mot de passe pour la réinitialisation de votre ancien mot de passe.",
                              style: GoogleFonts.raleway(
                                color: Colors.grey.shade300,
                                fontWeight: FontWeight.normal,
                                fontSize: size * 0.03,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                        Gap(height * 0.015),
                        Expanded(
                          child: ListView(
                            children: [
                              Form(
                                key: _formKey,
                                child: Row(
                                  children: [
                                    const Icon(
                                      AppIcons.keywords,
                                      color: AppColors.white,
                                    ),
                                    Gap(size * 0.03),
                                    Expanded(
                                      child: CustomTextField(
                                        controller: textEditingController,
                                        labelText: "Email/N° Tél",
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Gap(height * 0.02),
                              CustomMainButton(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {}
                                },
                                text: "Envoyer",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(height * 0.02),
                  const AuthBottomView(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
