import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

import '../../../shared/shared.dart';

class AddAddressForm extends StatefulWidget {
  final TextEditingController communeController;
  final TextEditingController celluleController;
  final TextEditingController quarterController;
  final TextEditingController avenueController;
  final TextEditingController numController;
  const AddAddressForm({
    super.key,
    required this.communeController,
    required this.celluleController,
    required this.quarterController,
    required this.avenueController,
    required this.numController,
  });

  @override
  State<AddAddressForm> createState() => _AddAddressFormState();
}

class _AddAddressFormState extends State<AddAddressForm> {
  bool isShowed = false;
  @override
  Widget build(BuildContext context) {
    final List<String> labelTexts = [
      "",
      "Commune *",
      "Quartier *",
      "Cellule ",
      "Avenue *",
      "N° Maison",
    ];
    final List<String> hintTexts = [
      "",
      "Ibanda",
      "Ndendere",
      "",
      "Fizi",
      "047A",
    ];
    final List<TextEditingController> controllers = [
      TextEditingController(),
      widget.communeController,
      widget.quarterController,
      widget.celluleController,
      widget.avenueController,
      widget.numController,
    ];
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Column(
          children: List.generate(
            labelTexts.length,
            (index) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  // Icon(icons[index], color: AppColors.white),
                  if (index == 0) ...{
                    const Icon(
                      AppIcons.adresse,
                      size: 20,
                      color: AppColors.white,
                    ),
                    const Gap(10),
                    const Text(
                      "Ville : Bukavu",
                      style: TextStyle(color: AppColors.white),
                    ),
                  } else ...{
                    const Gap(30),
                    Expanded(
                      child: CustomTextField(
                        controller: controllers[index],
                        labelText: labelTexts[index],
                        hintText: hintTexts[index],
                        keyboardType: index == 2
                            ? TextInputType.emailAddress
                            : index == 5
                                ? TextInputType.phone
                                : TextInputType.text,
                        isNotRequired: index == 3 || index == 5 ? true : false,
                      ),
                    ),
                  },
                ],
              ),
            ),
          ),
        ),
        const Gap(200),
      ],
    );
  }
}
