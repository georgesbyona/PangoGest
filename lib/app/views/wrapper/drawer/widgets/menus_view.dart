import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../../controllers/controllers.dart';
import '../../../../shared/shared.dart';
import '../../../views.dart';
import 'about_dialog.dart';

class MenusView extends StatelessWidget {
  const MenusView(
      {super.key,
      required this.controller,
      required this.height,
      required this.width});

  final MainController controller;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = width > height ? height : width;
    final inverseColor = theme.colorScheme.inversePrimary;
    List<String> titles = [
      'Termes & Conditions',
      'Aide & Feedback',
      'A propos',
    ];
    List icons = [
      AppIcons.privacy,
      AppIcons.help,
      AppIcons.about,
    ];
    List iconsSuff = [
      Iconsax.arrow_right_3_outline,
      Iconsax.message_question_outline,
      Clarity.devices_line,
    ];
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 0, left: 5),
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Column(
              children: List.generate(
                icons.length,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TermsAndConditions(),
                          ),
                        );
                      } else if (index == 1) {
                        showDialog(
                          context: context,
                          builder: (context) => customDialogView(
                            context,
                            title: "Aide & FeedBack",
                            hintText: "Envoyez nous vos préoccupations ...",
                          ),
                        );
                      } else if (index == 2) {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            backgroundColor: theme.highlightColor,
                            child: const AboutDialogBody(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.transparent,
                      margin: EdgeInsets.only(
                        bottom: index + 1 == icons.length
                            ? height * 0.015
                            : height * 0.025,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(icons[index], size: 20),
                              const Gap(15),
                              Text(
                                titles[index],
                                style: theme.textTheme.bodySmall!.copyWith(
                                  fontSize: size * 0.027,
                                ),
                              ),
                            ],
                          ),
                          Icon(iconsSuff[index], size: 15),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(AppIcons.darkMode),
                    const Gap(15),
                    Text(
                      'Thème sombre',
                      style: theme.textTheme.bodySmall!.copyWith(
                        fontSize: size * 0.027,
                      ),
                    ),
                  ],
                ),
                Switch(
                  trackOutlineWidth: const WidgetStatePropertyAll(20),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: controller.isDark,
                  activeColor: inverseColor,
                  inactiveThumbColor: inverseColor,
                  inactiveTrackColor: inverseColor.withOpacity(0.5),
                  onChanged: (value) => controller.changeThemeMode(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
