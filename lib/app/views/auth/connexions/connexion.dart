import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/wrapper_inscription_connexion.dart';
import '../../../../controllers/controllers.dart';
import '../widgets/auth_bottom_view.dart';
import '../../../shared/shared.dart';
import 'connexion_form.dart';

class ConnexionPage extends StatefulWidget {
  const ConnexionPage({super.key, this.fromInscription = false});

  final bool fromInscription;

  @override
  State<ConnexionPage> createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  final TextEditingController keyController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isConnecting = false;

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
                          "Connexion",
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
                              "Bienvenu.e encore",
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
                              "Nous sommes ravi de vous compter parmi nous ! Veuillez compléter ce champs pour vous connecter à votre compte !",
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
                          child: Form(
                            key: _formKey,
                            child: ConnexionForm(
                              keyController: keyController,
                              passwordController: passwordController,
                            ),
                          ),
                        ),
                        Gap(height * 0.015),
                        isConnecting
                            ? Container(
                                alignment: Alignment.center,
                                color: Colors.transparent,
                                padding: EdgeInsets.symmetric(
                                  vertical: height * 0.02,
                                ),
                                margin: EdgeInsets.symmetric(
                                  vertical: height * 0.015,
                                ),
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : CustomMainButton(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    connectingInProgress();
                                    await userData.connectUser(
                                      context,
                                      keyController.text,
                                      passwordController.text,
                                    );
                                    connectingInProgress();
                                  }
                                },
                                text: "Se connecter",
                              ),
                      ],
                    ),
                  ),
                  WrapperInscriptionConnexion(
                    fromConnexion: true,
                    canPop: widget.fromInscription,
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

  void connectingInProgress() {
    setState(() {
      isConnecting = !isConnecting;
    });
  }
}
