import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pangogest/app/views/tenants/pages/new_tenant/widgets/tenant_date_picker.dart';

import '../../../../../controllers/controllers.dart';
import '../../../../../data/data.dart';
import 'widgets/new_tenant_text_field.dart';
import '../../../../shared/shared.dart';

class AddNewTenantPage extends StatefulWidget {
  const AddNewTenantPage({super.key, required this.controller});

  final MainController controller;

  @override
  State<AddNewTenantPage> createState() => _AddNewTenantPageState();
}

class _AddNewTenantPageState extends State<AddNewTenantPage> {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController dureeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool isRegisterUser = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<TextEditingController> controllers = [
      emailController,
      priceController,
      dureeController,
    ];

    List<String> housesID = [];
    // widget.controller.readHouses();
    for (var house in widget.controller.houses) {
      housesID.add(house.id.toString());
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          isRegisterUser
              ? Container(
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  margin: EdgeInsets.only(right: 40),
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : CustomSaveFormButton(
                  onTap: () async {
                    if (priceController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        dureeController.text.isEmpty ||
                        widget.controller.currentHouse == null) {
                      myCustomSnackBar(
                        context: context,
                        text: "Veuillez compléter tous les champs",
                        backgroundColor: AppColors.red,
                      );
                    } else {
                      registeringInProgress();
                      final success = await ContractAPI.createContract(
                        ContractModel(
                          dateDebut: widget.controller.contractDate.toString(),
                          dateContrat: DateFormat('yyyy-MM-dd')
                              .format(DateTime.now())
                              .toString(),
                          duree: int.parse(dureeController.text.trim()),
                          price: priceController.text.trim(),
                          tenantEmail: emailController.text.trim(),
                          houseID: int.parse(widget.controller.currentHouse!),
                        ),
                      );
                      if (success) {
                        priceController.clear();
                        dureeController.clear();
                        emailController.clear();
                        myCustomSnackBar(
                          context: context,
                          text: "Contrat créé",
                        );
                        registeringInProgress();
                        Navigator.pop(context);
                      } else {
                        myCustomSnackBar(
                          context: context,
                          text: "Erreur !",
                        );
                        registeringInProgress();
                      }
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
                "Nouveau Contrat",
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const Gap(15),
              Text(
                "En ajoutant ces informaations, vous créez un nouveau contrat avec votre locataire, et il doit se connecter à l'application pour que votre contrat soit conclu parfaitement dans notre système.",
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const Gap(15),
              Text(
                "* indique les champs obligatoire",
                style: GoogleFonts.raleway(fontSize: 12),
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
                    TenantDatePicker(
                      onTap: () {
                        widget.controller.pickDate(context);
                      },
                      controller: widget.controller,
                    ),
                    const Gap(20),
                    Row(
                      children: [
                        Icon(AppIcons.houses),
                        const Gap(20),
                        CustomDropDownButton(
                          datas: housesID,
                          hitnText: "Cliquer pour sélectionner une maison...",
                          displayValue: widget.controller.currentHouse,
                          onChanged: (value) {
                            widget.controller.pickHouseID(value);
                          },
                        ),
                      ],
                    ),
                    const Gap(50),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //       "Note : ",
                    //       style: GoogleFonts.raleway(fontSize: 18),
                    //     ),
                    //     Expanded(
                    //       child: Text(
                    //         "En ajoutant un nouveau Locataire, celui-ci doit avoir un contrat valide avec vous et le mot clé que vous entrez ici servira de sa clé de connexion dans cette app ainsi il sera lié directement à vous.",
                    //         style: theme.textTheme.bodySmall!.copyWith(
                    //           letterSpacing: 2,
                    //           fontSize: 13,
                    //         ),
                    //         overflow: TextOverflow.ellipsis,
                    //         maxLines: 10,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const Gap(50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void registeringInProgress() {
    setState(() {
      isRegisterUser = !isRegisterUser;
    });
  }
}

List<IconData> icons = [
  AppIcons.email,
  AppIcons.calendar,
  AppIcons.price,
];
List<String> labels = [
  "Email du locataire",
  "Durée du contrat (en mois) *",
  "Prix de la maison *",
];
List<String> hints = [
  "georgesbyona@gmail.com",
  "6",
  "100",
];
List<TextInputType> keyboardTypes = [
  TextInputType.emailAddress,
  TextInputType.number,
  TextInputType.number,
];
