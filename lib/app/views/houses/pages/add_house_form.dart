import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

import '../../../shared/shared.dart';

class AddHouseForm extends StatefulWidget {
  final TextEditingController descriptionCtr;
  final TextEditingController surfaceCtr;
  final TextEditingController priceCtr;
  final TextEditingController communeController;
  final TextEditingController celluleController;
  final TextEditingController quarterController;
  final TextEditingController avenueController;
  final TextEditingController numController;
  const AddHouseForm({
    super.key,
    required this.priceCtr,
    required this.surfaceCtr,
    required this.descriptionCtr,
    required this.communeController,
    required this.celluleController,
    required this.quarterController,
    required this.avenueController,
    required this.numController,
  });

  @override
  State<AddHouseForm> createState() => _AddHouseFormState();
}

class _AddHouseFormState extends State<AddHouseForm> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final size = width > height ? height : width;
    final List icons = [
      AppIcons.price,
      AppIcons.description,
      AppIcons.surface,
      AppIcons.adresse,
      null,
      null,
      null,
      null,
      null,
    ];
    final List<String> labelTexts = [
      "Prix (en \$) *",
      "Description *",
      "Surface *",
      "",
      "Commune *",
      "Quartier *",
      "Cellule ",
      "Avenue *",
      "N° Maison",
    ];
    final List<String> hintTexts = [
      "100",
      "...",
      "25x50",
      "",
      "Ibanda",
      "Ndendere",
      "",
      "Fizi",
      "047A",
    ];
    final List<TextEditingController> controllers = [
      widget.priceCtr,
      widget.descriptionCtr,
      widget.surfaceCtr,
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
            icons.length,
            (index) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: index == 1
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  if (index == 3) ...{
                    Icon(icons[index]),
                    const Gap(10),
                    const Text("Ville : Bukavu"),
                  } else ...{
                    Icon(icons[index]),
                    Gap(size * 0.03),
                    Expanded(
                      child: CustomTextField(
                        canChange: true,
                        controller: controllers[index],
                        labelText: labelTexts[index],
                        hintText: hintTexts[index],
                        keyboardType: index == 0
                            ? TextInputType.number
                            : index == 1
                                ? TextInputType.multiline
                                : TextInputType.text,
                        maxLines: index == 1 ? 4 : null,
                        isNotRequired: index == 6 || index == 8 ? true : false,
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
