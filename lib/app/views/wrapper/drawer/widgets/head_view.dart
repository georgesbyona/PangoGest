import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pangogest/app/shared/shared.dart';

import '../../../../../controllers/controllers.dart';
import '../../../views.dart';

class HeadView extends StatelessWidget {
  const HeadView({
    super.key,
    required this.user,
    required this.height,
    required this.width,
  });

  final UserDataController user;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = width > height ? height : width;
    return Column(
      children: [
        SizedBox(
          height: height * 0.25,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: height * 0.2,
                color: theme.highlightColor,
              ),
              Positioned(
                bottom: 0,
                child: CachedNetworkImage(
                  width: size * 0.25,
                  imageUrl: user.imgUrl!,
                  alignment: Alignment.center,
                  color: theme.unselectedWidgetColor,
                  progressIndicatorBuilder: (context, url, progress) {
                    return Container(
                      width: size * 0.25,
                      height: size * 0.25,
                      decoration: BoxDecoration(
                        color: theme.highlightColor,
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      alignment: Alignment.center,
                      width: size * 0.25,
                      height: size * 0.25,
                      decoration: BoxDecoration(
                        color: theme.unselectedWidgetColor,
                        border: Border.all(
                          color: theme.highlightColor,
                          width: 3,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        AppIcons.profileB,
                        size: size * 0.1,
                        color: theme.primaryColorDark,
                      ),
                    );
                  },
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: size * 0.25,
                      height: size * 0.25,
                      decoration: BoxDecoration(
                        color: theme.unselectedWidgetColor,
                        border: Border.all(
                          color: theme.highlightColor,
                          width: 3,
                        ),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Gap(height * 0.025),
        Text(user.names!),
        Text(
          user.email!,
          style: theme.textTheme.bodySmall!.copyWith(
            color: theme.unselectedWidgetColor,
            height: 2,
          ),
        ),
        Gap(height * 0.025),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfilePage(),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(100),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              "Voir le profil",
              style: theme.textTheme.bodySmall!.copyWith(
                color: theme.primaryColor,
                height: 2,
              ),
            ),
          ),
        ),
        Gap(height * 0.025),
      ],
    );
  }
}
