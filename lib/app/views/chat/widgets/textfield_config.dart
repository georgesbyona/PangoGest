import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';
import 'package:google_fonts/google_fonts.dart';

TextFieldConfiguration textFieldConfig(ThemeData theme) {
  return TextFieldConfiguration(
    margin: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
    borderRadius: BorderRadius.circular(25),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 10,
    ),
    hintText: "Taper votre message ...",
    hintStyle: GoogleFonts.raleway(
      color: theme.unselectedWidgetColor,
      letterSpacing: 1,
      fontSize: 13,
    ),
    textStyle: GoogleFonts.raleway(
      color: theme.colorScheme.inversePrimary,
      letterSpacing: 1,
    ),
    compositionThresholdTime: const Duration(seconds: 3),
    onMessageTyping: (status) {
      /// Do with status
      debugPrint("========== ${status.toString()}");
    },
  );
}
