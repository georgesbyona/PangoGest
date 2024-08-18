import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/shared.dart';

class AboutDialogBody extends StatelessWidget {
  const AboutDialogBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    Map infos = {
      "Version de l'App : ": "0.1.0",
      "Version d'Android : ": "11+",
      'Dernière Mise en jour : ': "31 Juillet 2024",
    };
    return Container(
      padding: EdgeInsets.all(width * 0.07),
      height: height * 0.5,
      child: Column(
        children: [
          SizedBox(
            width: width * 0.2,
            height: width * 0.2,
            child: Image.asset(AppImages.logo),
          ),
          Gap(height * 0.02),
          Text(
            "PangoGest",
            style:
                theme.textTheme.displaySmall!.copyWith(fontSize: width * 0.04),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(width * 0.03),
              Text(
                "Une app conçue dans l'idée d'aider les collègues étudiants à optimiser leurs études, révisions, exercices, ...\nEn regroupant un ensemble des anciens questionnaires d'examens, d'interrogations, de TP, ...",
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              Gap(width * 0.05),
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
                Gap(height * 0.005),
              },
            ],
          ),
          Gap(height * 0.02),
          Text(
            "Pour plus de détails, visitez :",
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          Gap(width * 0.01),
          GestureDetector(
            onTap: () async {
              const url = 'https://g-losingson.github.io/JifunzApp/';
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              }
            },
            child: Text(
              "jifunzapp.com",
              style: theme.textTheme.bodySmall!.copyWith(
                color: Colors.blue,
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Gap(width * 0.05),
          socialmediaView(width, theme, context),
        ],
      ),
    );
  }
}
