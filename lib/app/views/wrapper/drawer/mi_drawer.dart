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
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return Container(
      width: width * 0.7,
      color: theme.scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              HeadView(userData: userData),
              MenusView(controller: controller),
            ],
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
              padding: EdgeInsets.symmetric(vertical: height * 0.02),
              margin: EdgeInsets.symmetric(
                vertical: height * 0.05,
                horizontal: width * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(AppIcons.logout, color: AppColors.black),
                  Text(
                    "  Se déconnecter",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: AppColors.black,
                      fontSize: width * 0.03,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
