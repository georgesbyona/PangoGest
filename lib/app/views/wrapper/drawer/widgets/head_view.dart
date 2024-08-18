import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../controllers/controllers.dart';
import '../../../views.dart';

class HeadView extends StatelessWidget {
  const HeadView({super.key, required this.userData});

  final UserDataController userData;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return Column(
      children: [
        SizedBox(
          height: height * 0.26,
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
                  width: width * 0.3,
                  height: width * 0.3,
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
        Gap(height * 0.02),
        Text(userData.names!),
        Text(
          userData.email!,
          style: theme.textTheme.bodySmall!.copyWith(
            color: theme.unselectedWidgetColor,
            height: 2,
          ),
        ),
        Gap(height * 0.01),
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
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.025,
              vertical: height * 0.005,
            ),
            child: Text(
              "Voir le profil",
              style: theme.textTheme.bodySmall!.copyWith(
                color: theme.primaryColor,
                height: 2,
              ),
            ),
          ),
        ),
        Gap(height * 0.02),
      ],
    );
  }
}
