import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../../controllers/controllers.dart';
import '../../../../shared/shared.dart';
import '../../../views.dart';
import 'about_dialog.dart';

class MenusView extends StatelessWidget {
  const MenusView({super.key, required this.controller});

  final MainController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
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
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: width * 0.05,
            left: width * 0.06,
            right: width * 0.06,
          ),
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
                    margin: EdgeInsets.only(bottom: height * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              icons[index],
                              size: width * 0.05,
                            ),
                            Gap(width * 0.03),
                            Text(
                              titles[index],
                              style: theme.textTheme.bodyMedium!.copyWith(
                                fontSize: width * 0.028,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          iconsSuff[index],
                          size: width * 0.03,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: width * 0.06,
            right: width * 0.04,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    AppIcons.darkMode,
                    size: width * 0.05,
                  ),
                  Gap(width * 0.025),
                  Text(
                    'Thème sombre',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontSize: width * 0.028,
                    ),
                  ),
                ],
              ),
              Switch(
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
    );
  }
}
