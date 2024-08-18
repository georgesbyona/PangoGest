import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shared.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.helperText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  final TextEditingController controller;
  final bool obscureText;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return TextFormField(
      autocorrect: false,
      controller: controller,
      obscureText: obscureText,
      onTapOutside: (event) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      cursorColor: AppColors.white,
      cursorErrorColor: AppColors.red,
      style: GoogleFonts.raleway(
        color: AppColors.white,
        fontWeight: FontWeight.w600,
        fontSize: 15,
      ),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.raleway(
          color: AppColors.white,
          fontSize: 13,
          fontWeight: FontWeight.normal,
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.raleway(
          color: Colors.grey.shade700,
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
        disabledBorder: InputBorder.none,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.blackO,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.white,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.red,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
        helperText: helperText,
        helperMaxLines: 2,
        helperStyle: GoogleFonts.raleway(
          color: AppColors.white,
          fontSize: width * 0.025,
          fontWeight: FontWeight.w300,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez remplir ce champ !';
        }
        return null;
      },
    );
  }
}
