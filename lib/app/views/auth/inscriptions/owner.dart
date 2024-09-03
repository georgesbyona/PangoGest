import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/controllers.dart';
import '../widgets/auth_bottom_view.dart';
import '../../../shared/shared.dart';
import '../../../../data/data.dart';
import '../widgets/wrapper_inscription_connexion.dart';
import 'widgets/owner_form.dart';

class ProprioInscription extends StatefulWidget {
  static const route = "/proprioInstruction";
  const ProprioInscription({super.key, this.fromConnexion = false});

  final bool fromConnexion;

  @override
  State<ProprioInscription> createState() => _ProprioInscriptionState();
}

class _ProprioInscriptionState extends State<ProprioInscription> {
  final TextEditingController namesController = TextEditingController();
  final TextEditingController adressController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController numController = TextEditingController();
  final TextEditingController passwordsController = TextEditingController();
  final TextEditingController keywordsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    lightCustomSystemChrome();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    final userData = Provider.of<UserDataController>(context);
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
                          "Création d'un compte",
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: AppColors.white,
                            fontSize: size * 0.06,
                          ),
                        ),
                        Gap(height * 0.015),
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
                        Gap(height * 0.005),
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
                        Gap(height * 0.015),
                        Expanded(
                          child: Form(
                            key: _formKey,
                            child: ProprioForm(
                              namesController: namesController,
                              adressController: adressController,
                              mailController: mailController,
                              numController: numController,
                              passwordsController: passwordsController,
                              keywordsController: keywordsController,
                            ),
                          ),
                        ),
                        Gap(height * 0.015),
                        userData.isRegisterUser
                            ? Container(
                                alignment: Alignment.center,
                                color: Colors.transparent,
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.02),
                                margin: EdgeInsets.symmetric(
                                    vertical: height * 0.015),
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : CustomMainButton(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await userData.registerUser(
                                      UserModel(
                                        names: namesController.text,
                                        imgUrl:
                                            "https://lh3.googleusercontent.com/a/ACg8ocLrFO4QlXqP0Elvw0cspu9YMHbut7Os8iSPpfxtzo6NTJZtw5s=s96-c",
                                        adresse: AdresseModel(
                                          id: adressController.text,
                                          ville: adressController.text
                                              .split(',')[3],
                                          commune: adressController.text
                                              .split(',')[2],
                                          quartier: adressController.text
                                              .split(',')[1],
                                          cellule: "",
                                          avenue: adressController.text
                                              .split(',')[0]
                                              .split(" ")[1],
                                          num: adressController.text
                                              .split(',')[0]
                                              .split(" ")[0],
                                        ),
                                        email: mailController.text,
                                        num: numController.text,
                                        passwords: passwordsController.text,
                                        keywords: keywordsController.text,
                                        userType: "propriétaire",
                                      ),
                                    );
                                    namesController.clear();
                                    adressController.clear();
                                    mailController.clear();
                                    numController.clear();
                                    passwordsController.clear();
                                    keywordsController.clear();
                                    Navigator.pop(context);
                                  }
                                },
                                text: "S'inscrire",
                              ),
                      ],
                    ),
                  ),
                  WrapperInscriptionConnexion(
                    fromConnexion: false,
                    canPop: widget.fromConnexion,
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
