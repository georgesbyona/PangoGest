import 'dart:convert';

import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

import '../widgets/wrapper_inscription_connexion.dart';
import '../widgets/auth_bottom_view.dart';
import '../add_address/add_address.dart';
import '../../../shared/shared.dart';
import 'inscription_form.dart';

class ProprioInscription extends StatefulWidget {
  static const route = "/proprioInstruction";
  const ProprioInscription({super.key, this.fromConnexion = false});

  final bool fromConnexion;

  @override
  State<ProprioInscription> createState() => _ProprioInscriptionState();
}

class _ProprioInscriptionState extends State<ProprioInscription> {
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
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          final url = Uri.parse(
                            "http://192.168.1.116:8000/api/utilisateurs/",
                          );
                          var body = jsonEncode(
                            {
                              "username": mailController.text,
                              "first_name": firstNameController.text,
                              "last_name": lastNameController.text,
                              "email": mailController.text,
                              "telephone": numController.text,
                              "photo_url": mailController.text ==
                                      "georgesbyona@gmail.com"
                                  ? "https://lh3.googleusercontent.com/a/ACg8ocLrFO4QlXqP0Elvw0cspu9YMHbut7Os8iSPpfxtzo6NTJZtw5s=s96-c"
                                  : "https://firebasestorage.googleapis.com/v0/b/pangogest.appspot.com/o/profil.png?alt=media&token=800f4279-9fb1-463f-8add-c0f485310caa",
                              "password": passwordController.text,
                              "user_type": "bailleur"
                            },
                          );
                          try {
                            final response = await http.post(
                              url,
                              headers: {
                                'Content-Type':
                                    'application/json; charset=UTF-8',
                              },
                              body: body,
                            );
                            if (response.statusCode == 201) {
                              debugPrint(
                                "======================== User ${firstNameController.text} is successfully created",
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddAddress(
                                    email: mailController.text,
                                  ),
                                ),
                              );
                            } else if (response.statusCode == 400) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddAddress(
                                    email: mailController.text,
                                  ),
                                ),
                              );
                            } else {
                              debugPrint("Body : ${response.body}");
                              debugPrint("Error : ${response.statusCode}");
                            }
                          } catch (e) {
                            debugPrint("Erreur lors du post : $e");
                          }
                          // firstNameController.clear();
                          // lastNameController.clear();
                          // mailController.clear();
                          // numController.clear();
                          // passwordsController.clear();
                          // Navigator.pop(context);
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
              const Gap(20),
              const AuthBottomView(),
            ],
          ),
        ),
      ),
    );
  }
}
