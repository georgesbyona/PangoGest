import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({
    super.key,
    this.icon = Iconsax.add_outline,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FloatingActionButton.extended(
      onPressed: onPressed,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      backgroundColor: theme.highlightColor,
      icon: Icon(icon),
      label: const Text("Nouveau"),
      extendedTextStyle: GoogleFonts.indieFlower(
        fontWeight: FontWeight.w600,
        letterSpacing: 1.5,
      ),
    );
  }
}

class CustomFABMini extends StatelessWidget {
  const CustomFABMini({
    super.key,
    this.icon = Iconsax.add_outline,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FloatingActionButton(
      onPressed: onPressed,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      backgroundColor: theme.highlightColor,
      child: Icon(icon),
    );
  }
}
