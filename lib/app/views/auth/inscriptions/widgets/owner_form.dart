import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';

class ProprioForm extends StatefulWidget {
  final TextEditingController namesController;
  final TextEditingController adressController;
  final TextEditingController mailController;
  final TextEditingController numController;
  final TextEditingController passwordsController;
  final TextEditingController keywordsController;
  const ProprioForm({
    super.key,
    required this.namesController,
    required this.adressController,
    required this.mailController,
    required this.numController,
    required this.passwordsController,
    required this.keywordsController,
  });

  @override
  State<ProprioForm> createState() => _ProprioFormState();
}

class _ProprioFormState extends State<ProprioForm> {
  bool isShowed = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final size = width > height ? height : width;
    final List icons = [
      AppIcons.profile,
      AppIcons.adresse,
      AppIcons.email,
      AppIcons.phone,
      AppIcons.passwords,
      AppIcons.keywords,
    ];
    final List labelTexts = [
      "Noms *",
      "Adresse *",
      "Email",
      "N° Tél *",
      "Mot de passe *",
      "Mot clé *",
    ];
    final List hintTexts = [
      "Georges Byona",
      "N° M047 Av. Fizi, Q. Ndendere, C. Ibanda, Bukavu",
      "georgesbyona@gmail.com",
      "+243844300329",
      "pangogest#2k24",
      "g-maison#2k24",
    ];
    final List controllers = [
      widget.namesController,
      widget.adressController,
      widget.mailController,
      widget.numController,
      widget.passwordsController,
      widget.keywordsController,
    ];
    return ListView(
      scrollDirection: Axis.vertical,
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
                  // helperText: index == 2
                  //     ? "Si t'en as pas, laisse le champ vide"
                  //     : index == 3
                  //         ? "Avec le code du pays (+243)"
                  //         : index == 5
                  //             ? "Ce mot qu'utilisera tes locataires pour se connecter"
                  //             : null,
                  keyboardType: index == 2
                      ? TextInputType.emailAddress
                      : index == 3
                          ? TextInputType.phone
                          : TextInputType.text,
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
    );
  }

  void onShowPasswords() {
    setState(() {
      isShowed = !isShowed;
    });
  }
}
