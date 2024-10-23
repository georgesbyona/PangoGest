import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controllers/controllers.dart';
import '../../../../data/data.dart';
import '../../../shared/shared.dart';
import 'add_house_form.dart';

class AddHouse extends StatefulWidget {
  const AddHouse({super.key});

  @override
  State<AddHouse> createState() => _AddHouseState();
}

class _AddHouseState extends State<AddHouse> {
  final TextEditingController priceCtr = TextEditingController();
  final TextEditingController surfaceCtr = TextEditingController();
  final TextEditingController descriptionCtr = TextEditingController();
  final TextEditingController communeController = TextEditingController();
  final TextEditingController celluleController = TextEditingController();
  final TextEditingController quarterController = TextEditingController();
  final TextEditingController avenueController = TextEditingController();
  final TextEditingController numController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isRegisterUser = false;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<MainController>(context);
    final user = Provider.of<UserDataController>(context);
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text("Ajout d'une maison")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 50,
            right: 50,
            bottom: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Veuillez ajouter les informations ci-après sur votre maison !",
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.normal,
                            letterSpacing: 1.2,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Gap(15),
                    controller.selectedFile == null
                        ? GestureDetector(
                            onTap: () => controller.pickImgFromGallery(context),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).unselectedWidgetColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              width: width,
                              height: 200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Iconsax.gallery_add_outline,
                                    color: AppColors.black,
                                  ),
                                  const Gap(5),
                                  Text(
                                    "Ajouter une image",
                                    style: TextStyle(color: AppColors.black),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () => controller.pickImgFromGallery(context),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).unselectedWidgetColor,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: FileImage(controller.selectedFile),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              width: width,
                              height: 200,
                            ),
                          ),
                    Gap(15),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: AddHouseForm(
                          priceCtr: priceCtr,
                          descriptionCtr: descriptionCtr,
                          surfaceCtr: surfaceCtr,
                          communeController: communeController,
                          celluleController: celluleController,
                          quarterController: quarterController,
                          avenueController: avenueController,
                          numController: numController,
                        ),
                      ),
                    ),
                    Gap(15),
                    isRegisterUser
                        ? Container(
                            alignment: Alignment.center,
                            color: Colors.transparent,
                            margin: EdgeInsets.symmetric(vertical: 40),
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : CustomMainButton(
                            onTap: () async {
                              if (_formKey.currentState!.validate() &&
                                  controller.selectedFile != null) {
                                registeringInProgress();
                                final url = await controller
                                    .uploadImage(controller.selectedFile);
                                final response =
                                    await AddressAPI.registerAddress(
                                  AddressModel(
                                    ville: "Bukavu",
                                    commune: communeController.text.trim(),
                                    quartier: quarterController.text.trim(),
                                    cellule: celluleController.text.isNotEmpty
                                        ? celluleController.text.trim()
                                        : null,
                                    avenue: avenueController.text.trim(),
                                    num: numController.text.isNotEmpty
                                        ? numController.text.trim()
                                        : "0000",
                                  ),
                                );
                                if (response.first == true && url.isNotEmpty) {
                                  debugPrint("Address ID = ${response.last}");
                                  final success = await controller.addHouse(
                                    HouseModel(
                                      price: priceCtr.text.trim(),
                                      description: descriptionCtr.text.trim(),
                                      surface: surfaceCtr.text.trim(),
                                      addressID: response.last,
                                      userID: user.userID!,
                                      photo: url,
                                    ),
                                  );
                                  if (success) {
                                    myCustomSnackBar(
                                      context: context,
                                      text: "Maison ajouté",
                                    );
                                    Navigator.pop(context);
                                  } else {
                                    myCustomSnackBar(
                                      context: context,
                                      text: "Erreur !",
                                    );
                                  }
                                }
                                registeringInProgress();
                              }
                            },
                            text: "Ajouter",
                          ),
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
