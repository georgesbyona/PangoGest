import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';

class AboutDialogBody extends StatelessWidget {
  const AboutDialogBody({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final size = width > height ? height : width;
    final theme = Theme.of(context);
    Map infos = {
      "Version de l'App : ": "1.0.0",
      "Version d'Android : ": "11+",
      'Dernière Mise en jour : ': "31 Juillet 2024",
    };
    return Container(
      padding: EdgeInsets.all(size * 0.07),
      height: height * 0.53,
      child: Column(
        children: [
          SizedBox(
            width: size * 0.2,
            height: size * 0.2,
            child: Image.asset(AppImages.logo),
          ),
          Gap(height * 0.02),
          Text(
            "PangoGest",
            style:
                theme.textTheme.displaySmall!.copyWith(fontSize: size * 0.04),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(width * 0.03),
              Text(
                "Une application mobile de mise en contact des deux parties entrant dans la scène des maison à louer ...",
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              Gap(size * 0.01),
              Text(
                "- En donnant une flexibilité aux propriétaire de pouvoir avoir la main proche sur la gérance de leurs différentes maisons, de rappel sur l'évolution de leurs différentes maisons, ...",
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.start,
              ),
              Gap(size * 0.01),
              Text(
                "- Aux locataires de pouvoir vérifier d'une manière continue leur contrat, les dates clés pour différentes actions, ...",
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.start,
              ),
              Gap(size * 0.025),
              for (String info in infos.keys) ...{
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      info,
                      style: theme.textTheme.bodySmall!.copyWith(
                        fontSize: width * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      infos[info],
                      style: theme.textTheme.bodySmall!.copyWith(
                        fontSize: width * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Gap(size * 0.01),
              },
            ],
          ),
          Gap(size * 0.05),
          socialmediaView(width, theme, context),
        ],
      ),
    );
  }
}
