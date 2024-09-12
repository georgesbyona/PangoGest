import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controllers/controllers.dart';
import '../../../shared/shared.dart';

ChatViewAppBar chatAppBar({
  ThemeData? theme,
  MainController? controller,
  ChatController? chatController,
}) {
  final firstLetter = chatController!.otherUsers.first.name.substring(0, 1);
  return ChatViewAppBar(
    elevation: 0,
    chatTitle: chatController.otherUsers.first.name,
    imageType: ImageType.network,
    profilePicture: chatController.otherUsers.first.profilePhoto,
    networkImageProgressIndicatorBuilder: (context, url, error) {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: theme.unselectedWidgetColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          AppIcons.profileB,
          color: theme.primaryColorDark,
          size: 20,
        ),
      );
    },
    networkImageErrorBuilder: (context, url, error) {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: theme.unselectedWidgetColor,
          shape: BoxShape.circle,
        ),
        child: Text(
          firstLetter,
          style: GoogleFonts.indieFlower(
            color: theme.colorScheme.inversePrimary,
            fontSize: 20,
          ),
        ),
      );
    },
    assetImageErrorBuilder: (context, url, error) {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: theme.unselectedWidgetColor,
          shape: BoxShape.circle,
        ),
        child: Text(
          firstLetter,
          style: GoogleFonts.indieFlower(
            color: theme.colorScheme.inversePrimary,
            fontSize: 20,
          ),
        ),
      );
    },
    backGroundColor: theme!.scaffoldBackgroundColor,
    backArrowColor: theme.colorScheme.inversePrimary,
    chatTitleTextStyle: GoogleFonts.raleway(
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
      fontSize: 15,
    ),
    userStatus: "en ligne",
    userStatusTextStyle: GoogleFonts.poiretOne(
      fontWeight: FontWeight.bold,
      color: Colors.green,
      letterSpacing: 1,
      fontSize: 12,
    ),
    actions: [
      GestureDetector(
        onTap: () {
          controller!.changeThemeMode();
        },
        child: Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.only(right: 12),
          child: Image.asset(AppImages.logo),
        ),
      ),
    ],
  );
}
