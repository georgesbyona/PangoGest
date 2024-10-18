import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controllers/controllers.dart';
import '../../../../data/data.dart';
import '../widgets/auth_bottom_view.dart';
import '../../../shared/shared.dart';
import 'add_address_form.dart';

class AddAddress extends StatefulWidget {
  static const route = "/addAddresse";
  const AddAddress({
    super.key,
    required this.email,
    required this.fromConnexion,
  });

  final String email;
  final bool fromConnexion;

  @override
  State<AddAddress> createState() => _AddAdresseState();
}

class _AddAdresseState extends State<AddAddress> {
  final TextEditingController communeController = TextEditingController();
  final TextEditingController celluleController = TextEditingController();
  final TextEditingController quarterController = TextEditingController();
  final TextEditingController avenueController = TextEditingController();
  final TextEditingController numController = TextEditingController();
  bool isRegisterUser = false;

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
        return Scaffold(
          backgroundColor: AppColors.blackB,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: AppColors.white),
            title: Text(
              "Ajouter votre adresse",
              style: theme.textTheme.titleMedium!.copyWith(
                color: AppColors.white,
                fontSize: 18,
              ),
            ),
          ),
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
                        Gap(height * 0.015),
                        Text(
                          "User ID : ${widget.email}\n\nVeuillez prendre un petit momen...",
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
                          child: AddAddressForm(
                            communeController: communeController,
                            celluleController: celluleController,
                            quarterController: quarterController,
                            avenueController: avenueController,
                            numController: numController,
                          ),
                        ),
                        Gap(height * 0.015),
                        isRegisterUser
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
                                  if (communeController.text.isEmpty ||
                                      quarterController.text.isEmpty ||
                                      avenueController.text.isEmpty) {
                                    myCustomSnackBar(
                                      context: context,
                                      text:
                                          "Veuillez compléter les champs obligatoires",
                                    );
                                  } else {
                                    registeringInProgress();
                                    bool addressIsRegister =
                                        await userData.registerAddress(
                                      AddressModel(
                                        ville: "Bukavu",
                                        commune: communeController.text.trim(),
                                        quartier: quarterController.text.trim(),
                                        cellule:
                                            celluleController.text.isNotEmpty
                                                ? celluleController.text.trim()
                                                : null,
                                        avenue: avenueController.text.trim(),
                                        num: numController.text.isNotEmpty
                                            ? numController.text.trim()
                                            : "0000",
                                      ),
                                    );
                                    if (addressIsRegister) {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    } else {
                                      myCustomSnackBar(
                                        context: context,
                                        text: "Erreur lors d'enregistrement",
                                      );
                                    }
                                    if (addressIsRegister &&
                                        widget.fromConnexion) {
                                      Navigator.pop(context);
                                    }
                                    registeringInProgress();
                                  }
                                },
                                text: "S'inscrire",
                              ),
                      ],
                    ),
                  ),
                  // WrapperInscriptionConnexion(
                  //   fromConnexion: false,
                  //   canPop: widget.fromConnexion,
                  // ),
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

  void registeringInProgress() {
    setState(() {
      isRegisterUser = !isRegisterUser;
    });
  }
}
