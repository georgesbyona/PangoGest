import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

import '../../../shared/shared.dart';

class InscriptionForm extends StatefulWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController mailController;
  final TextEditingController numController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordCtr;
  const InscriptionForm({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.mailController,
    required this.numController,
    required this.passwordController,
    required this.confirmPasswordCtr,
  });

  @override
  State<InscriptionForm> createState() => _InscriptionFormState();
}

class _InscriptionFormState extends State<InscriptionForm> {
  bool isShowed = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final size = width > height ? height : width;
    final List<IconData> icons = [
      AppIcons.profile,
      AppIcons.profileB,
      AppIcons.email,
      AppIcons.phone,
      AppIcons.passwords,
      AppIcons.passwords,
    ];
    final List<String> labelTexts = [
      "Prenom *",
      "Nom *",
      "Email *",
      "N° Tél *",
      "Mot de passe *",
      "Confirmer Mot de passe",
    ];
    final List<String> hintTexts = [
      "Toussaint",
      "Mushamuka",
      "toussaintmushamuka4@gmail.com",
      "+243994822893",
      "********",
      "********",
    ];
    final List<TextEditingController> controllers = [
      widget.firstNameController,
      widget.lastNameController,
      widget.mailController,
      widget.numController,
      widget.passwordController,
      widget.confirmPasswordCtr,
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
                children: [
                  Icon(icons[index], color: AppColors.white),
                  Gap(size * 0.03),
                  Expanded(
                    child: CustomTextField(
                      controller: controllers[index],
                      labelText: labelTexts[index],
                      hintText: hintTexts[index],
                      keyboardType: index == 2
                          ? TextInputType.emailAddress
                          : index == 3
                              ? TextInputType.phone
                              : TextInputType.text,
                      maxLength: index == 3 ? 13 : null,
                      obscureText: index == 4 || index == 5 ? !isShowed : false,
                    ),
                  ),
                  if (index == 4 || index == 5) ...{
                    GestureDetector(
                      onTap: onShowPasswords,
                      child: Container(
                        padding: EdgeInsets.only(left: size * 0.05),
                        child: Icon(
                          isShowed ? AppIcons.eyeShow : AppIcons.eyeHide,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  }
                ],
              ),
            ),
          ),
        ),
        const Gap(200),
      ],
    );
  }

  void onShowPasswords() {
    setState(() {
      isShowed = !isShowed;
    });
  }
}
