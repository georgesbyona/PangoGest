import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../forgot_password/forgot_password.dart';
import '../../../shared/shared.dart';

class ConnexionForm extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController keyController;
  const ConnexionForm({
    super.key,
    required this.keyController,
    required this.passwordController,
  });

  @override
  State<ConnexionForm> createState() => _ConnexionFormState();
}

class _ConnexionFormState extends State<ConnexionForm> {
  bool isShowed = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final size = width > height ? height : width;
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              const Icon(AppIcons.keywords, color: AppColors.white),
              Gap(size * 0.03),
              Expanded(
                child: CustomTextField(
                  controller: widget.keyController,
                  labelText: "Email/N° Tél",
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              const Icon(AppIcons.passwords, color: AppColors.white),
              Gap(size * 0.03),
              Expanded(
                child: CustomTextField(
                  controller: widget.passwordController,
                  labelText: "Mot de passe",
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  obscureText: !isShowed,
                ),
              ),
              GestureDetector(
                onTap: onShowPasswords,
                child: Container(
                  padding: EdgeInsets.only(left: width * 0.05),
                  child: Icon(
                    isShowed ? AppIcons.eyeShow : AppIcons.eyeHide,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ForgotPasswordPage(),
              ),
            );
          },
          child: Container(
            color: Colors.transparent,
            child: Text(
              'Mot de passe oublié !',
              style: GoogleFonts.poiretOne(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                letterSpacing: 1,
                fontSize: 13,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ),
      ],
    );
  }

  void onShowPasswords() {
    setState(() {
      isShowed = !isShowed;
    });
  }
}
