import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../controllers/controllers.dart';
import 'widgets/new_tenant_text_field.dart';
import '../../../../shared/shared.dart';

class AddNewTenantPage extends StatefulWidget {
  const AddNewTenantPage({super.key, required this.controller});

  final MainController controller;

  @override
  State<AddNewTenantPage> createState() => _AddNewTenantPageState();
}

class _AddNewTenantPageState extends State<AddNewTenantPage> {
  final TextEditingController namesController = TextEditingController();
  final TextEditingController houseIDController = TextEditingController();
  final TextEditingController numController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController keywordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<TextEditingController> controllers = [
      namesController,
      houseIDController,
      numController,
      emailController,
      keywordController,
    ];
    return Scaffold(
      appBar: AppBar(
        actions: [
          CustomSaveFormButton(
            onTap: () {
              if (namesController.text.isEmpty ||
                  houseIDController.text.isEmpty ||
                  numController.text.isEmpty ||
                  keywordController.text.isEmpty) {
                myCustomSnackBar(
                  context: context,
                  text: "Veuillez compléter tous les champs",
                  backgroundColor: AppColors.red,
                );
              } else if (keywordController.text.contains(" ")) {
                myCustomSnackBar(
                  context: context,
                  text: "Le mot clé ne doit pas contenir d'espace",
                  backgroundColor: AppColors.red,
                );
              } else {
                namesController.clear();
                houseIDController.clear();
                numController.clear();
                emailController.clear();
                keywordController.clear();
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Nouveau Locataire",
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const Gap(15),
              Text(
                "* indique les champs obligatoire",
                style: GoogleFonts.indieFlower(),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: false,
                  children: [
                    Column(
                      children: List.generate(
                        controllers.length,
                        (index) {
                          return NewTenantTextField(
                            controller: controllers[index],
                            icon: icons[index],
                            labelText: labels[index],
                            hintText: hints[index],
                            keyboardType: keyboardTypes[index],
                          );
                        },
                      ),
                    ),
                    const Gap(50),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Note : ",
                          style: GoogleFonts.indieFlower(fontSize: 18),
                        ),
                        Expanded(
                          child: Text(
                            "En ajoutant un nouveau Locataire, celui-ci doit avoir un contrat valide avec vous et le mot clé que vous entrez ici servira de sa clé de connexion dans cette app ainsi il sera lié directement à vous.",
                            style: theme.textTheme.bodySmall!.copyWith(
                              letterSpacing: 2,
                              fontSize: 13,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 10,
                          ),
                        ),
                      ],
                    ),
                    const Gap(50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<IconData> icons = [
  AppIcons.tenant,
  AppIcons.houses,
  AppIcons.phone,
  AppIcons.email,
  AppIcons.keywords,
];
List<String> labels = [
  "Noms *",
  "N° Maison *",
  "N° Tél *",
  "Email",
  "Mot clé *",
];
List<String> hints = [
  "Georges Byona",
  "01",
  "+243844300329",
  "georgesbyona@gmail.com",
  "mipango#2k24",
];
List<TextInputType> keyboardTypes = [
  TextInputType.text,
  TextInputType.number,
  TextInputType.phone,
  TextInputType.emailAddress,
  TextInputType.text,
];
