import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';

import '../../../shared/shared.dart';

ProfileCircleConfiguration profileConfig(
  ThemeData theme,
  ChatController chatController,
) {
  return ProfileCircleConfiguration(
    bottomPadding: 0,
    imageType: ImageType.network,
    profileImageUrl: chatController.currentUser.profilePhoto,
    networkImageErrorBuilder: (context, url, error) {
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
    onAvatarTap: (p0) {
      debugPrint('============== Avatar is typed !');
    },
  );
}
