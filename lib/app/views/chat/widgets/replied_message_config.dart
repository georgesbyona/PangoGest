import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controllers/controllers.dart';

RepliedMessageConfiguration repliedMsgConfig({
  double? width,
  ThemeData? theme,
  ChatController? chatController,
  UserDataController? user,
}) {
  return RepliedMessageConfiguration(
    repliedMsgAutoScrollConfig: const RepliedMsgAutoScrollConfig(
      enableHighlightRepliedMsg: false,
      enableScrollToRepliedMsg: false,
    ),
    repliedMessageWidgetBuilder: (replyMessage) {
      final isRigth = replyMessage!.replyBy == user!.email;
      final otherName = chatController!.otherUsers.first.name.split(' ')[0];
      final replyName = isRigth ? otherName : user.names!.split(' ')[0];
      return isRigth
          ? rightRepliedMessageWidget(
              theme: theme,
              width: width,
              replyName: replyName,
              userEmail: user.email,
              replyMessage: replyMessage,
            )
          : leftRepliedMessageWidget(
              theme: theme,
              width: width,
              replyName: replyName,
              replyMessage: replyMessage,
              otherName: otherName,
              otherEmail: chatController.otherUsers.first.id,
            );
    },
  );
}

Container leftRepliedMessageWidget({
  ThemeData? theme,
  double? width,
  String? replyName,
  String? otherName,
  String? otherEmail,
  ReplyMessage? replyMessage,
}) {
  final replyText = otherEmail == replyMessage!.replyTo
      ? Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Message de ",
                style: GoogleFonts.poiretOne(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 10,
                ),
              ),
              TextSpan(
                text: otherName,
                style: GoogleFonts.raleway(
                  letterSpacing: 1,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        )
      : Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Message de ",
                style: GoogleFonts.poiretOne(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 10,
                ),
              ),
              TextSpan(
                text: replyName,
                style: GoogleFonts.raleway(
                  letterSpacing: 1,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        );
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          theme!.primaryColor.withOpacity(0.3),
          theme.primaryColor.withOpacity(0.2),
          theme.primaryColor.withOpacity(0.1),
          Colors.transparent,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      border: Border(
        left: BorderSide(
          color: theme.primaryColor.withOpacity(0.5),
          width: 2.5,
        ),
      ),
    ),
    padding: const EdgeInsets.only(left: 5),
    margin: EdgeInsets.only(
      left: 15,
      bottom: 5,
      right: width! * 0.25,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        replyText,
        Container(
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Text(
            replyMessage.message,
            style: GoogleFonts.raleway(
              fontWeight: FontWeight.normal,
              letterSpacing: 0.025,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}

Container rightRepliedMessageWidget({
  double? width,
  ThemeData? theme,
  String? userEmail,
  String? replyName,
  ReplyMessage? replyMessage,
}) {
  final replyText = userEmail == replyMessage!.replyTo
      ? Text(
          "Ton message",
          style: GoogleFonts.poiretOne(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            fontSize: 10,
          ),
        )
      : Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Message de ",
                style: GoogleFonts.poiretOne(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 10,
                ),
              ),
              TextSpan(
                text: replyName,
                style: GoogleFonts.raleway(
                  letterSpacing: 1,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        );
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          theme!.colorScheme.inverseSurface.withOpacity(0.3),
          theme.colorScheme.inverseSurface.withOpacity(0.2),
          theme.colorScheme.inverseSurface.withOpacity(0.1),
          Colors.transparent,
        ],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
      ),
      border: Border(
        right: BorderSide(
          color: theme.colorScheme.inverseSurface,
          width: 2.5,
        ),
      ),
    ),
    padding: const EdgeInsets.only(right: 5),
    margin: EdgeInsets.only(
      right: 15,
      bottom: 5,
      left: width! * 0.25,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        replyText,
        Container(
          decoration: BoxDecoration(
            color: theme.primaryColorDark,
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Text(
            replyMessage.message,
            style: GoogleFonts.raleway(
              fontWeight: FontWeight.normal,
              letterSpacing: 0.025,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}
