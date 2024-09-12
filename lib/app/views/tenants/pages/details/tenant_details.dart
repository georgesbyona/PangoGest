import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../data/data.dart';
import 'widgets/actions_view.dart';
import 'widgets/blur_container.dart';
import 'widgets/body_view.dart';
import 'widgets/head_view.dart';

class TenantDetailsPage extends StatelessWidget {
  const TenantDetailsPage({
    super.key,
    required this.index,
    required this.tenants,
  });

  final List<UserModel> tenants;
  final int index;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    final house = houses.where(
      (house) => house.id == tenants[index].maisonID,
    );
    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: house.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: house.first.photo,
                      progressIndicatorBuilder: (context, url, progress) {
                        return Container(
                          height: 250,
                          width: width,
                          color: theme.highlightColor,
                        );
                      },
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          height: 240,
                          width: width,
                          decoration: BoxDecoration(
                            color: theme.highlightColor,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      errorWidget: (context, url, progress) {
                        return Container(
                          height: 250,
                          width: width,
                          color: theme.highlightColor,
                        );
                      },
                    )
                  : Container(
                      height: 250,
                      width: width,
                      color: theme.highlightColor,
                    ),
            ),
            if (house.isNotEmpty) blurContainer(width, theme),
            Column(
              children: [
                HeadView(tenants: tenants, index: index),
                BodyView(house: house),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: ActionsView(index: index, tenants: tenants),
    );
  }
}
