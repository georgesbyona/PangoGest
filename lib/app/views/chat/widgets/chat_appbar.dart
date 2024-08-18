import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../controllers/controllers.dart';
import '../../../shared/shared.dart';

ChatViewAppBar chatAppBar({
  ThemeData? theme,
  MainController? controller,
  ChatController? chatController,
}) {
  return ChatViewAppBar(
    elevation: 0,
    chatTitle: chatController!.otherUsers.first.name,
    imageType: ImageType.network,
    profilePicture: chatController.otherUsers.first.profilePhoto,
    networkImageErrorBuilder: (context, url, error) {
      return CachedNetworkImage(
        imageUrl: chatController.currentUser.profilePhoto!,
        errorWidget: (context, url, error) => const Icon(AppIcons.profile),
        progressIndicatorBuilder: (context, url, progress) {
          return CircularProgressIndicator(
            strokeWidth: 1,
            value: progress.progress,
          );
        },
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
          // debugPrint(_chatController!.initialMessageList.last.message);
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
