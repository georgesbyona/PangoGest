import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../shared/shared.dart';
import '../../../../data/data.dart';

class HouseImageViewNetwork extends StatelessWidget {
  const HouseImageViewNetwork({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CachedNetworkImage(
      alignment: Alignment.center,
      color: theme.unselectedWidgetColor,
      imageUrl: houses[index].photo,
      progressIndicatorBuilder: (context, url, progress) {
        return Container(
          alignment: Alignment.center,
          width: 150,
          height: 120,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: theme.unselectedWidgetColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(15),
          ),
        );
      },
      imageBuilder: (context, imageProvider) {
        return Container(
          width: 150,
          height: 120,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: theme.unselectedWidgetColor,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          alignment: Alignment.center,
          width: 150,
          height: 120,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: theme.unselectedWidgetColor,
            borderRadius: BorderRadius.circular(15),
            image: const DecorationImage(
              image: AssetImage(AppImages.bckground),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
