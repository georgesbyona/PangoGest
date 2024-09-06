import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../data/data.dart';
import '../../../shared/shared.dart';

class TenantNetworkImageView extends StatelessWidget {
  const TenantNetworkImageView({
    super.key,
    required this.index,
    required this.tenants,
  });

  final List<TenantModel> tenants;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CachedNetworkImage(
      alignment: Alignment.center,
      color: theme.unselectedWidgetColor,
      imageUrl: tenants[index].imgUrl,
      progressIndicatorBuilder: (context, url, progress) {
        return Container(
          alignment: Alignment.center,
          width: 80,
          height: 80,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: theme.unselectedWidgetColor.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
        );
      },
      imageBuilder: (context, imageProvider) {
        return Container(
          width: 80,
          height: 80,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: theme.unselectedWidgetColor,
            shape: BoxShape.circle,
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
          width: 80,
          height: 80,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: theme.unselectedWidgetColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            AppIcons.profileB,
            color: theme.primaryColorDark,
            size: 35,
          ),
        );
      },
    );
  }
}
