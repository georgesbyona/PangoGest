import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSaveFormButton extends StatelessWidget {
  const CustomSaveFormButton({
    super.key,
    required this.onTap,
    this.btnText = "Ajouter",
  });

  final VoidCallback onTap;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.inversePrimary,
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 10,
        ),
        margin: const EdgeInsets.only(right: 15),
        child: Text(
          btnText,
          style: GoogleFonts.indieFlower(color: theme.highlightColor),
        ),
      ),
    );
  }
}
