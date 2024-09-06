import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../data/data.dart';
import '../../../../../shared/shared.dart';

class HeadView extends StatelessWidget {
  const HeadView({
    super.key,
    required this.index,
    required this.tenants,
  });

  final List<TenantModel> tenants;
  final int index;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return SafeArea(
      child: Container(
        height: 250,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: theme.colorScheme.inversePrimary,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CachedNetworkImage(
                  imageUrl: tenants[index].imgUrl,
                  progressIndicatorBuilder: (context, url, progress) {
                    return Container(
                      width: 125,
                      height: 125,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: theme.unselectedWidgetColor,
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                  errorWidget: (context, url, progress) {
                    return Container(
                      width: 125,
                      height: 125,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
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
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 125,
                      height: 125,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: theme.unselectedWidgetColor,
                        border: Border.all(
                          color: theme.scaffoldBackgroundColor,
                          width: 2,
                        ),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tenants[index].names,
                      style: theme.textTheme.bodyMedium!.copyWith(fontSize: 16),
                    ),
                    if (tenants[index].email!.isNotEmpty) ...{
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(text: 'Email : '),
                            TextSpan(
                              text: tenants[index].email,
                              style: GoogleFonts.indieFlower(),
                            ),
                          ],
                        ),
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.unselectedWidgetColor,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    } else ...{
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(text: 'Email : '),
                            TextSpan(
                              text: "---",
                              style: GoogleFonts.indieFlower(),
                            ),
                          ],
                        ),
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.unselectedWidgetColor,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    },
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: 'N° Tél : '),
                          TextSpan(
                            text: tenants[index].num,
                            style: GoogleFonts.indieFlower(),
                          ),
                        ],
                      ),
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.unselectedWidgetColor,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
