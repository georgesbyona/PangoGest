import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

ChatBubble leftChatBubble(ThemeData theme) {
  return ChatBubble(
    color: theme.primaryColorDark.withOpacity(0.7),
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(25),
      bottomRight: Radius.circular(25),
    ),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
    linkPreviewConfig: LinkPreviewConfiguration(
      backgroundColor: theme.primaryColorDark,
      bodyStyle: GoogleFonts.raleway(
        fontWeight: FontWeight.normal,
        letterSpacing: 1,
        fontSize: 12,
      ),
      titleStyle: GoogleFonts.raleway(),
      onUrlDetect: (String message) async {
        final messageParts = message.split(' ');
        final url = messageParts.firstWhere(
          (item) => item.contains('https://'),
        );
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        }
      },
      linkStyle: GoogleFonts.poiretOne(
        decoration: TextDecoration.underline,
        decorationColor: Colors.blue,
        color: Colors.blue,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.02,
        fontSize: 15,
      ),
      padding: const EdgeInsets.all(0),
      borderRadius: 10,
    ),
    textStyle: GoogleFonts.raleway(
      fontWeight: FontWeight.normal,
      letterSpacing: 1,
      fontSize: 15,
    ),
    onMessageRead: (message) {
      /// send your message reciepts to the other client
      debugPrint('=================== Message Read ${message.id}');
    },
    senderNameTextStyle: GoogleFonts.poiretOne(
      letterSpacing: 1,
      fontSize: 10,
    ),
  );
}

ChatBubble rightChatBubble(ThemeData theme) {
  return ChatBubble(
    color: theme.primaryColor.withOpacity(0.3),
    borderRadius: const BorderRadius.only(
      topRight: Radius.circular(20),
      topLeft: Radius.circular(25),
      bottomLeft: Radius.circular(25),
    ),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
    linkPreviewConfig: LinkPreviewConfiguration(
      backgroundColor: theme.primaryColor,
      bodyStyle: GoogleFonts.raleway(
        fontWeight: FontWeight.normal,
        letterSpacing: 1,
        fontSize: 12,
      ),
      titleStyle: GoogleFonts.raleway(),
      onUrlDetect: (String message) async {
        final messageParts = message.split(' ');
        final url = messageParts.firstWhere(
          (item) => item.contains('https://'),
        );
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        }
      },
      linkStyle: GoogleFonts.poiretOne(
        decoration: TextDecoration.underline,
        decorationColor: Colors.blue,
        color: Colors.blue,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.02,
        fontSize: 15,
      ),
      padding: const EdgeInsets.all(0),
      borderRadius: 10,
    ),
    textStyle: GoogleFonts.raleway(
      fontWeight: FontWeight.normal,
      letterSpacing: 1,
      fontSize: 15,
    ),
    receiptsWidgetConfig: ReceiptsWidgetConfig(
      showReceiptsIn: ShowReceiptsIn.all,
      lastSeenAgoBuilder: (message, formattedDate) {
        String lastSeenText = formattedDate == "now"
            ? "vu à l'instant"
            : "vu, il y a ${formattedDate.split(' ')[0]} ${formattedDate.split(' ')[1]}";
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Text(
            lastSeenText,
            style: GoogleFonts.poiretOne(
              letterSpacing: 0.025,
              fontSize: 9,
            ),
          ),
        );
      },
    ),
    onMessageRead: (message) {},
  );
}
