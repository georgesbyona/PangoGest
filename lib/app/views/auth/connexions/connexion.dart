import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/controllers.dart';
import '../../../shared/shared.dart';
import '../widgets/auth_bottom_view.dart';
import '../widgets/wrapper_inscription_connexion.dart';
import 'widgets/connexion_form.dart';

class ConnexionPage extends StatefulWidget {
  const ConnexionPage({super.key, this.fromInscription = false});

  final bool fromInscription;

  @override
  State<ConnexionPage> createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  final TextEditingController keyController = TextEditingController();
  final TextEditingController wordsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataController>(context);
    final userName = userData.names!.split(' ')[0];
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.blackB,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.symmetric(horizontal: width * 0.1, vertical: 50),
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
                        fontSize: width * 0.06,
                      ),
                    ),
                    const Gap(15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bienvenu.e encore",
                          style: GoogleFonts.raleway(
                            color: Colors.grey.shade300,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "$userName !",
                          style: GoogleFonts.raleway(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          "Nous sommes ravi de vous compter parmi nous ! Veuillez compléter ce champs pour vous connecter à votre compte !",
                          style: GoogleFonts.raleway(
                            color: Colors.grey.shade300,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 1.2,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: ConnexionForm(
                          keyController: keyController,
                          wordsController: wordsController,
                        ),
                      ),
                    ),
                    const Gap(50),
                    userData.isConnecting
                        ? Container(
                            alignment: Alignment.center,
                            color: Colors.transparent,
                            padding:
                                EdgeInsets.symmetric(vertical: height * 0.02),
                            margin:
                                EdgeInsets.symmetric(vertical: height * 0.015),
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : CustomMainButton(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                await userData.connectUser(
                                  context,
                                  keyController.text,
                                  wordsController.text,
                                );
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
              const Gap(100),
              const AuthBottomView(),
            ],
          ),
        ),
      ),
    );
  }
}
