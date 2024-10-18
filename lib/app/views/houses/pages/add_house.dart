import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<MainController>(context);
    final user = Provider.of<UserDataController>(context);
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
                    CustomMainButton(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          final response = await AddressAPI.registerAddress(
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
                          if (response.first == true) {
                            debugPrint("Address ID = ${response.last}");
                            final response2 =
                                await RealEstateAPI.createRealEstate(
                              HouseModel(
                                price: priceCtr.text.trim(),
                                description: descriptionCtr.text.trim(),
                                surface: surfaceCtr.text.trim(),
                                addressID: response.last,
                                userID: user.userID!,
                              ),
                            );
                            if (response2.first == true) {
                              debugPrint(
                                  "===================== ${response2.last}");
                            }
                          }
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
}
