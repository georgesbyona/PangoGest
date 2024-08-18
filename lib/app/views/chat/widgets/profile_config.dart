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
      return const Icon(AppIcons.profile);
    },
    networkImageProgressIndicatorBuilder: (context, url, progress) {
      return CircularProgressIndicator(
        color: theme.primaryColor,
        value: progress.progress,
      );
    },
    onAvatarTap: (p0) {
      debugPrint('============== Avatar is typed !');
    },
  );
}
