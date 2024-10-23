import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// import '../pages/details/tenant_details.dart';
import '../../../shared/shared.dart';
import '../../../../data/data.dart';

class TenantDescriptions extends StatelessWidget {
  const TenantDescriptions({
    super.key,
    required this.index,
    required this.tenants,
  });

  final List<UserModel> tenants;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${tenants[index].firstName} ${tenants[index].lastName}",
            style: theme.textTheme.bodyMedium!.copyWith(fontSize: 16),
          ),
          if (tenants[index].email.isNotEmpty) ...{
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
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: 'Maison : '),
                TextSpan(
                  text: "N° ${tenants[index].addressID}",
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
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => TenantDetailsPage(
              //       tenants: tenants,
              //       index: index,
              //     ),
              //   ),
              // );
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "voir le détails",
                    style: GoogleFonts.indieFlower(
                      decorationColor: theme.colorScheme.inverseSurface,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const Icon(AppIcons.more2, size: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
