import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../controllers/controllers.dart';
import '../../../views.dart';

class HeadView extends StatelessWidget {
  const HeadView({
    super.key,
    required this.userData,
    required this.height,
    required this.width,
  });

  final UserDataController userData;
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
                child: Container(
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
                      image: NetworkImage(userData.imgUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Gap(height * 0.025),
        Text(userData.names!),
        Text(
          userData.email!,
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
