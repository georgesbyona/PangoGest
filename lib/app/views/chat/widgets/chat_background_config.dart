import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';
import 'package:google_fonts/google_fonts.dart';

ChatBackgroundConfiguration chatBckConfig(ThemeData theme) {
  return ChatBackgroundConfiguration(
    messageTimeIconColor: theme.primaryColor,
    messageTimeTextStyle: GoogleFonts.poiretOne(
      fontWeight: FontWeight.w300,
      fontSize: 12,
    ),
    defaultGroupSeparatorConfig: DefaultGroupSeparatorConfiguration(
      textStyle: GoogleFonts.poiretOne(),
    ),
    loadingWidget: const LinearProgressIndicator(minHeight: 2),
    backgroundColor: theme.scaffoldBackgroundColor,
  );
}
