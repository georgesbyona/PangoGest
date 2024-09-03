import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
                  decoration: const BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(100),
                      bottomRight: Radius.circular(100),
                    ),
                  ),
                  padding: const EdgeInsets.only(
                    top: 15,
                    left: 25,
                    bottom: 15,
                  ),
                  margin: EdgeInsets.only(
                    top: height * 0.05,
                    right: width * 0.03,
                    bottom: height * 0.05,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(AppIcons.logout, color: AppColors.black),
                      const Gap(15),
                      Text(
                        "Se déconnecter",
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
