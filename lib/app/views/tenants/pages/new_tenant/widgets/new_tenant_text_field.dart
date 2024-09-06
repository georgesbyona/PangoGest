import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewTenantTextField extends StatelessWidget {
  const NewTenantTextField({
    super.key,
    required this.icon,
    required this.hintText,
    required this.labelText,
    required this.controller,
    required this.keyboardType,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText, hintText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderDecoration = UnderlineInputBorder(
      borderSide: BorderSide(
        color: theme.colorScheme.inversePrimary,
        style: BorderStyle.solid,
        width: 0.5,
      ),
    );
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Icon(icon, size: 25),
          const Gap(20),
          Expanded(
            child: TextField(
              autocorrect: false,
              controller: controller,
              keyboardType: keyboardType,
              onTapOutside: (event) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              cursorColor: theme.colorScheme.inversePrimary,
              style: theme.textTheme.bodySmall!.copyWith(
                fontSize: 15,
                height: 2,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: theme.textTheme.labelMedium!.copyWith(
                  fontSize: 15,
                  height: 2,
                ),
                labelText: labelText,
                labelStyle: GoogleFonts.indieFlower(
                  color: theme.colorScheme.inversePrimary,
                ),
                focusedBorder: borderDecoration,
                enabledBorder: borderDecoration,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
