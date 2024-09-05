import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/shared.dart';

class TitleField extends StatelessWidget {
  const TitleField({super.key, required this.titleTextController});

  final TextEditingController titleTextController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        autocorrect: false,
        controller: titleTextController,
        onTapOutside: (event) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        cursorColor: theme.colorScheme.inversePrimary,
        cursorErrorColor: AppColors.red,
        maxLines: 1,
        style: GoogleFonts.raleway(
          color: theme.colorScheme.inverseSurface,
          fontWeight: FontWeight.normal,
          fontSize: 25,
        ),
        decoration: InputDecoration(
          hintText: "Taper un titre",
          hintStyle: GoogleFonts.raleway(
            color: theme.colorScheme.inverseSurface,
            fontWeight: FontWeight.normal,
            fontSize: 25,
          ),
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
