import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

Container replyView({
  double? width,
  String? replyTo,
  ThemeData? theme,
  ReplyMessage? replyMessage,
  VoidCallBack? onTap,
}) {
  return Container(
    width: width,
    margin: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
    padding: const EdgeInsets.only(
      top: 10,
      left: 13,
      right: 13,
      bottom: 50,
    ),
    decoration: BoxDecoration(
      color: theme!.colorScheme.inverseSurface.withOpacity(0.3),
      borderRadius: BorderRadius.circular(25),
      border: Border.all(
        color: theme.highlightColor,
        width: 5,
      ),
    ),
    child: Text.rich(
      TextSpan(
        children: [
          WidgetSpan(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Réponse à $replyTo",
                      style: GoogleFonts.raleway(
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                      ),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: Container(
                        color: Colors.transparent,
                        child: const Icon(Icons.close_rounded, size: 20),
                      ),
                    ),
                  ],
                ),
                const Gap(2),
                Text(
                  replyMessage!.message,
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
