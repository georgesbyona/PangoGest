import 'package:flutter/material.dart';

import '../../../../controllers/controllers.dart';
import '../../../shared/shared.dart';
import 'widgets/head_view.dart';
import 'widgets/menus_view.dart';

class MiDrawer extends StatelessWidget {
  const MiDrawer({
    super.key,
    required this.userData,
    required this.controller,
  });

  final MainController controller;
  final UserDataController userData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;
        final size = constraints.maxWidth > constraints.maxHeight
            ? constraints.maxHeight
            : constraints.maxWidth;
        return Container(
          width: size * 0.7,
          height: height,
          color: theme.scaffoldBackgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    HeadView(
                      userData: userData,
                      height: height,
                      width: width,
                    ),
                    MenusView(
                      controller: controller,
                      height: height,
                      width: width,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await userData.signOutUser();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  margin: EdgeInsets.symmetric(
                    horizontal: width * 0.03,
                    vertical: height * 0.05,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(AppIcons.logout, color: AppColors.black),
                      Text(
                        "  Se déconnecter",
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
