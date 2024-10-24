import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

import '../../../controllers/controllers.dart';
import 'widgets/bottom_boxes_view.dart';
import 'widgets/chart_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserDataController>(context);
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final size = height > width ? height : width;
    final theme = Theme.of(context);
    final txtTheme = theme.textTheme;
    return user.userType == "locataire"
        ? Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Voici les informations principales de votre maison d'habitation !",
                  style: txtTheme.titleSmall!.copyWith(fontSize: 20),
                ),
                const Gap(15),
                user.tenantHouse == null
                    ? Container(
                        height: 250,
                        width: width * 0.8,
                        decoration: BoxDecoration(
                          color: theme.unselectedWidgetColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      )
                    : CachedNetworkImage(
                        imageUrl: user.tenantHouse!.photo,
                        color: Theme.of(context).unselectedWidgetColor,
                        errorWidget: (context, url, error) {
                          return Container(
                            height: 250,
                            decoration: BoxDecoration(
                              color:
                                  theme.unselectedWidgetColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://firebasestorage.googleapis.com/v0/b/pangogest.appspot.com/o/demo-houses%2F04.jpg?alt=media&token=1a1938f3-2312-44b1-8711-967fdc6246c4",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        imageBuilder: (context, imageProvider) {
                          return GestureDetector(
                            onTap: () {
                              debugPrint("Starting default live activity");
                              OneSignal.LiveActivities.startDefault(
                                  "nouveau message", {
                                "title": "Welcome!"
                              }, {
                                "message": {"fr": "Salut tous!"},
                                "intValue": 3,
                                "doubleValue": 3.14,
                                "boolValue": true
                              });
                            },
                            child: Container(
                              height: 250,
                              decoration: BoxDecoration(
                                color: theme.unselectedWidgetColor
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                        progressIndicatorBuilder: (context, url, progress) {
                          return Container(
                            height: 250,
                            width: width * 0.8,
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  theme.unselectedWidgetColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          );
                        },
                      ),
                const Gap(20),
                Expanded(
                  child: ListView(
                    children: [
                      user.tenantHouse == null
                          ? Text(
                              "Adresse : ",
                              style: txtTheme.bodySmall!.copyWith(
                                fontSize: 15,
                              ),
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Adresse : ",
                                  style: txtTheme.bodySmall!.copyWith(
                                    fontSize: 15,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "N° ${user.address!.num} Av. ${user.address!.avenue}",
                                    ),
                                    Text("Q. ${user.address!.quartier}"),
                                    Text("C. ${user.address!.commune}"),
                                    Text("V. ${user.address!.ville}"),
                                  ],
                                ),
                              ],
                            ),
                      const Gap(20),
                      user.tenantHouse == null
                          ? TenantBottomBoxesView(surface: "", price: "")
                          : TenantBottomBoxesView(
                              surface: user.tenantHouse!.surface,
                              price: user.tenantHouse!.price,
                            ),
                    ],
                  ),
                )
              ],
            ),
          )
        : Container(
            alignment: Alignment.center,
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.only(bottom: 30),
                  height: size * 0.43,
                  child: const Card(
                    child: Center(
                      child: MiPieChart(),
                    ),
                  ),
                ),
                const BottomBoxesView(),
              ],
            ),
          );
  }
}
